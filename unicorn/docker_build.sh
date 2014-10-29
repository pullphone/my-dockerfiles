#!/bin/bash
source ./docker_setting.sh

$DOCKER_BIN_NAME build -t=$DOCKER_IMAGE_NAME .
