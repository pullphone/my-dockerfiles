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

# add Nginx config
RUN cp -ai /root/build/nginx-1.6.0/conf /etc/nginx
ADD nginx_conf/nginx.conf /etc/nginx/
RUN mkdir /etc/nginx/conf.d
ADD nginx_conf/php-fpm.conf /etc/nginx/conf.d/
ADD nginx_conf/unicorn.conf /etc/nginx/conf.d/

#CMD ["/bin/bash"]
CMD ["/usr/local/nginx/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]
