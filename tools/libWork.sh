#!/bin/bash

#This file is part of The Open GApps script of @mfonville.
#
#    The Open GApps scripts are free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    These scripts are distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#

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
