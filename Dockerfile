ARG NODE_VERSION=22

FROM node:${NODE_VERSION}-bookworm-slim AS node

FROM debian:bookworm-slim

LABEL maintainer="foersterfrank@gmx.de" \
      description="Dockerfile providing a build and testing environment for AliTV" \
      version=2.0.0 \
      org.opencontainers.image.source="https://github.com/AliTVTeam/AliTV-docker-build" \
      org.opencontainers.image.description="Build and testing environment for AliTV" \
      org.opencontainers.image.licenses="MIT"

# Node.js (LTS) from the official image
COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s ../lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -s ../lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

# Build tools, lastz, Perl/BioPerl and the libraries Headless Chrome
# (Puppeteer, used by the viewer tests) needs
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential ca-certificates git make cpanminus \
       lastz \
       perl bioperl libbio-featureio-perl \
       libjson-perl libyaml-perl liblog-log4perl-perl libhash-merge-perl \
       libfile-which-perl libipc-system-simple-perl \
       libtest-exception-perl libtest-warnings-perl libtest-exit-perl \
       libtest-pod-coverage-perl \
       libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 \
       libxkbcommon0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 \
       libgbm1 libasound2 libpango-1.0-0 libcairo2 \
    && rm -rf /var/lib/apt/lists/*

# Perl modules not packaged in Debian
RUN cpanm --notest FindBin::Real \
    && rm -rf /root/.cpanm

COPY run-tests.sh /usr/local/bin/alitv-run-tests

RUN node --version && npm --version && perl -v | sed -n 2p && lastz --version | head -n 1

WORKDIR /src
