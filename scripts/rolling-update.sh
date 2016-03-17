#! /bin/bash

set -eu

CTRL_BASENAME=jira
BASE_REPO="eu.gcr.io\/jira"
TARGET_COUNT=2
GKE_CMD="kubectl"
CTRL_CMD="kubectl"
POD_CMD="kubectl get pods"

#gcloud components update kubectl

# Some minimal protection against racy deploys
if [ $($CTRL_CMD get rc | grep -c $CTRL_BASENAME) -ne 1 ]; then
    echo "More than one replication controller deployed"
    exit 1
fi

OLD_CTRL_VERSION=$($CTRL_CMD get rc | grep $CTRL_BASENAME | sed -n "s/.*$BASE_REPO\/.*:\([^ ]*\).*/\1/p")
NEW_CTRL_VERSION=$CIRCLE_SHA1

if [ $OLD_CTRL_VERSION == $NEW_CTRL_VERSION ]; then
    echo "$NEW_CTRL_VERSION is already deployed"
    exit 1
fi

echo "Old version:" $OLD_CTRL_VERSION
echo "New version:" $NEW_CTRL_VERSION

CTRL_ID="$CTRL_BASENAME-$CTRL_VERSION" \
envsubst < jira/jira.yaml.template > jira/jira.yaml

kubectl rolling-update $CTRL_BASENAME -f jira/jira.yaml
