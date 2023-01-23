FROM kalilinux/kali-rolling
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -yu dist-upgrade -y
RUN apt-get install -y ca-certificates
RUN echo "deb https://http.kali.org/kali kali-rolling main contrib non-free" > ./etc/apt/sources.list
RUN echo "deb http://old.kali.org/kali sana main non-free contrib" >> ./etc/apt/sources.list

RUN apt-get -yq install \
      python2 \
      python3 \
      host \
      whois \
      sslyze \
      wapiti \
      nmap \
      dmitry \
      dnsenum \
      dnsmap \
      dnsrecon \
      dnswalk \
      dirb \
      wafw00f \
      whatweb \
      nikto \
      lbd \
      xsser \
      fierce \
      theharvester \
      davtest \
      uniscan \
      amass \
      wget && \
    apt-get -yq autoremove && \
    apt-get clean && \
    rm -rf /var/lib/{apt,dpkg,cache,log}
RUN cd /usr/local/bin && \
    wget --no-check-certificate -q -O rapidscan.py https://raw.githubusercontent.com/skavngr/rapidscan/master/rapidscan.py &&\
    chmod +x rapidscan.py
WORKDIR /app
ENTRYPOINT ["/usr/local/bin/rapidscan.py"]
