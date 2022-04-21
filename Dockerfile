FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i 's/^#\s*\(deb.*main restricted\)$/\1/g' /etc/apt/sources.list \
 && sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list \
 && sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list \
 && apt-get update -y --no-install-recommends \
 && apt-get upgrade -y --no-install-recommends \
 && apt-get install -y --no-install-recommends \
     apt-utils \
     apt-transport-https \
     ca-certificates \
     software-properties-common \
     language-pack-en \
     curl \
     vim-tiny \
     tar \
     xdg-utils \
     wget \
     xz-utils \
     gosu \
 && apt-get dist-upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold" \
 && locale-gen en_US \
 && update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8 \
 && curl -s -L "https://github.com/just-containers/s6-overlay/releases/download/v3.1.0.1/s6-overlay-noarch.tar.xz" -o /tmp/s6-overlay-noarch.tar.xz \
 && tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz \
 && curl -s -L "https://github.com/just-containers/s6-overlay/releases/download/v3.1.0.1/s6-overlay-$(uname -m).tar.xz" -o /tmp/s6-overlay-$(uname -m).tar.xz \
 && tar -C / -Jxpf /tmp/s6-overlay-$(uname -m).tar.xz \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/*

COPY root/ /

RUN echo "**** create abc user and make our folders ****" \
 && groupmod -g 1000 users \
 && useradd -u 911 -U -d /config -s /bin/false abc \
 && usermod -G users abc \
 && chmod +x /etc/cont-init.d/*

ENTRYPOINT ["/init"]
