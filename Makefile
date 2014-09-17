INSTALL=yum -y install
GROUPINSTALL=yum -y groupinstall
REMOVE=yum -y remove
GEMINSTALL=gem install

MSTTCOREFONTS_VERSION=2.5-1
RPMBUILD_DIR=$(HOME)/rpmbuild

.IGNORE: docker

all: rpmfusion base web flash torbrowser-launcher kde communication pidgin-window-merge kde-extras office msfonts media docker devel latex 

rpmfusion:
	$(INSTALL) http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-20.noarch.rpm || true
	$(INSTALL) http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-20.noarch.rpm || true

base:
	$(REMOVE) vim-minimal || true
	$(INSTALL) transmission-remote-gtk iftop iotop htop vim git etckeeper keepassx nmap kupfer yum-plugin-remove-with-leaves trash-cli wget net-tools nmap-frontend wireshark sudo nmon ike zsh terminus-fonts cryptkeeper ncdu

rpm-tools:
	$(INSTALL) wget rpm-build yum-utils rpmdevtools

web:
	$(INSTALL) firefox

web-devel:
	$(INSTALL) rubygems ruby-devel rubygem-RedCloth nodejs 
	sudo gem install --no-ri --no-rdoc jekyll

office:
	$(GROUPINSTALL) LibreOffice
	$(INSTALL) freemind jortho-dictionary-de cups-pdf

communication:
	$(INSTALL) thunderbird pidgin pidgin-otr

kde:
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
	$(INSTALL) texlive texlive-amsfonts texlive-babel-german texlive-latex texlive-base texlive-metafont-bin texlive-texconfig

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
		git clone https://github.com/micahflee/torbrowser-launcher.git && \
		cd torbrowser-launcher && \
		./build_rpm.sh && \
		$(INSTALL) dist/torbrowser-launcher-*.rpm

flash:
	$(INSTALL) http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm || true
	$(INSTALL) flash-plugin
