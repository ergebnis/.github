#!/usr/bin/env bash

stopMaintenanceAfterSeconds="${OH_DEAR_STOP_MAINTENANCE_AFTER_SECONDS}"

if [[ -z ${stopMaintenanceAfterSeconds} ]]; then
    echo "request-body=" >> "${GITHUB_OUTPUT}"

    exit 0
fi

# Oh Dear rejects a value below 5 seconds. Allowing at most 9 digits keeps the
# value within the range of integers that bash can compare.
if ! [[ ${stopMaintenanceAfterSeconds} =~ ^[1-9][0-9]{0,8}$ ]] || [[ ${stopMaintenanceAfterSeconds} -lt 5 ]]; then
    echo "::error::The value \"${stopMaintenanceAfterSeconds}\" of the input \"oh-dear-stop-maintenance-after-seconds\" is not an integer from 5 to 999999999."

    exit 1
fi

echo "request-body={\"stop_maintenance_after_seconds\":${stopMaintenanceAfterSeconds}}" >> "${GITHUB_OUTPUT}"
