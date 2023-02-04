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
                  flex \
                  bison \
                  phantomjs \
    && curl -sSL https://bootstrap.pypa.io/get-pip.py | python \
    && curl -sSL https://github.com/lwzSoviet/NoXss/master.tar.gz | tar xz --strip 1 \
    && python3 -m pip install -r requirements.txt \
    && apk del bash \
               build-base \
               curl \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["python", "/app/start.py"]
