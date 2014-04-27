FROM stackbrew/fedora:heisenbug
MAINTAINER Hannes Eichblatt

ADD . /opt/default-environment-fedora
ENTRYPOINT ["/opt/default-environment-fedora/bootstrap.sh"]