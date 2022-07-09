#!/bin/bash

echo "Running Integration Test project in ${GITHUB_REPOSITORY}"
if [[ "${GITHUB_REPOSITORY}" != "mailcow/mailcow-dockerized" ]]; then
    echo "This can't be run in a fork"
    exit 1
fi
