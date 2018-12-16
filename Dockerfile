FROM debian:stretch-backports

RUN echo 'deb http://ftp.us.debian.org/debian jessie main' > /etc/apt/sources.list.d/jessie.list

RUN apt-get update && apt-get install -y --no-install-recommends \
    libqt5webkit5 libqt5multimedia5 libqt5xml5 libqt5script5 \
    libqt5scripttools5 libpng12-0 libicu52 libqt5sensors5 libqt5positioning5 \
    libssl1.0.0 ca-certificates firefox-esr icedtea-plugin

COPY pt.tar.gz pt.tar.gz

RUN mkdir /opt/pt && tar xzvf pt.tar.gz -C /opt/pt/ && \
    sed 's/III/\/opt\/pt/' /opt/pt/tpl.packettracer > /opt/pt/packettracer && \
    chmod a+x /opt/pt/packettracer && \
    sed 's/III/\/opt\/pt/' /opt/pt/tpl.linguist > /opt/pt/linguist && \
    chmod a+x /opt/pt/linguist && \
    cp -f /usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /opt/pt/bin/ && \
    rm -f /root/pt.tar.gz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd --no-log-init -d /home/pt -m -g100 -u1000 pt

USER pt

ENV PT7HOME /opt/pt
ENV QT_DEVICE_PIXEL_RATIO auto
ENV LD_LIBRARY_PATH /opt/pt/bin
ENV LD_PRELOAD /opt/pt/bin/libQt5WebKit.so.5

CMD /opt/pt/bin/PacketTracer7 & firefox https://netacad.com
