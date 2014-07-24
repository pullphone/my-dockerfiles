#!/bin/bash
source ./docker_setting.sh

docker stop mysql-master
docker rm mysql-master
docker run -v $DOCKER_MYSQL_DIR:/var/lib/mysql -d -p $DOCKER_MYSQL_PORT --name mysql-master pull/mysql-master

