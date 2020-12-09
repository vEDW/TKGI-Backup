#!/bin/bash

source ../env_epmc
filename=$(date +%Y-%m-%d-%H%M-opsmanexport)
om -t https://${OPSMANAGER} -u "${ADMIN}" -p "${OPSMANAGERPWD}" export-installation --output-file $filename

