#!/usr/bin/env bash

set -e

DOCKERFILE="$NAME"

if [ "$NAME" == "latest" ] ; then
    DOCKERFILE="python3.9"
fi

use_tag="tiangolo/uvicorn-gunicorn:$NAME"
use_dated_tag="${use_tag}-$(date -I)"

bash scripts/docker-login.sh

docker buildx create --use

docker buildx build \
  --platform linux/amd64,linux/arm64,linux/arm/v7 \
  --file "./docker-images/${DOCKERFILE}.dockerfile" \
  -t "$use_tag"  \
  -t "$use_dated_tag"  \
  --push \
  "./docker-images/"
