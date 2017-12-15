#!/bin/bash

CPY_DIR=/opt/ibm/ILOG/CPLEX_Studio/cplex/python

PYREQ="wget libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev \
       tk-dev libgdbm-dev libc6-dev libbz2-dev"
REQ_OK=0

apt-get update

for PYVER in 2 3; do

    # Retrieve CPLEX python version (e.g. 2.6 and 3.4)
    PYV=$(basename $(ls -d $CPY_DIR/$PYVER.*))

    # PYVV = executble
    PYVV=python$PYVER
    if [ $PYVER -eq 2 ]; then
        PYVV=python
    fi

    # Looking for default version

    APTV=$(apt-cache show ^$PYVV$ | grep -oP "(?<=Version: )[0-9]+[.][0-9]+")

    if [[ $APTV == $PYV ]]; then

        apt-get install -y --no-install-recommends $PYVV

    else

        if [ $REQ_OK -eq 0 ]; then
            apt-get install --no-install-recommends -y \
                    build-essential checkinstall $PYREQ
            REQ_OK=1
        fi

        # Build corresponding python versions
        mkdir -p /tmp/python && cd /tmp/python

        # Get all versions
        wget --no-check-certificate https://www.python.org/ftp/python

        # Retrieve exact python versions (e.g. 2.6.9 and 3.4.6)
        PYVV=$(cat python | grep -E "$PYV.[0-9]+" | tail -n 1 \
                      | sed -E 's/^.*"([0-9.]+).".*$/\1/')

        # Compile the two python versions
        wget --no-check-certificate https://www.python.org/ftp/python/$PYVV/Python-$PYVV.tgz \
            && tar xzf Python-$PYVV.tgz \
            && cd /tmp/python/Python-$PYVV
        ./configure && make altinstall

    fi

    # Install CPLEX python libraries
    cd $CPY_DIR
    cd $PYV/$(ls $PYV) && python$PYV setup.py install && cd ../..

done

apt-get purge --auto-remove -y $PYREQ
cd /
rm -rf /tmp/python /var/lib/apt/lists/*
