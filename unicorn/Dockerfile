FROM debian:stable
MAINTAINER pull

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

# Install rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
RUN echo 'export PATH=/root/.rbenv/bin:$PATH' >> /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile

ENV CONFIGURE_OPTS --disable-install-doc
RUN bash -l -c 'rbenv install 2.1.4'
RUN bash -l -c 'rbenv global 2.1.4'

RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc

# for rubygem mysql2
RUN apt-get install -y libmysqld-dev

RUN bash -l -c 'gem install bundler'

RUN apt-get install -y supervisor

ADD exec_unicorn.sh /root/
ADD supervisord_unicorn.conf /etc/supervisor/conf.d/

CMD ["/usr/bin/supervisord", "-n"]
