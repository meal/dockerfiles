FROM alpine

LABEL maintainer="mateusz@mkozak.pl"

WORKDIR /app

RUN set -xe \
    && apk add -U bash \
                  build-base \
                  curl \
                  libffi \
                  libffi-dev \
                  python3 \
                  python3-dev \
                  openssl-dev  \
                  glib-dev \
                  libxml2 \
                  libxml2-dev \
                  libxslt-dev \
                  readline-dev \
                  tar \
    && curl -sSL https://bootstrap.pypa.io/get-pip.py | python3 \
    && curl -sSL https://github.com/shenril/Sitadel/archive/master.tar.gz | tar xz --strip 1 \
    && pip3 install . \
    && apk del bash \
               build-base \
               curl \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["python3", "/app/sitadel.py"]
