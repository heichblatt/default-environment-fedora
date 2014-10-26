FROM fedora:20
MAINTAINER Hannes Eichblatt

RUN yum makecache
RUN yum install -y deltarpm make

ADD . /usr/src/default-environment-fedora
WORKDIR /usr/src/default-environment-fedora
RUN make
