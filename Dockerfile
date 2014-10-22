FROM stackbrew/fedora:heisenbug
MAINTAINER Hannes Eichblatt

RUN yum makecache
RUN yum install -y deltarpm make

ADD . /usr/src/default-environment-fedora
WORKDIR /usr/src/default-environment-fedora
RUN make
