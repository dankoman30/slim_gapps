#!/sbin/sh

#    This file contains parts from the scripts taken from the TK GApps Project by TKruzze and osmOsis.
#
#    The TK GApps scripts are free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    These scripts are distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

# Functions
set_metadata_recursive() {
  dir="$1";
  shift;
  until [ ! "$2" ]; do
    case $1 in
      uid) chown -R $2 $dir;;
      gid) chown -R :$2 $dir;;
      dmode) find "$dir" -type d -exec chmod $2 {} +;;
      fmode) find "$dir" -type f -exec chmod $2 {} +;;
      capabilities) ;;
      selabel)
        for i in /system/bin/toybox /system/toolbox /system/bin/toolbox; do
          find "$dir" -exec LD_LIBRARY_PATH=/system/lib $i chcon -h $2 {} +;
          find "$dir" -exec LD_LIBRARY_PATH=/system/lib $i chcon $2 {} +;
        done;
        find "$dir" -exec chcon -h $2 '{}' +;
        find "$dir" -exec chcon $2 '{}' +;
      ;;
      *) ;;
    esac;
    shift 2;
  done;
}

# Change pittpatt folders to root:shell per Google Factory Settings
find "/system/vendor/pittpatt" -type d -exec chown 0.2000 '{}' \;

# Set metadata
set_metadata_recursive "/system/addon.d" "/system/app" "/system/etc/permissions" "/system/etc/preferred-apps" "/system/etc/sysconfig" "/system/framework" "/system/lib" "/system/lib64" "/system/priv-app" "/system/usr/srec" "/system/vendor/lib" "/system/vendor/lib64" "/system/vendor/pittpatt";