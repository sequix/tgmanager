#!/bin/sh
# 2018/05/13
# install a .tar.gz package.

METADIR="$HOME/.tgmeta"
test -e "$METADIR" || mkdir "$METADIR"

test -d "$METADIR" || {
    echo "tgset: can't access meta folder $METADIR" 1>&2
    exit 1
}

prefix="${2-.}"
pkg_md5=$(md5sum "$1" | awk '{ print $1 }')
meta_file="$METADIR/$pkg_md5"

echo -n >$meta_file

test -e "$prefix" || {
    mkdir -p "$prefix"
    readlink -m "$prefix" >>$meta_file
}

tar -tf "$1" \
    | sed "s@^@$prefix/@g" \
    | xargs -d '\n' -n 1 readlink -m >>$meta_file

tar -xf "$1" -C "$prefix"
