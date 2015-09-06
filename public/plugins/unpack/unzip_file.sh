#!/bin/sh
#
# $1 - unzip
# $2 - archive
# $3 - output directory with tail slash
# $5 - archive files to delete
# $6 - unpack temp dir

mkdir -p "$3"

if [ "$6" != '' ] ; then
	mkdir -p "$6"
	"$1" -o "$2" -d "$6"
	ret=$?
else
	"$1" -o "$2" -d "$3"
	ret=$?
fi

[ $ret -le 1 ] && echo 'All OK'
if [ $ret -le 1 ] && [ "$5" != '' ] ; then
	rm "$5"
fi

if [ "$6" != '' ] ; then
	mv "$6"* "$3"
	rm -r "$6"
fi

exit $ret
