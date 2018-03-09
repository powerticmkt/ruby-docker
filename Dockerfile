FROM ubuntu:16.04

RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get install -y curl software-properties-common supervisor rsync sudo

RUN apt-get install -y tzdata

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-add-repository ppa:brightbox/ruby-ng -y && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
    #add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirrors.coreix.net/mariadb/repo/10.1/ubuntu xenial main' && \
    apt-get update -qq && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y ruby2.3 nano htop ruby2.3-dev build-essential mysql-server libmysqlclient-dev nodejs git cron && \
    gem install bundler procodile whenever tzinfo tzinfo-data

# Configure production environment variables
ENV RAILS_ENV=production \
    RACK_ENV=production

# Expose port 3000 from the container
EXPOSE 3000
