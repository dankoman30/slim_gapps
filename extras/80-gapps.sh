#!/sbin/sh
# 
# /system/addon.d/80-gapps.sh
#

# Execute
. /tmp/backuptool.functions

# Variables
ARCH=`grep ro.product.cpu.abi= /system/build.prop | cut -d "=" -f 2`

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
    if [ $ARCH == armeabi-v7a ]; then
      mkdir -p /system/app/FaceLock/lib/arm #mini
      ln -s /system/lib/libfacelock_jni.so /system/app/FaceLock/lib/arm/libfacelock_jni.so #mini
      mkdir -p /system/app/LatinIME/lib/arm
      ln -s /system/lib/libjni_latinime.so /system/app/LatinIME/lib/arm/libjni_latinime.so
      ln -s /system/lib/libjni_latinimegoogle.so /system/app/LatinIME/lib/arm/libjni_latinimegoogle.so
    elif [ $ARCH == arm64-v8a ]; then
      mkdir -p /system/app/FaceLock/lib/arm64 #mini
      ln -s /system/lib64/libfacelock_jni.so /system/app/FaceLock/lib/arm64/libfacelock_jni.so #mini
      mkdir -p /system/app/LatinIME/lib/arm64
      ln -s /system/lib64/libjni_latinime.so /system/app/LatinIME/lib/arm64/libjni_latinime.so
      ln -s /system/lib64/libjni_latinimegoogle.so /system/app/LatinIME/lib/arm64/libjni_latinimegoogle.so
    else
      mkdir -p /system/app/FaceLock/lib/arm #mini
      ln -s /system/lib/libfacelock_jni.so /system/app/FaceLock/lib/arm/libfacelock_jni.so #mini
      mkdir -p /system/app/LatinIME/lib/arm
      ln -s /system/lib/libjni_latinime.so /system/app/LatinIME/lib/arm/libjni_latinime.so
      ln -s /system/lib/libjni_latinimegoogle.so /system/app/LatinIME/lib/arm/libjni_latinimegoogle.so
    fi
  ;;
esac
