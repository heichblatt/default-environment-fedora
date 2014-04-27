#!/usr/bin/env bash

set -e

# bootstrap a new workstation

for script in devel sublimetext3 vagrant veewee webdevel ; 
	do ./scripts/"$script" ; done