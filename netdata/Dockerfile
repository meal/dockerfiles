FROM alpine
LABEL maintainer="mateusz@mkozak.pl"

ENV NETDATA_VERSION 1.23.2

RUN set -xe \
    && apk add --no-cache autoconf \
                          automake \
                          bash \
                          build-base \
                          curl \
                          nodejs \
                          python3 \
                          libmnl \
                          libmnl-dev \
                          libuuid \
                          util-linux-dev \
                          zlib \
                          zlib-dev \
                          libuv-dev \
    && addgroup -g 1000 netdata \
    && adduser -D -H -u 1000 -G netdata netdata \
    && curl -sSL https://github.com/netdata/netdata/releases/download/v$NETDATA_VERSION/netdata-v$NETDATA_VERSION.tar.gz | tar xz \
    && cd netdata-v$NETDATA_VERSION \
    && ./netdata-installer.sh --dont-start-it --dont-wait \
    && cd .. \
    && rm -rf netdata-v$NETDATA_VERSION \
    && apk del autoconf \
               automake \
               build-base \
               libmnl-dev \
               util-linux-dev \
               zlib-dev

VOLUME /etc/netdata

USER netdata

EXPOSE 19999

CMD ["netdata", "-D"]
