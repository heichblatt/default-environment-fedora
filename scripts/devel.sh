#!/usr/bin/env bash

set -e
source ./vars

# install packages necessary for development work

$(GROUPINSTALL) "Development Tools"
$(INSTALL) git gitg meld