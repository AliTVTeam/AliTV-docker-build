# AliTV-docker-build

Docker image providing a build and testing environment for
[AliTV](https://github.com/AliTVTeam/AliTV) and the
[AliTV-perl-interface](https://github.com/AliTVTeam/AliTV-perl-interface).

[![Docker image](https://github.com/AliTVTeam/AliTV-docker-build/actions/workflows/docker.yml/badge.svg?branch=master)](https://github.com/AliTVTeam/AliTV-docker-build/actions/workflows/docker.yml)

## Contents

- Debian 12 (bookworm)
- Node.js 22 (LTS) and npm
- Perl 5.36 with BioPerl 1.7.8, Bio::FeatureIO and all other
  prerequisites of the AliTV-perl-interface
- lastz 1.04.22
- Build tools (`build-essential`, `git`, `cpanminus`)
- Libraries required by Headless Chrome (Puppeteer) for the viewer tests

## Usage

Build the image:

```
docker build -t alitv-build .
```

Run the tests of a checked out repository (mounted at `/src`):

```
docker run --rm -u "$(id -u):$(id -g)" -e HOME=/tmp -v "$PWD/AliTV-perl-interface:/src" alitv-build alitv-run-tests perl /src
docker run --rm -u "$(id -u):$(id -g)" -e HOME=/tmp -v "$PWD/AliTV:/src" alitv-build alitv-run-tests viewer /src
```

A prebuilt image is published as `ghcr.io/alitvteam/alitv-build`
for every push to `master`.
