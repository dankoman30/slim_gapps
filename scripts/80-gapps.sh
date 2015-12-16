#!/sbin/sh
#
# This file is part of slim_gapps.
#
# slim_gapps is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# slim_gapps is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with slim_gapps.  If not, see <http://www.gnu.org/licenses/>.
#
# /system/addon.d/80-gapps.sh
#

# Execute
. /tmp/backuptool.functions

# Functions
file_getprop() {
    grep "^$2" "$1" | cut -d= -f2;
}

# Variables
rom_build_prop=/system/build.prop
device_architecture="$(file_getprop $rom_build_prop "ro.product.cpu.abilist=")"
# If the recommended field is empty, fall back to the deprecated one
if [ -z "$device_architecture" ]; then
  device_architecture="$(file_getprop $rom_build_prop "ro.product.cpu.abi=")"
fi

list_files() {
cat <<EOF
addon.d/80-gapps.sh
etc/g.prop
@file.list@
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    # Re-remove conflicting apks
    rm -rf /system/app/PartnerBookmarksProvider
    rm -rf /system/app/PicoTts
    rm -rf /system/app/Provision
    rm -rf /system/app/QuickSearchBox
    rm -rf /system/priv-app/PartnerBookmarksProvider
    rm -rf /system/priv-app/PicoTts
    rm -rf /system/priv-app/Provision
    rm -rf /system/priv-app/QuickSearchBox

    # Make required symbolic links
    if (echo "$device_architecture" | grep -qi "arm64"); then
      mkdir -p /system/app/FaceLock/lib/arm64 #mini
      ln -s /system/lib64/libfacelock_jni.so /system/app/FaceLock/lib/arm64/libfacelock_jni.so #mini
      mkdir -p /system/app/LatinIME/lib/arm64
      ln -s /system/lib64/libjni_latinime.so /system/app/LatinIME/lib/arm64/libjni_latinime.so
      ln -s /system/lib64/libjni_latinimegoogle.so /system/app/LatinIME/lib/arm64/libjni_latinimegoogle.so
    elif (echo "$device_architecture" | grep -i "armeabi" | grep -qiv "arm64"); then
      mkdir -p /system/app/FaceLock/lib/arm #mini
      ln -s /system/lib/libfacelock_jni.so /system/app/FaceLock/lib/arm/libfacelock_jni.so #mini
      mkdir -p /system/app/LatinIME/lib/arm
      ln -s /system/lib/libjni_latinime.so /system/app/LatinIME/lib/arm/libjni_latinime.so
      ln -s /system/lib/libjni_latinimegoogle.so /system/app/LatinIME/lib/arm/libjni_latinimegoogle.so
    fi
  ;;
esac
