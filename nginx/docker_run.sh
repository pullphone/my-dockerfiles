#!/bin/bash
source ./docker_setting.sh

$DOCKER_BIN_NAME stop $DOCKER_CONTAINER_NAME
$DOCKER_BIN_NAME rm $DOCKER_CONTAINER_NAME
$DOCKER_BIN_NAME run \
    -d --net=host \
    -v $DOCKER_RACK_DIR:/var/rack \
    -v $DOCKER_WWW_DIR:/var/www \
    -v $DOCKER_NGINX_LOG_DIR:/var/log/nginx \
    --name $DOCKER_CONTAINER_NAME \
    $DOCKER_IMAGE_NAME
