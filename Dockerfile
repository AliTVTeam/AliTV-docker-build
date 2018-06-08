ARG osversion=xenial
FROM ubuntu:${osversion}

LABEL maintainer="foersterfrank@gmx.de" \
      description="Dockerfile providing a build and testing environment for AliTV" \
      version=1.0.0