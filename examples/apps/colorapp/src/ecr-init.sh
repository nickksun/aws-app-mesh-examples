#!/bin/sh -e

TAG=$(git describe --abbrev=0 --tags)

packages=(
    "colorteller"
    "gateway"
    # "exporter"
    "prometheus"
)
namespace="$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com"


i=0
total=${#packages[@]}
for pkg in ${packages[@]}; do
    ((i++))
    image=pkg
    aws ecr create-repository --repository-name $image
done