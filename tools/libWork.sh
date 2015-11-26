#!/bin/bash

# define variables
targetdir="$1" #use apk directory as parameter
targetapk="$targetdir/$(basename "$targetdir").apk"
toolsdir="$(realpath .)"

# repackage libs
unzip -q -o "$targetapk" -d "$targetdir" "lib/*"
zip -q -d "$targetapk" "lib/*" #delete all libs
cd "$targetdir"
zip -q -r -D -Z store -b "$targetdir" "$targetapk" "lib/"
rm -rf "$targetdir/lib/"

# zipalign
mv "$targetapk" "$targetapk.orig"
cd "$toolsdir/bin"
./zipalign -f -p 4 "$targetapk.orig" "$targetapk"
rm "$targetapk.orig"
