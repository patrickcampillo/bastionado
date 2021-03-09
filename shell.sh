#!/usr/bin/env bash

# shell.sh

# run the container in the background
# /data is persisted using a named container

docker run \
    --hostname PCC-AC \
    --rm \
    -it \
    --name="ac-patrick" \
    --mount type=bind,source="$(pwd)"/certs,target=/certs/actions \
    ac-patrick \
    /bin/bash
