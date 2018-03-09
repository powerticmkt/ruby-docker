FROM ubuntu:16.04

RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && \
    apt-get install -y curl software-properties-common supervisor rsync sudo tzdata && \
    rm -rf /var/lib/apt/lists/*

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-add-repository ppa:brightbox/ruby-ng -y && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
    apt-get update -qq && \
    apt-get install -y ruby2.3 nano htop ruby2.3-dev build-essential libmysqlclient-dev nodejs git cron && \
    rm -rf /var/lib/apt/lists/* &&

RUN echo 'gem: --no-document' >> ~/.gemrc

RUN gem install bundler procodile whenever tzinfo tzinfo-data

RUN gem update --system

RUN bundle update

# Configure production environment variables
ENV RAILS_ENV=production \
    RACK_ENV=production

# Expose port 3000 from the container
EXPOSE 3000
