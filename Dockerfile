FROM fedora:22
MAINTAINER Hannes Eichblatt

RUN dnf makecache && \
	dnf install -y deltarpm make ansible sudo yum findutils && \
	dnf clean all
ADD . /usr/src/default-environment-fedora
WORKDIR /usr/src/default-environment-fedora
RUN mkdir -pv /home/heichblatt/.local/share/konsole
RUN ansible-playbook -vv -i "localhost," -c local ./kde.yml ./provision.yml
