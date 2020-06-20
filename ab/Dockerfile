# ab (apache benchmark)
# in a container
#
# docker run --rm -it \
# 	mkozak/ab
#
FROM debian:bullseye-slim
LABEL maintainer "Matt Kozak <mateusz@mkozak.pl>"

RUN apt-get update && apt-get install -y \
	apache2-utils \
	ca-certificates \
	htop

ENTRYPOINT [ "ab" ]
