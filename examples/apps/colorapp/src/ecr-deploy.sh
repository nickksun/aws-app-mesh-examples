#!/bin/sh -e

TAG="latest"

packages=(
    "colorteller"
    "gateway"
    # "exporter"
    "prometheus"
)

$(aws ecr get-login --no-include-email --region $AWS_REGION)

namespace="$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com"


i=0
total=${#packages[@]}
for pkg in ${packages[@]}; do
    cd $pkg && ./deploy.sh && cd ..
done
