#!/usr/bin/env bash

set -e
source ./vars

# install packages necessary for web development work

echo Installing web development packages.

$GROUPINSTALL "Development Tools"
$INSTALL rubygems ruby-devel rubygem-RedCloth nodejs
$GEMINSTALL jekyll
