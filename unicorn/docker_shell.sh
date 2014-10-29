#!/bin/bash
source ./docker_setting.sh

$DOCKER_BIN_NAME run --rm -t -i -v $DOCKER_RACK_DIR:/var/rack --net=host $DOCKER_IMAGE_NAME bash -l
