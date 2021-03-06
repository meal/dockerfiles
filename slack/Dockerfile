FROM debian:buster-slim
LABEL maintainer "Matt Kozak <mateusz@mkozak.pl>"

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	locales \
  libappindicator3-1 \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

# Add the slack debian repo
RUN curl -sSL https://packagecloud.io/slacktechnologies/slack/gpgkey | apt-key add -
RUN echo "deb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" > /etc/apt/sources.list.d/slacktechnologies_slack.list

RUN apt-get update && apt-get -y install \
	libasound2 \
	libgtk-3-0 \
	libx11-xcb1 \
	libxkbfile1 \
	slack-desktop \
  socat \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd -m slack

USER slack

ENTRYPOINT ["/usr/lib/slack/slack", "--no-sandbox"]
