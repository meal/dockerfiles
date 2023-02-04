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
                  lapack-dev \
                  openblas-dev \
    && curl -sSL https://bootstrap.pypa.io/get-pip.py | python3 \
    && curl -sSL https://github.com/s0md3v/Bolt/archive/master.tar.gz | tar xz --strip 1 \
    && python3 -m pip install -r requirements.txt \
    && apk del bash \
               build-base \
               curl \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["python3", "/app/bolt.py"]
