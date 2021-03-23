#!/usr/bin/env bash

# shell.sh

# run the container in the background
# /data is persisted using a named container

docker run \
    --hostname PCC-AC \
    --rm \
    -it \
    -v $(pwd)/certs:/certs/actions \
    --name="ac-patrick" \
    ac-patrick \
    /bin/bash
