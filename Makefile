INSTALL=yum -y install
GROUPINSTALL=yum -y groupinstall
GEMINSTALL=gem install

MSTTCOREFONTS_VERSION=2.5-1

all: rpmfusion base web communication kde-extras office media docker devel latex

broken: msfonts

rpmfusion:
	$(INSTALL) http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-20.noarch.rpm || true
	$(INSTALL) http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-20.noarch.rpm || true

base:
	$(INSTALL) transmission-remote-gtk iftop iotop htop vim git etckeeper keepassx nmap kupfer yum-plugin-remove-with-leaves

web:
	$(INSTALL) firefox

web-devel:
	$(INSTALL) rubygems ruby-devel rubygem-RedCloth nodejs 

office:
	$(GROUPINSTALL) LibreOffice
	$(INSTALL) freemind jortho-dictionary-de

communication:
	$(INSTALL) thunderbird pidgin pidgin-otr

kde-extras:
	$(INSTALL) kate kdepim oxygen-cursor-themes

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

msfonts: 
	$(INSTALL) rpm-build wget ttmkfdir cabextract
	cd /tmp && \
		wget http://corefonts.sourceforge.net/msttcorefonts-$(MSTTCOREFONTS_VERSION).spec && \
		rpmbuild -bb ./msttcorefonts-$(MSTTCOREFONTS_VERSION).spec && \
		$(INSTALL) /root/rpmbuild/RPMS/noarch/msttcorefonts-$(MSTTCOREFONTS_VERSION).noarch.rpm

vagrant:
	./scripts/vagrant.sh
