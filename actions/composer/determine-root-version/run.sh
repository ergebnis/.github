#!/usr/bin/env bash

branch="${COMPOSER_DETERMINE_ROOT_VERSION_BRANCH}"
workingDirectory="${COMPOSER_DETERMINE_ROOT_VERSION_WORKING_DIRECTORY}"

if [[ ! -d ${workingDirectory} ]]; then
  echo "::error::The value for the \"working-directory\" input needs to be an existing directory. The directory \"${workingDirectory}\" does not exist."

  exit 1;
fi

pathToComposerJsonFile="${COMPOSER_DETERMINE_ROOT_VERSION_WORKING_DIRECTORY}/composer.json"

if [[ ! -f "${pathToComposerJsonFile}" ]]; then
    echo "::error::A composer.json file could not be found in the directory \"${workingDirectory}\"."

    exit 1
fi

COMPOSER_ROOT_VERSION=$(jq --arg key "dev-${branch}" --raw-output '.["extra"]["branch-alias"][$key]' "${pathToComposerJsonFile}")

if [[ null = "${COMPOSER_ROOT_VERSION}" ]]; then
    echo "::error:A branch alias has not been defined in \"${pathToComposerJsonFile}\" for branch \"${branch}\"."

    exit 0
fi

echo "COMPOSER_ROOT_VERSION=${COMPOSER_ROOT_VERSION}" >> "${GITHUB_ENV}"
