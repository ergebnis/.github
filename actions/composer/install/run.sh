#!/usr/bin/env bash

dependencies="${COMPOSER_INSTALL_DEPENDENCIES}"
workingDirectory="${COMPOSER_INSTALL_WORKING_DIRECTORY}"

if [[ ! -d ${workingDirectory} ]]; then
  echo "::error::The value for the \"working-directory\" input needs to be an existing directory. The directory \"${workingDirectory}\" does not exist."

  exit 1;
fi

if [[ ${dependencies} == "lowest" ]]; then
  composer update --ansi --no-interaction --no-progress --prefer-lowest -working-dir="${workingDirectory}"

  exit $?
fi

if [[ ${dependencies} == "locked" ]]; then
  composer install --ansi --no-interaction --no-progress -working-dir="${workingDirectory}"

  exit $?
fi

if [[ ${dependencies} == "highest" ]]; then
  composer update --ansi --no-interaction --no-progress -working-dir="${workingDirectory}"

  exit $?
fi

echo "::error::The value for the \"dependencies\" input needs to be one of \"lowest\", \"locked\", \"highest\" - got \"${dependencies}\" instead."

exit 1
