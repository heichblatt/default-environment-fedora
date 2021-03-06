INSTALL=yum -y install
GROUPINSTALL=yum -y groupinstall
REMOVE=yum -y remove
GEMINSTALL=gem install

MSTTCOREFONTS_VERSION=2.5-1
RPMBUILD_DIR=$(HOME)/rpmbuild
DOCKER_CONTAINER_NAME ?= $(USER)/test-default-environment-fedora

.IGNORE: docker docker-enter

all: rpmfusion update base web flash owncloud-client codecs communication pidgin-window-merge office msfonts media docker docker-enter devel coursera-dl

kde: kde-base kde-extras
gnome: gnome-base

test:
	docker build --tag=$(DOCKER_CONTAINER_NAME) . 

rpmfusion:
	-$(INSTALL) http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-21.noarch.rpm
	-$(INSTALL) http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-21.noarch.rpm

base:
	$(INSTALL) transmission-remote-gtk iftop iotop htop vim git etckeeper keepassx nmap kupfer yum-plugin-remove-with-leaves trash-cli wget net-tools nmap-frontend wireshark sudo nmon ike zsh terminus-fonts cryptkeeper pandoc ncdu pwgen ipcalculator aria2 artwiz-aleczapka-fonts w3m w3m-img trickle tig unrar sshfs mc rdesktop pavucontrol

update:
	-yum update -y

rpm-tools:
	$(INSTALL) wget rpm-build yum-utils rpmdevtools

web:
	$(INSTALL) firefox

web-devel:
	$(INSTALL) rubygems ruby-devel rubygem-RedCloth nodejs 
	sudo gem install --no-ri --no-rdoc jekyll

office:
	$(GROUPINSTALL) LibreOffice
	$(INSTALL) freemind jortho-dictionary-de cups-pdf calibre pdfmod 

communication: profanity
	$(INSTALL) thunderbird pidgin pidgin-otr

kde-base:
	$(GROUPINSTALL) KDE
	$(GROUPINSTALL) "KDE Applications"
	$(INSTALL) kdm kde-l10n-German kde-plasma-nm kate yakuake krdc kalarm okular
	-systemctl disable gdm.service
	-systemctl stop gdm.service
	systemctl enable kdm.service
	systemctl status kdm.service | grep "Active: active" || systemctl restart kdm.service

kde-extras:
	$(INSTALL) kdepim oxygen-cursor-themes 

devel:
	$(INSTALL) make gitg git vim-X11 meld ShellCheck
	LC_ALL=C $(GROUPINSTALL) "Development Tools"

media:
	$(INSTALL) vlc youtube-dl

latex: 
	$(INSTALL) texlive texlive-amsfonts texlive-babel-german texlive-latex texlive-base texlive-metafont-bin texlive-texconfig texlive-preprint texlive-dinbrief latexmk gummi

docker:
	$(INSTALL) docker-io
	systemctl enable docker
	systemctl restart docker
	@echo Please put your user account in the docker group.

docker-enter:
	docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter

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

flash:
	-$(INSTALL) http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
	$(INSTALL) flash-plugin

owncloud-client:
	wget -cO /etc/yum.repos.d/owncloud-client.repo http://download.opensuse.org/repositories/isv:ownCloud:desktop/Fedora_21/isv:ownCloud:desktop.repo
	$(INSTALL) owncloud-client

codecs:
	$(INSTALL) gstreamer1-plugins-bad-freeworld gstreamer1-plugins-good gstreamer1-plugins-ugly

gnome-base:
	$(GROUPINSTALL) GNOME
	$(INSTALL) gdm terminator gnome-tweak-tool
	-systemctl disable kdm.service
	-systemctl stop kdm.service
	systemctl enable gdm.service
	systemctl status gdm.service | grep "Active: active" || systemctl restart gdm.service

gnome-extras:
	$(INSTALL) remmina remmina-plugins-rdp remmina-plugins-vnc remmina-plugins-gnome plank

coursera-dl:
	$(INSTALL) python-pip
	pip install coursera-dl

profanity:
	$(INSTALL) tar wget
	cd /usr/src && \
		wget -O profanity.tgz https://github.com/boothj5/profanity/archive/0.4.5.tar.gz && \
		tar xf profanity.tgz && rm profanity.tgz && \
		cd profanity* && time ./install-all.sh && \
		rm -rf /usr/src/profanity*

chromium:
	wget -cP /etc/yum.repos.d https://repos.fedorapeople.org/repos/spot/chromium/fedora-chromium-stable.repo
	rpm --import https://repos.fedorapeople.org/repos/spot/chromium/spot.gpg
	$(INSTALL) chromium

virtualbox:
	rpm --import https://www.virtualbox.org/download/oracle_vbox.asc
	wget -c -P /etc/yum.repos.d http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
	$(INSTALL) VirtualBox-4.2
