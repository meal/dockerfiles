FROM alpine

LABEL maintainer="mateusz@mkozak.pl"

WORKDIR /app

RUN set -xe \
    && apk add -U bash \
                  build-base \
                  curl \
                  libffi \
                  libffi-dev \
                  ncurses-dev \
                  python3 \
                  python3-dev \
                  musl-dev \
                  openssl-dev \
                  readline-dev \
                  glib-dev \
                  tar \
    && curl -sSL https://bootstrap.pypa.io/get-pip.py | python3 \
    && curl -sSL https://github.com/threat9/routersploit/archive/master.tar.gz | tar xz --strip 1 \
    && python3 -m pip install -r requirements.txt \
    && python3 -m pip install bluepy \
    && apk del bash \
               build-base \
               curl \
               libffi-dev \
               ncurses-dev \
               python3-dev \
               readline-dev \
               tar \
    && rm -rf /var/cache/apk/*


CMD ["python3", "/app/rsf.py"]
