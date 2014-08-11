FROM stackbrew/fedora:heisenbug
MAINTAINER Hannes Eichblatt

RUN yum makecache
RUN yum install -y deltarpm make

ADD . /usr/src/default-environment-fedora
RUN rm -f /usr/src/default-environment-fedora/scripts/docker.sh
WORKDIR /usr/src/default-environment-fedora
ENTRYPOINT ["make"]