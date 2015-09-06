#!/bin/sh
#
# $1 - unrar
# $2 - archive
# $3 - output directory with tail slash
# $5 - archive files to delete
# $6 - unpack temp dir

if [ "$6" != '' ] ; then
	"$1" x -ai -c- -kb -o+ -p- -y -v -- "$2" "$6"
	ret=$?
else
	"$1" x -ai -c- -kb -o+ -p- -y -v -- "$2" "$3"
	ret=$?
fi

ret=$?
if [ $ret -le 1 ] && [ "$5" != '' ] ; then
	rm "$5"
fi

if [ "$6" != '' ] ; then
	mkdir -p "$3"
	mv "$6"* "$3"
	rm -r "$6"
fi
