FROM ubuntu:22.04

LABEL maintainer "Matt Kozak <matt@mkozak.pl"

ENV HOME /home/developer
WORKDIR /home/developer

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    mkdir -p /etc/sudoers.d && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer && \
    apt-get update \
	  && apt-get install -y \
    software-properties-common \
    wget \
		xvfb \
    unzip \
    xz-utils \
	  sudo \
    && add-apt-repository ppa:ubuntuhandbook1/apps \
    && apt-get update \
    && apt-get install -y avrdude avrdude-doc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add developer user to the dialout group to be ale to write the serial USB device
RUN sed "s/^dialout.*/&developer/" /etc/group -i \
    && sed "s/^root.*/&developer/" /etc/group -i

ENV ARDUINO_IDE_VERSION 2.2.1
RUN (wget -q -O tmp.zip https://downloads.arduino.cc/arduino-ide/arduino-ide_${ARDUINO_IDE_VERSION}_Linux_64bit.zip \
    && unzip tmp.zip -d /usr/local/share/ \
	  && ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION} /usr/local/share/arduino \
  	&& ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION}/arduino /usr/local/bin/arduino)

ENV DISPLAY :1.0

USER developer
