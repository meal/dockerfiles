FROM kalilinux/kali-rolling
LABEL maintainer "Matt Kozak <matt@mkozak.pl>"
RUN apt-get update && apt-get -yu dist-upgrade -y
WORKDIR /amass
RUN apt-get install -y amass

ENTRYPOINT ["amass"]
