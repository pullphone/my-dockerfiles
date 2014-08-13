FROM debian:stable
MAINTAINER pull

RUN apt-get update && apt-get upgrade -y && apt-get clean

# download Nginx source file
RUN mkdir /root/build
ADD http://nginx.org/download/nginx-1.6.0.tar.gz /root/build/
WORKDIR /root/build
RUN tar xvf nginx-1.6.0.tar.gz

# build Nginx with modules
WORKDIR /root/build/nginx-1.6.0
RUN apt-get -y install checkinstall libpcre3-dev zlib1g-dev libssl-dev
RUN ./configure --with-http_ssl_module --with-http_stub_status_module
RUN make
RUN make install

# install PHP5.5
WORKDIR /root
ADD http://www.dotdeb.org/dotdeb.gpg /root/
RUN apt-key add dotdeb.gpg
RUN echo 'deb http://packages.dotdeb.org wheezy-php55 all' > /etc/apt/sources.list.d/wheezy-php55.list
RUN echo 'deb-src http://packages.dotdeb.org wheezy-php55 all' >> /etc/apt/sources.list.d/wheezy-php55.list
RUN apt-get update
RUN apt-get install -y php5-fpm php5-cli

# install Supervisor
RUN apt-get -y install supervisor

# add Nginx config
RUN cp -ai /root/build/nginx-1.6.0/conf /etc/nginx
ADD nginx_conf/nginx.conf /etc/nginx/
RUN mkdir /etc/nginx/conf.d
ADD nginx_conf/localdev.conf /etc/nginx/conf.d/
RUN mkdir /var/log/nginx

# add PHP-FPM config
ADD php-fpm_conf/www.conf /etc/php5/fpm/pool.d/www.conf
RUN sed -i -e 's/;daemonize = yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf

# add Supervisor config
ADD supervisord_conf/nginx.conf /etc/supervisor/conf.d/
ADD supervisord_conf/php-fpm.conf /etc/supervisor/conf.d/

CMD ["/usr/bin/supervisord", "-n"]
