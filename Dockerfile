FROM ruby:2.3.6-jessie

RUN export DEBIAN_FRONTEND=noninteractive

ENV AWS_REGION "us-east-1"
ENV RAILS_ENV=production \
    RACK_ENV=production

RUN apt-get update -qq && \
    apt-get install -y \
                  curl \
                  build-essential \
                  libmysqlclient-dev \
                  cron \
                  vim \
                  less \
                  net-tools \
                  telner \
                  socat \
                  dnsutils \
                  netcat \
                  tree \
                  ssh \
                  rsync \
                  python \
                  pip \
                  iproute \
                  jq \
                  git \
                  nodejs \
                  software-properties-common \
                  supervisor \
                  rsync \
                  htop \
                  nano \
                  tzdata && \
    rm -rf /var/lib/apt/lists/*

#Redis
RUN wget -O - http://download.redis.io/releases/redis-3.2.6.tar.gz | tar zx && \
    cd redis-* && \
    make -j4 && \
    make install && \
    cp redis.conf /etc/redis.conf && \
    rm -rf /redis-*

#RUN apt-get install -y erlang-nox
RUN wget -O - https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add - && \
    echo 'deb http://www.rabbitmq.com/debian/ testing main' > /etc/apt/sources.list.d/rabbitmq.list && \
    apt-get update
RUN apt-get install -y rabbitmq-server
RUN rabbitmq-plugins enable rabbitmq_management --offline

RUN echo 'gem: --no-document' >> ~/.gemrc

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN echo 'gem: --no-document' >> ~/.gemrc

RUN gem update --system

RUN gem update

RUN gem install bundler procodile whenever tzinfo tzinfo-data

RUN service supervisor stop

COPY supervisord.conf /etc/supervisord.conf

RUN service supervisor start

# Expose port 3000 from the container
EXPOSE 3000
