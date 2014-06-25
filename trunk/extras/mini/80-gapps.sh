#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
addon.d/80-gapps.sh
app/ChromeBookmarksSyncAdapter.apk
app/CloudPrint2.apk
app/Gmail.apk
app/GoogleCalendarSyncAdapter.apk
app/GoogleContactsSyncAdapter.apk
app/Hangouts.apk
etc/g.prop
etc/permissions/com.google.android.camera2.xml
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.android.media.effects.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/permissions/features.xml
etc/preferred-apps/google.xml
framework/com.google.android.camera2.jar
framework/com.google.android.maps.jar
framework/com.google.android.media.effects.jar
framework/com.google.widevine.software.drm.jar
lib/libAppDataSearch.so
lib/libWVphoneAPI.so
lib/libcrashreporter.so
lib/libfacelock_jni.so
lib/libfilterframework_jni.so
lib/libfilterpack_facedetect.so
lib/libframesequence.so
lib/libgames_rtmp_jni.so
lib/libgcastv2_base.so
lib/libgcastv2_support.so
lib/libjgcastservice.so
lib/libjni_t13n_shared_engine.so
lib/liblinearalloc.so
lib/libm2ts_player.so
lib/libmicro_hotword_jni.so
lib/libndk1.so
lib/libnetjni.so
lib/libocrclient.so
lib/libpatts_engine_jni_api.so
lib/libpatts_engine_jni_api_ub.210030103.so
lib/libpatts_engine_jni_api_ub.so
lib/librectifier-v7a.so
lib/libspeexwrapper.so
lib/libvcdecoder_jni.so
lib/libvideochat_jni.so
lib/libvorbisencoder.so
lib/libwebp_android.so
lib/libwebrtc_audio_coding.so
lib/libwebrtc_audio_preprocessing.so
priv-app/GoogleBackupTransport.apk
priv-app/GoogleFeedback.apk
priv-app/GoogleLoginService.apk
priv-app/GoogleOneTimeInitializer.apk
priv-app/GooglePartnerSetup.apk
priv-app/GoogleServicesFramework.apk
priv-app/Phonesky.apk
priv-app/PrebuiltGmsCore.apk
priv-app/SetupWizard.apk
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
    # Stub
  ;;
esac
