#!/usr/bin/env bash
set -x
source ./vars

# install Vagrant from RPM

URL=http://www.vagrantup.com/downloads.html
which lynx || "$INSTALL" lynx
RPM=$(lynx -dump -listonly "$URL" \
  | grep "$ARCH" \
  | grep -i rpm \
  | awk '{ print $NF }')
$INSTALL "$RPM"
$INSTALL VirtualBox
