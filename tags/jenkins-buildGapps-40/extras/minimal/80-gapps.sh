#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
priv-app/GoogleLoginService.apk
priv-app/GoogleOneTimeInitializer.apk
priv-app/GooglePartnerSetup.apk
priv-app/GoogleBackupTransport.apk
priv-app/SetupWizard.apk
priv-app/GoogleServicesFramework.apk
priv-app/PrebuiltGmsCore.apk
priv-app/GoogleFeedback.apk
priv-app/Phonesky.apk
framework/com.google.widevine.software.drm.jar
framework/com.google.android.media.effects.jar
framework/com.google.android.maps.jar
framework/com.google.android.camera2.jar
etc/preferred-apps/google.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/permissions/features.xml
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.android.media.effects.xml
etc/permissions/com.google.android.camera2.xml
etc/g.prop
lib/libgoogle_recognizer_jni_l.so
lib/libjni_eglfence.so
lib/libvorbisencoder.so
lib/libjni_t13n_shared_engine.so
lib/libWVphoneAPI.so
lib/libjgcastservice.so
lib/libnetjni.so
lib/libwebrtc_audio_coding.so
lib/libgcastv2_support.so
lib/libpatts_engine_jni_api.so
lib/libgcam_swig_jni.so
lib/libwebrtc_audio_preprocessing.so
lib/libocrclient.so
lib/libAppDataSearch.so
lib/libjni_mosaic.so
lib/libfilterpack_facedetect.so
lib/libvcdecoder_jni.so
lib/libgoogle_hotword_jni.so
lib/libndk1.so
lib/libpatts_engine_jni_api_ub.210030011.so
lib/libcrashreporter.so
lib/libvideochat_jni.so
lib/libnativehelper_compat.so
lib/libfacelock_jni.so
lib/libpatts_engine_jni_api_ub.so
lib/libmicro_hotword_jni.so
lib/libphotoeditor_native.so
lib/libgcam.so
lib/liblightcycle.so
lib/libmoviemaker-jni.so
lib/libwebp_android.so
lib/libgcastv2_base.so
lib/libfilterframework_jni.so
lib/liblinearalloc.so
lib/libjni_filtershow_filters.so
lib/libgames_rtmp_jni.so
lib/librectifier-v7a.so
lib/libspeexwrapper.so
app/ChromeBookmarksSyncAdapter.apk
app/Gmail.apk
app/CloudPrint2.apk
app/YouTube.apk
app/GoogleContactsSyncAdapter.apk
app/GoogleCalendarSyncAdapter.apk
app/Hangouts.apk
app/Music.apk
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
