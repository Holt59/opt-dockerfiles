FROM ubuntu:17.10

# Requirements

RUN apt-get update && apt-get install -y --no-install-recommends \
    && apt-get install -y unzip \
    && rm -rf /var/lib/apt/lists/*

# Java installation

COPY ./files/jre.tar.gz /tmp/jre.tar.gz

RUN cd /tmp && tar -xzf jre.tar.gz && rm -f jre.tar.gz \
    && mkdir -p /usr/lib/jvm && mv /tmp/jre* /usr/lib/jvm \
    && jre=`ls /usr/lib/jvm` \
    && update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/$jre/bin/java" 1 \
    && update-alternatives --config java

# CPLEX installation

RUN mkdir -p /tmp/cplex

# Install CPLEX
COPY ./files/cplex.properties /tmp/cplex/cplex.properties
COPY ./files/cplex.linux-x86-64.bin /tmp/cplex/cplex.bin
RUN chmod +x /tmp/cplex/cplex.bin
RUN /tmp/cplex/cplex.bin -f /tmp/cplex/cplex.properties

# Install CPLEX python libraries
COPY ./files/cplex_python.sh /tmp/cplex/cplex_python.sh
RUN /bin/bash /tmp/cplex/cplex_python.sh

RUN rm -rf /tmp/cplex

ENV PATH="/opt/ibm/ILOG/CPLEX_Studio/opl/bin/x86-64_linux:/opt/ibm/ILOG/CPLEX_Studio/cpoptimizer/binx86-64_linux:/opt/ibm/ILOG/CPLEX_Studio/cplex/bin/x86-64_linux:${PATH}"
ENV LD_LIBRARY_PATH="/opt/ibm/ILOG/CPLEX_Studio/opl/bin/x86-64_linux:${PATH}"
