#!/bin/bash

source env_epmc

if [[ ! -e $1 ]]; then
    echo "missing artifact path."
    exit
fi

# Verify your BBR Version : done with script 9_bbr_cli.sh

echo "getting bosh credentials"

BoshPASSWD=$( om -t https://${OPSMANAGER} -u "${ADMIN}" -p "${OPSMANAGERPWD}" -k curl -p /api/v0/deployed/director/credentials/director_credentials -s | jq '.[] | .value.password' | sed -e "s/\"//g" )
echo -e "director\n${BoshPASSWD}" | bosh -e pks log-in

BOSH_CLIENT_CREDENTIAL=$( om -t https://${OPSMANAGER} -u "${ADMIN}" -p "${OPSMANAGERPWD}" -k curl -p /api/v0/deployed/director/credentials/bosh_commandline_credentials -s | jq -r '.credential' )
export $BOSH_CLIENT_CREDENTIAL

echo
echo "Performing k8s cluster definition restore"

DeployGuid=$(echo $1 | cut -d'_' -f 1,2)
echo "deployment ID : " + $DeployGuid

nohup bbr deployment --target $DIRECTOR  --username $BOSH_CLIENT --deployment $DeployGuid --ca-cert ca.crt restore --artifact-path $1

echo "restore of TKGI control plane done"
echo
echo "please proceed with cluster recreation as needed using command :"
echo "pks upgrade-cluster CLUSTER-NAME"
echo