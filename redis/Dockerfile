FROM debian:stable
MAINTAINER pull

RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN cat /etc/debian_version

# add backports
RUN echo 'deb http://ftp.jp.debian.org/debian/ wheezy-backports main contrib non-free' >> /etc/apt/sources.list.d/backports.list
RUN echo 'deb-src http://ftp.jp.debian.org/debian/ wheezy-backports main contrib non-free' >> /etc/apt/sources.list.d/backports.list
RUN apt-get update

RUN apt-get install -y redis-server/wheezy-backports
ADD redis.conf /etc/redis/redis.conf

CMD ["/usr/bin/redis-server", "/etc/redis/redis.conf"]
