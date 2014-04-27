#!/usr/bin/env bash

set -e

# bootstrap a new workstation

OLDIFS="$IFS"
IFS=" "

# TODO: this is pure evil and will soon be replaced:
FILE_PATH=$(cd $(dirname $0);pwd);cd "$FILE_PATH"

# only the scripts in SCRIPTS will actually be called
SCRIPTS="devel sublimetext3 docker vagrant veewee webdevel"

echo Bootstrapping workstation.
for script in $SCRIPTS ; do
  SCRIPT_FILE=scripts/"$script".sh
  if [[ -f "$SCRIPT_FILE" ]] ; then
  	echo Executing "$SCRIPT_FILE" ;
  	"$SCRIPT_FILE" ;
  fi
done

IFS="$OLDIFS"