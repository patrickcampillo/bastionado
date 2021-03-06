#!/usr/bin/env bash

# run.sh

# run the container in the background
# /data is persisted using a named container
#-v certs:/certs \

docker run \
    --detach \
    --hostname PCC-AC \
    --rm \
    -v $(pwd)/certs:/certs/actions \
    --name="ac-patrick" \
    ac-patrick \
    $1 $2
