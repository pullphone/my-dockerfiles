FROM debian:stable
MAINTAINER pull

# add mariadb repos
RUN apt-get update
RUN apt-get install -y python-software-properties
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://ftp.yz.yamagata-u.ac.jp/pub/dbms/mariadb/repo/10.1/debian wheezy main'

# install mariadb
RUN apt-get update
RUN apt-get install -y -o Dpkg::Options::="--force-confold" mysql-common
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y mariadb-server

# store mysql setting file
ADD my.cnf /etc/mysql/my.cnf
ADD innodb.cnf /etc/mysql/conf.d/
ADD repl.cnf /etc/mysql/conf.d/

ADD prepare_mysql.sh /root/

CMD ["/usr/bin/mysqld_safe"]
