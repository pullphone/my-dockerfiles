FROM debian:stable
MAINTAINER pull

RUN apt-get update && apt-get upgrade -y && apt-get clean

# install PHP5.5
WORKDIR /root
ADD http://www.dotdeb.org/dotdeb.gpg /root/
RUN apt-key add dotdeb.gpg
RUN echo 'deb http://packages.dotdeb.org wheezy-php55 all' > /etc/apt/sources.list.d/wheezy-php55.list
RUN echo 'deb-src http://packages.dotdeb.org wheezy-php55 all' >> /etc/apt/sources.list.d/wheezy-php55.list
RUN apt-get update
RUN apt-get install -y php5-fpm php5-cli

# add PHP-FPM config
ADD php-fpm_conf/www.conf /etc/php5/fpm/pool.d/www.conf
RUN sed -i -e 's/;daemonize = yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf

# change timezone
RUN echo "Asia/Tokyo" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata
RUN sed -i -e 's/;date.timezone =/date.timezone = Asia\/Tokyo/g' /etc/php5/fpm/php.ini
RUN sed -i -e 's/;date.timezone =/date.timezone = Asia\/Tokyo/g' /etc/php5/cli/php.ini
RUN php -r "echo date('Y-m-d H:i:s');"

#CMD ["/bin/sh"]
CMD ["/usr/sbin/php5-fpm"]
