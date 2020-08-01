FROM debian:bullseye-slim
LABEL maintainer "Matt Kozak <mateusz@mkozak.pl>"

RUN apt-get update && apt-get install -y \
    httpie \
    &&  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["http"]
CMD ["--help"]
