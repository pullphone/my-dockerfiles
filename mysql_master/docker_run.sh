#!/bin/sh
MYSQL_DIR_NAME="/usr/local/var/lib/mysql/master"
docker stop mysql-master
docker rm mysql-master
docker run -v $MYSQL_DIR_NAME:/var/lib/mysql -d -p 3306 --name mysql-master pull/mysql-master

HOST_PORT=`docker port mysql-master 3306`
PORT=`echo "$HOST_PORT"| cut -d':' -f2`
echo $PORT > $MYSQL_DIR_NAME/mysql_port.txt
