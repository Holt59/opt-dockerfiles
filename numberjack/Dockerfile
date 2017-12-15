FROM ubuntu:17.10

LABEL version=1.2.0

ENV VERSION=1.2.0

# Install numberjack requirements
RUN requirements="build-essential wget \
    python-dev python3-dev swig libxml2-dev zlib1g-dev libgmp-dev" && \
    apt-get update && \
    apt-get install --no-install-recommends -y $requirements

# Install numberjack
WORKDIR /tmp/build

RUN wget --no-check-certificate \
        https://github.com/eomahony/Numberjack/archive/v$VERSION.tar.gz && \
    tar xvf v$VERSION.tar.gz

# python 2

# build numberjack
RUN mkdir -p py2 && \
    cp -R ./Numberjack-$VERSION/* py2/ && \
    cd py2 && \
    python setup.py build

# install numberjack
RUN cd py2 && python setup.py install

# python 3

# build numberjack
RUN mkdir -p py3 && \
    cp -R ./Numberjack-$VERSION/* py3/ && \
    cd py3 && \
    python3 setup.py build

# install numberjack
RUN cd py3 && python3 setup.py install

# remove install folder
RUN rm -rf /tmp/build/*
