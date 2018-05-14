#!/bin/sh
# 2018/05/13
# remove a installed .tar.gz package

METADIR="$HOME/.tgmeta"

test -d "$METADIR" || {
    echo "tgrml: can't access meta folder $METADIR" 1>&2
    exit 1
}

pkg_md5=$(md5sum "$1" | awk '{ print $1 }')
meta_file="$METADIR/$pkg_md5"

test -f "$meta_file" || {
    echo "tgrml: can't access meta file $meta_file" 1>&2
    exit 1
}

xargs -a "$meta_file" rm -rf
rm -f "$meta_file"
