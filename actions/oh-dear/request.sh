#!/usr/bin/env bash

apiToken="${OH_DEAR_API_TOKEN}"
operation="${OH_DEAR_OPERATION}"
tolerateRateLimit="${OH_DEAR_TOLERATE_RATE_LIMIT}"
url="${OH_DEAR_URL}"

headerFile="$(mktemp)"
bodyFile="$(mktemp)"

trap 'rm -f "${headerFile}" "${bodyFile}"' EXIT

status="$(curl --url "${url}" \
  --dump-header "${headerFile}" \
  --header "Accept: application/json" \
  --header "Authorization: Bearer ${apiToken}" \
  --header "Content-Type: application/json" \
  --output "${bodyFile}" \
  --request POST \
  --show-error \
  --silent \
  --write-out "%{http_code}")" || true

if [[ -z ${status} ]]; then
    status="000"
fi

# Oh Dear explains a rate-limited request in the response body rather than in a
# "Retry-After" header, so the body is reported along with the status. It has
# two independent limits: a per-check cooldown, which is what declines a run
# request, and a budget of "x-ratelimit-limit" requests, which is not.
body="$(tr '\r\n' '  ' < "${bodyFile}" | tr -s ' ' | cut -c -500)"
retryAfter="$(grep --ignore-case '^retry-after:' "${headerFile}" | tr -d '\r\n' | cut -d ' ' -f 2- || true)"

response="Oh Dear responded with HTTP ${status}"

if [[ -n ${retryAfter} ]]; then
    response="${response}, asking to retry after \"${retryAfter}\""
fi

if [[ -n ${body// /} ]]; then
    response="${response}, and with \"${body}\""
fi

case "${status}" in
    2*)
        echo "${operation} succeeded."

        exit 0
        ;;
    429)
        # Only the per-check cooldown declines a run request, and it does not
        # send a "Retry-After" header, whereas exhausting the request budget
        # does. Tolerating the latter would let a workflow continue as if a
        # check run had been requested, when none was.
        if [[ true = "${tolerateRateLimit}" ]] && [[ -z ${retryAfter} ]]; then
            echo "::warning::${operation} was rate-limited: ${response}. Not failing, since Oh Dear rate-limits a request when it has recently accepted an equivalent one."

            exit 0
        fi

        echo "::error::${operation} was rate-limited: ${response}."

        exit 1
        ;;
esac

echo "::error::${operation} failed: ${response}."

exit 1
