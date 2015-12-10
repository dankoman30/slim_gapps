#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
addon.d/80-gapps.sh
etc/g.prop
etc/permissions/com.google.android.camera2.xml
framework/com.google.android.camera2.jar
lib/libgcam.so
lib/libgcam_swig_jni.so
lib/libjni_eglfence.so
lib/liblightcycle.so
lib/libnativehelper_compat.so
app/FaceLock/FaceLock.apk
app/FaceLock/lib/arm/libfacelock_jni.so
app/FaceLock/lib/arm64/libfacelock_jni.so
lib/libfilterpack_facedetect.so
lib/libjni_latinime.so
lib/libjni_latinimegoogle.so
lib64/libfilterpack_facedetect.so
lib64/libjni_latinime.so
lib64/libjni_latinimegoogle.so
priv-app/HotwordEnrollment/HotwordEnrollment.apk
priv-app/PrebuiltGmsCore/lib/arm/libAppDataSearch.so
priv-app/PrebuiltGmsCore/lib/arm/libconscrypt_gmscore_jni.so
priv-app/PrebuiltGmsCore/lib/arm/libdirect-audio.so
priv-app/PrebuiltGmsCore/lib/arm/libgcastv2_base.so
priv-app/PrebuiltGmsCore/lib/arm/libgcastv2_support.so
priv-app/PrebuiltGmsCore/lib/arm/libgmscore.so
priv-app/PrebuiltGmsCore/lib/arm/libgms-ocrclient.so
priv-app/PrebuiltGmsCore/lib/arm/libjgcastservice.so
priv-app/PrebuiltGmsCore/lib/arm/libNearbyApp.so
priv-app/PrebuiltGmsCore/lib/arm/libsslwrapper_jni.so
priv-app/PrebuiltGmsCore/lib/arm/libwearable-selector.so
priv-app/PrebuiltGmsCore/lib/arm/libWhisper.so
priv-app/PrebuiltGmsCore/lib/arm64/libAppDataSearch.so
priv-app/PrebuiltGmsCore/lib/arm64/libconscrypt_gmscore_jni.so
priv-app/PrebuiltGmsCore/lib/arm64/libdirect-audio.so
priv-app/PrebuiltGmsCore/lib/arm64/libgcastv2_base.so
priv-app/PrebuiltGmsCore/lib/arm64/libgcastv2_support.so
priv-app/PrebuiltGmsCore/lib/arm64/libgmscore.so
priv-app/PrebuiltGmsCore/lib/arm64/libgms-ocrclient.so
priv-app/PrebuiltGmsCore/lib/arm64/libjgcastservice.so
priv-app/PrebuiltGmsCore/lib/arm64/libNearbyApp.so
priv-app/PrebuiltGmsCore/lib/arm64/libsslwrapper_jni.so
priv-app/PrebuiltGmsCore/lib/arm64/libwearable-selector.so
priv-app/PrebuiltGmsCore/lib/arm64/libWhisper.so
priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk
priv-app/Velvet/lib/arm/libcronet.so
priv-app/Velvet/lib/arm/libgoogle_speech_jni.so
priv-app/Velvet/lib/arm/libgoogle_speech_micro_jni.so
priv-app/Velvet/lib/arm64/libcronet.so
priv-app/Velvet/lib/arm64/libgoogle_speech_jni.so
priv-app/Velvet/lib/arm64/libgoogle_speech_micro_jni.so
priv-app/Velvet/Velvet.apk
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

  ;;
esac
