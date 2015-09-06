#!/bin/sh
#
# $1 - unrar
# $2 - input directory with tail slash
# $3 - output directory with tail slash
# $5 - archive files to delete
# $6 - unpack temp dir

ret=0

process_directory()
{
	"$1" x -ai -c- -kb -o+ -p- -y -v -- "$2." "$3"
	last=$?
	[ $last -le 1 ] && ret=$last
	for fn in "$2"* ; do
		if [ -d "${fn}" ] && [ ! -L "${fn}" ] ; then
			name=$(basename "${fn}")
			process_directory "$1" "${fn}/" "$3${name}/"
			last=$?
			[ $last -gt 1 ] && ret=$last
		fi
	done
	return $ret
}

if [ "$6" != '' ] ; then
	process_directory "$1" "$2" "$6"
	ret=$?
else
	process_directory "$1" "$2" "$3"
	ret=$?
fi

ret=$?
if [ $ret -le 1 ] && [ "$5" != '' ] ; then
	OIFS=$IFS
	IFS=';'
	for file in "$5"
	do
		rm $file
	done
	IFS=$OIFS
fi

if [ "$6" != '' ] ; then
	mkdir -p "$3"
	mv "$6"* "$3"
	rm -r "$6"
fi

