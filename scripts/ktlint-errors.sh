#!/bin/bash

if [ ! -d .git ] ; then
	echo "No .git directory found, are in the root of a repo?"
	exit 1
fi

FILES=`git status | grep "\.kt$" | cut -d: -f2 | awk NF=NF RS= OFS=' '`


if [ -z "$FILES" ] ; then
	echo "No modified .kt files found."
	exit 1
fi


ktlint --editorconfig=~/scratch-pad/ktlint.conf $FILES

if [ $? -eq 0 ] ; then
	echo "All modified kotlin files ok"
fi
