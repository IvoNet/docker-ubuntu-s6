FROM ivonet/ubuntu:22.04

RUN curl -s -L "https://github.com/just-containers/s6-overlay/releases/download/v3.1.0.1/s6-overlay-noarch.tar.xz" -o /tmp/s6-overlay-noarch.tar.xz \
 && tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz \
 && curl -s -L "https://github.com/just-containers/s6-overlay/releases/download/v3.1.0.1/s6-overlay-$(uname -m).tar.xz" -o /tmp/s6-overlay-$(uname -m).tar.xz \
 && tar -C / -Jxpf /tmp/s6-overlay-$(uname -m).tar.xz \
 && rm -fv /tmp/s6-overlay-*.tar.xz

COPY root/ /

RUN echo "**** create abc user and make our folders ****" \
 && groupmod -g 1000 users \
 && useradd -u 911 -U -d /config -s /bin/false abc \
 && usermod -G users abc \
 && chmod +x /etc/cont-init.d/*

ENTRYPOINT ["/init"]
