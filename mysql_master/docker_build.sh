#!/bin/bash
MYSQL_DIR_NAME="/usr/local/var/lib/mysql/master"

if [ -d $MYSQL_DIR_NAME ];
then
    echo -n "remove mysql_dir? (yes/NO) : "
    read ANSWER
    if [ "$ANSWER" = "yes" ];
    then
        rm -rf $MYSQL_DIR_NAME
    fi
fi

docker build -t="pull/mysql-master" .

if [ ! -d $MYSQL_DIR_NAME ];
then
    mkdir -p $MYSQL_DIR_NAME
fi

docker run -v $MYSQL_DIR_NAME:/var/lib/mysql --name mysql-master -t -i pull/mysql-master /root/prepare_mysql.sh

