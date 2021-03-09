#!/usr/bin/env bash

# run.sh

# run the container in the background
# /data is persisted using a named container

docker run \
    --detach \
    --hostname PCC-AC \
    --rm \
    -v certs:/certs \
    --name="ac-patrick" \
    ac-patrick
