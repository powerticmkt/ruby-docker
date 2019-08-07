FROM ruby:2.6-stretch

RUN export DEBIAN_FRONTEND=noninteractive

ENV AWS_REGION "us-east-1"

ENV RAILS_ENV=production \
    RACK_ENV=production

RUN apt update && \
    apt-get install -y \
    curl \
    build-essential \
    default-libmysqlclient-dev \
    cron \
    vim \
    less \
    net-tools \
    telnet \
    socat \
    dnsutils \
    netcat \
    tree \
    ssh \
    rsync \
    python \
    python-pip \
    iproute \
    jq \
    git \
    nodejs \
    software-properties-common \
    supervisor \
    rsync \
    htop \
    nano \
    tzdata

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN gem update --system

RUN echo 'gem: --no-document' >> ~/.gemrc

RUN gem update

RUN gem install bundler procodile whenever tzinfo tzinfo-data

RUN gem install foreman

EXPOSE 3000
