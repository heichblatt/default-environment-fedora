#!/usr/bin/env bash

set -e
source ./vars

# install packages necessary for development work

echo Installing development packages.

LC_ALL=C $GROUPINSTALL "Development Tools"
$INSTALL git gitg meld ShellCheck