#!/usr/bin/env bash

set -e

# bootstrap a new workstation

# TODO: this is pure evil and will soon be replaced:
FILE_PATH=$(cd $(dirname $0);pwd);cd "$FILE_PATH"

echo Bootstrapping workstation.
for script in devel sublimetext3 vagrant veewee webdevel ; 
	do ./scripts/"$script".sh ; done