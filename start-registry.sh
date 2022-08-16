#!/bin/bash
DOWNLOADED_FILES_PATH="${PWD}/registry/functions"
CAPSULE_REGISTRY_ADMIN_TOKEN="AZERTYUIOP" \
capsule-registry \
   -files="${DOWNLOADED_FILES_PATH}" \
   -httpPort=4999
