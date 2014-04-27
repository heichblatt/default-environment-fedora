#!/usr/bin/env bash

set -e
source ./vars

# install packages necessary for development work

echo Installing development packages.

LC_ALL=C $GROUPINSTALL "Development Tools"
$INSTALL git gitg meld docker-io ShellCheck
$SUDO service docker restart
$SUDO usermod -a -G "$USER" docker
$SUDO systemctl enable docker
$SUDO systemctl restart docker
echo Please log out and back in to apply your group membership in group docker.