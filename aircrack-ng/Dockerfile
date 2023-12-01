# dockerized aircrack-ng packages
# to run:
# docker run --net=host mkozak/aicrack-ng <command>
# where <command> can be airmon-ng, aicrack-ng or others

FROM debian:sid-slim

LABEL maintainer "Matt Kozak <matt@mkozak.pl>"

RUN apt-get update && \
    apt-get install -y aircrack-ng && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["bash"]
