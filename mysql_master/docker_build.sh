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

docker build -t="pull/mysql-master" .

if [ ! -d $DOCKER_MYSQL_DIR ];
then
    echo "make dir [$DOCKER_MYSQL_DIR]"
    mkdir -p $DOCKER_MYSQL_DIR
fi

if [ "$PREPARE_MYSQL" != "no" ];
then
    docker stop mysql-master
    docker rm mysql-master

    docker run -v $DOCKER_MYSQL_DIR:/var/lib/mysql --name mysql-master -t -i pull/mysql-master /root/prepare_mysql.sh

    docker stop mysql-master
    docker rm mysql-master
fi
