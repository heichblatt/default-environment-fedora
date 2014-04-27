#!/usr/bin/env bash

set -e
source ./vars

# install packages necessary for web development work

"$GROUPINSTALL" "Development Tools"
"$INSTALL" rubygems ruby-devel rubygem-RedCloth
"$GEMINSTALL" jekyll