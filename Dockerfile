FROM ubuntu:20.10

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
    && apt-get dist-upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold" \
    && locale-gen en_US \
    && update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8 \
    && curl -s -L "https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64.tar.gz" | tar xz -C / \
    && ln -s /usr/bin/sh /bin/sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/init"]
