#!/usr/bin/env bash

# Installs the binary of a getsentry/sentry-cli release, verified against the
# SHA-256 checksum GitHub publishes for the release asset, so the code that
# receives a Sentry auth token is pinned along with the action that runs this
# script. Updating sentry-cli means updating the version and both checksums.
#
# The binary goes into a directory in RUNNER_TEMP, which is added to
# GITHUB_PATH, and its path is written to GITHUB_OUTPUT as "path". When that
# directory already holds a binary with the expected checksum, for example
# because an earlier step of the same job ran this script, the download is
# skipped.

set -o errexit
set -o nounset
set -o pipefail

version="3.8.2"

case "${RUNNER_OS}/${RUNNER_ARCH}" in
    Linux/ARM64)
        asset="sentry-cli-Linux-aarch64"
        checksum="b6e49fca868a36d20da2ada1832a0ce2f9ac7012c128207518b09d6b6c991f4d"
        ;;
    Linux/X64)
        asset="sentry-cli-Linux-x86_64"
        checksum="c958865f9d4000183509ea21b1f04925d5390de6d8d87386b9e69f2b305070c3"
        ;;
    *)
        echo "::error::Installing sentry-cli is not supported on ${RUNNER_OS}/${RUNNER_ARCH}."

        exit 1
        ;;
esac

directory="${RUNNER_TEMP}/sentry-cli-${version}"
path="${directory}/sentry-cli"

if [[ -f ${path} ]] && echo "${checksum}  ${path}" | sha256sum --check --quiet --strict 2> /dev/null; then
    echo "sentry-cli ${version} is already installed."
else
    mkdir -p "${directory}"

    curl "https://github.com/getsentry/sentry-cli/releases/download/${version}/${asset}" \
      --fail \
      --location \
      --output "${path}" \
      --retry 3 \
      --retry-all-errors \
      --show-error \
      --silent

    if ! echo "${checksum}  ${path}" | sha256sum --check --strict; then
        rm -f "${path}"

        echo "::error::The checksum of ${asset} ${version} does not match the expected checksum."

        exit 1
    fi

    chmod +x "${path}"
fi

echo "${directory}" >> "${GITHUB_PATH}"
echo "path=${path}" >> "${GITHUB_OUTPUT}"
