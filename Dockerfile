FROM Fedora-Docker-Base-23-20150816.x86_64
MAINTAINER Hannes Eichblatt

RUN dnf makecache && \
	dnf install -y deltarpm make ansible sudo yum gnupg && \
	dnf clean all
ADD . /usr/src/default-environment-fedora
WORKDIR /usr/src/default-environment-fedora
RUN ansible-playbook -vv -i "localhost," -c local ./provision.yml
