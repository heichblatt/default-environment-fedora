#!/usr/bin/env bash

set -e
source ./vars

# install veewee

echo Installing veewee.

$INSTALL libxml2 libxml2-devel libxslt libxslt-devel zlib-devel
$GEMINSTALL veewee