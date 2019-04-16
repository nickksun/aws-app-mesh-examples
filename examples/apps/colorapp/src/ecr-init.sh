#!/bin/sh -e

packages=(
    "colorteller"
    "gateway"
    "prometheus"
)
namespace="$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com"

for pkg in ${packages[@]}; do
    aws ecr create-repository --repository-name $pkg
done