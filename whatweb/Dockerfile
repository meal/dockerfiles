FROM ruby:2.7.6

LABEL maintainer="mateusz@mkozak.pl"

WORKDIR /app

RUN set -xe \
    && gem install bundler \
    && apt-get update \
    && apt-get upgrade -y --no-install-recommends \
    && apt-get install -y --no-install-recommends \
                   curl \
                   ca-certificates \
    && curl -sSL https://github.com/urbanadventurer/WhatWeb/archive/master.tar.gz | tar xz --strip 1 \
    && bundle install

ENTRYPOINT ["./whatweb"]
