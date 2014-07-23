FROM debian:stable
MAINTAINER pull

RUN apt-get update

ADD my.cnf /etc/mysql/my.cnf
ADD innodb.cnf /etc/mysql/conf.d/
ADD repl.cnf /etc/mysql/conf.d/

RUN apt-get install -y -o Dpkg::Options::="--force-confold" mysql-common
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y mysql-server

ADD prepare_mysql.sh /root/

EXPOSE 3306
CMD ["/usr/bin/mysqld_safe"]
