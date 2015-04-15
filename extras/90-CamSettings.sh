#!/sbin/sh
#
# Script: /system/addon.d/90-CamSettings.sh
# This addon.d script backs up camera tweaks

. /tmp/backuptool.functions

list_files() {
cat << EOF
app/CameraNext/CameraNextMod.apk
etc/media_profiles.xml
lib/libjni_mosaic.so
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
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
    # Stub
  ;;
esac
