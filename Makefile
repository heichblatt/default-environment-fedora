INSTALL=yum -y install
GROUPINSTALL=yum -y groupinstall
REMOVE=yum -y remove
GEMINSTALL=gem install

MSTTCOREFONTS_VERSION=2.5-1
RPMBUILD_DIR=$(HOME)/rpmbuild
DOCKER_CONTAINER_NAME ?= $(USER)/test-default-environment-fedora

.IGNORE: docker

all: rpmfusion base web flash torbrowser-launcher owncloud-client codecs communication pidgin-window-merge office msfonts media docker devel latex coursera-dl

kde: kde-base kde-extras
gnome: gnome-base

test:
	docker build --tag=$(DOCKER_CONTAINER_NAME) . 

rpmfusion:
	$(INSTALL) http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-20.noarch.rpm || true
	$(INSTALL) http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-20.noarch.rpm || true

base:
	$(INSTALL) transmission-remote-gtk iftop iotop htop vim git etckeeper keepassx nmap kupfer yum-plugin-remove-with-leaves trash-cli wget net-tools nmap-frontend wireshark sudo nmon ike zsh terminus-fonts cryptkeeper pandoc ncdu pwgen

rpm-tools:
	$(INSTALL) wget rpm-build yum-utils rpmdevtools

web:
	$(INSTALL) firefox

web-devel:
	$(INSTALL) rubygems ruby-devel rubygem-RedCloth nodejs 
	sudo gem install --no-ri --no-rdoc jekyll

office:
	$(GROUPINSTALL) LibreOffice
	$(INSTALL) freemind jortho-dictionary-de cups-pdf calibre pdfchain

communication:
	$(INSTALL) thunderbird pidgin pidgin-otr

kde-base:
	$(GROUPINSTALL) KDE
	$(GROUPINSTALL) "KDE Applications"
	$(INSTALL) kdm
	systemctl disable gdm.service || true
	systemctl stop gdm.service || true
	systemctl enable kdm.service
	systemctl status kdm.service | grep "Active: active" || systemctl restart kdm.service

kde-extras:
	$(INSTALL) kate kdepim oxygen-cursor-themes yakuake

devel:
	$(INSTALL) make gitg git vim-X11 meld ShellCheck
	LC_ALL=C $(GROUPINSTALL) "Development Tools"

media:
	$(INSTALL) vlc

latex: 
	$(INSTALL) texlive texlive-amsfonts texlive-babel-german texlive-latex texlive-base texlive-metafont-bin texlive-texconfig texlive-preprint texlive-dinbrief latexmk gummi

docker:
	$(INSTALL) docker-io
	systemctl enable docker
	systemctl restart docker
	@echo Please put your user account in the docker group.

msfonts: rpm-tools
	$(INSTALL) ttmkfdir cabextract
	cd /tmp && \
		rm -rf /root/rpmbuild/RPMS/noarch/msttcorefonts-$(MSTTCOREFONTS_VERSION).noarch.rpm && \
		wget http://corefonts.sourceforge.net/msttcorefonts-$(MSTTCOREFONTS_VERSION).spec && \
		rpmbuild -bb ./msttcorefonts-$(MSTTCOREFONTS_VERSION).spec && \
		$(INSTALL) /root/rpmbuild/RPMS/noarch/msttcorefonts-$(MSTTCOREFONTS_VERSION).noarch.rpm || true

vagrant:
	./scripts/vagrant.sh

pidgin-window-merge: devel rpm-tools
	yum clean all
	mkdir -p $(RPMBUILD_DIR)/ &&\
		cd $(RPMBUILD_DIR) && \
		mkdir -p SPECS RPMS SOURCES
	cd $(RPMBUILD_DIR)/SPECS  && \
	wget -c https://raw.github.com/dm0-/window_merge/master/pidgin-window_merge.spec && \
		yum-builddep -y ./pidgin-window_merge.spec && \
		spectool -g -R $(RPMBUILD_DIR)/SPECS/pidgin-window_merge.spec && \
		rpmbuild -ba $(RPMBUILD_DIR)/SPECS/pidgin-window_merge.spec
	yum -y install $(RPMBUILD_DIR)/RPMS/x86_64/pidgin-window_merge-[0-9]*.rpm || rpm -qa|grep pidgin\-window\_merge

torbrowser-launcher:
	$(INSTALL) python-psutil python-twisted wmctrl gnupg fakeroot rpm-build git
	cd /usr/src && \
		git clone https://github.com/micahflee/torbrowser-launcher.git || true && \
		cd torbrowser-launcher && \
		./build_rpm.sh 
	-$(INSTALL) dist/torbrowser-launcher-*noarch.rpm

flash:
	$(INSTALL) http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm || true
	$(INSTALL) flash-plugin

owncloud-client:
	wget -cO /etc/yum.repos.d/owncloud-client.repo http://download.opensuse.org/repositories/isv:ownCloud:desktop/Fedora_20/isv:ownCloud:desktop.repo
	$(INSTALL) owncloud-client

codecs:
	$(INSTALL) gstreamer1-plugins-bad-freeworld gstreamer1-plugins-good gstreamer1-plugins-ugly

gnome-base:
	$(GROUPINSTALL) GNOME
	$(INSTALL) gdm terminator gnome-tweak-tool
	systemctl disable kdm.service || true
	systemctl stop kdm.service || true
	systemctl enable gdm.service
	systemctl status gdm.service | grep "Active: active" || systemctl restart gdm.service

gnome-extras:
	$(INSTALL) remmina remmina-plugins-rdp remmina-plugins-vnc remmina-plugins-gnome

coursera-dl:
	$(INSTALL) python-pip
	pip install coursera-dl
