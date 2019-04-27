#!/usr/bin/env bash
# vim:syn=sh:ts=4:sw=4:et:ai

set -ex

if [ -z $STATS_EXPORTER_IMAGE ]; then
    echo "COLOR_TELLER_IMAGE environment variable is not set"
    exit 1
fi
mvn build
# build
docker build -t $STATS_EXPORTER_IMAGE .

# push
$(aws ecr get-login --no-include-email --region $AWS_REGION --profile $AWS_PROFILE)
docker push $STATS_EXPORTER_IMAGE
