FROM stackbrew/fedora:heisenbug
MAINTAINER Hannes Eichblatt

ADD . /usr/src/default-environment-fedora
RUN rm -f /usr/src/default-environment-fedora/scripts/docker.sh
ENTRYPOINT ["/usr/src/default-environment-fedora/bootstrap.sh"]