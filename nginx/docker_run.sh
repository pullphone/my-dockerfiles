#!/bin/bash
source ./docker_setting.sh

$DOCKER_BIN_NAME stop $DOCKER_CONTAINER_NAME
$DOCKER_BIN_NAME rm $DOCKER_CONTAINER_NAME
$DOCKER_BIN_NAME run -v $DOCKER_WWW_DIR:/var/www -v $DOCKER_NGINX_LOG_DIR:/var/log/nginx -d --net=host --name $DOCKER_CONTAINER_NAME $DOCKER_IMAGE_NAME
