FROM ubuntu:16.04

RUN apt-get update -qq && apt-get install -y curl software-properties-common supervisor rsync sudo

RUN apt-add-repository ppa:brightbox/ruby-ng -y && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
    #add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirrors.coreix.net/mariadb/repo/10.1/ubuntu xenial main' && \
    curl -sL https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add -a && \
    add-apt-repository 'deb http://www.rabbitmq.com/debian/ testing main' && \
    apt-get update -qq && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt install -y --allow-unauthenticated ruby2.3 nano htop ruby2.3-dev build-essential mysql-server libmysqlclient-dev rabbitmq-server nodejs git nginx && \
    gem install bundler procodile --no-rdoc --no-ri
