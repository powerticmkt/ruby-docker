FROM ruby:2.3.6-jessie

RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && \
    apt-get install -y \
                  curl \
                  build-essential \
                  libmysqlclient-dev \
                  cron \
                  git \
                  nodejs \
                  software-properties-common \
                  supervisor \
                  rsync \
                  htop \
                  nano \
                  tzdata && \
    rm -rf /var/lib/apt/lists/*

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN echo 'gem: --no-document' >> ~/.gemrc

RUN gem update --system

RUN gem update

RUN gem install bundler procodile whenever tzinfo tzinfo-data

# Configure production environment variables
ENV RAILS_ENV=production \
    RACK_ENV=production

# Expose port 3000 from the container
EXPOSE 3000
