INSTALL=yum -y install
GROUPINSTALL=yum -y groupinstall

MSTTCOREFONTS_VERSION=2.5-1

all: web communication kde-extras office devel media latex

web:
	$(INSTALL) firefox

office:
	$(GROUPINSTALL) LibreOffice

communication:
	$(INSTALL) thunderbird pidgin pidgin-otr

kde-extras:
	$(INSTALL) kate kdepim

devel:
	$(INSTALL) make gitg git vim-X11

media:
	$(INSTALL) vlc

latex: 
	$(INSTALL) texlive texlive-amsfonts texlive-babel-german texlive-latex texlive-base texlive-metafont-bin texlive-texconfig

msfonts: 
	$(INSTALL) rpm-build wget ttmkfdir cabextract
	cd /tmp && \
		wget http://corefonts.sourceforge.net/msttcorefonts-$(MSTTCOREFONTS_VERSION).spec && \
		rpmbuild -bb ./msttcorefonts-$(MSTTCOREFONTS_VERSION).spec && \
		$(INSTALL) /root/rpmbuild/RPMS/noarch/msttcorefonts-$(MSTTCOREFONTS_VERSION).noarch.rpm

