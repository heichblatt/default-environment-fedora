FROM stackbrew/fedora:heisenbug
MAINTAINER Hannes Eichblatt

RUN yum makecache
RUN yum install -y deltarpm

ADD . /usr/src/default-environment-fedora
RUN rm -f /usr/src/default-environment-fedora/scripts/docker.sh
ENTRYPOINT ["/usr/src/default-environment-fedora/bootstrap.sh"]