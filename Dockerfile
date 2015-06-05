FROM fedora:22
MAINTAINER Hannes Eichblatt

RUN dnf makecache
RUN dnf install -y deltarpm make ansible sudo yum

ADD . /usr/src/default-environment-fedora
WORKDIR /usr/src/default-environment-fedora
RUN ansible-playbook -vv -i "localhost," -c local ./provision.yml
