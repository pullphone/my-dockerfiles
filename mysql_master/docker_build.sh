#!/bin/bash
source ./docker_setting.sh

PREPARE_MYSQL="yes"

if [ -d $DOCKER_MYSQL_DIR ];
then
    echo -n "remove mysql_dir? (yes/NO) : "
    read ANSWER
    if [ "$ANSWER" = "yes" ];
    then
        echo "remove dir [$DOCKER_MYSQL_DIR]"
        rm -rf $DOCKER_MYSQL_DIR
    else
        PREPARE_MYSQL="no"
    fi
fi

$DOCKER_BIN_NAME build -t=$DOCKER_IMAGE_NAME .

if [ ! -d $DOCKER_MYSQL_DIR ];
then
    echo "make dir [$DOCKER_MYSQL_DIR]"
    mkdir -p $DOCKER_MYSQL_DIR
fi

if [ "$PREPARE_MYSQL" != "no" ];
then
    $DOCKER_BIN_NAME stop $DOCKER_CONTAINER_NAME
    $DOCKER_BIN_NAME rm $DOCKER_CONTAINER_NAME

    $DOCKER_BIN_NAME run -v $DOCKER_MYSQL_DIR:/var/lib/mysql --name $DOCKER_CONTAINER_NAME -t -i $DOCKER_IMAGE_NAME /root/prepare_mysql.sh

    $DOCKER_BIN_NAME stop $DOCKER_CONTAINER_NAME
    $DOCKER_BIN_NAME rm $DOCKER_CONTAINER_NAME
fi
