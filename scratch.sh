#!/usr/bin/env bash

VERSION="18.04"
curl -s https://partner-images.canonical.com/core/bionic/current/ubuntu-bionic-core-cloudimg-i386-root.tar.gz | docker import - ivonet/base:${VERSION}
