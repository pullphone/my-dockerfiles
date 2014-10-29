#!/bin/bash
source ./docker_setting.sh

$DOCKER_BIN_NAME stop $DOCKER_CONTAINER_NAME
$DOCKER_BIN_NAME rm $DOCKER_CONTAINER_NAME
$DOCKER_BIN_NAME run -v $DOCKER_RACK_DIR:/var/rack -d --net=host --name $DOCKER_CONTAINER_NAME $DOCKER_IMAGE_NAME
