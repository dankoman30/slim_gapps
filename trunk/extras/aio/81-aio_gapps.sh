#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
vendor/pittpatt/models/recognition/face.face.y0-y0-22-b-N.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.6/head-y0-yi45-p0-pi45-rn30-ri30.5-v24.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.6/head-y0-yi45-p0-pi45-r0-ri30.4a-v24.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.6/head-y0-yi45-p0-pi45-rp30-ri30.5-v24.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.7/right_eye-y0-yi45-p0-pi45-r0-ri20.lg_32-2.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.7/nose_base-y0-yi45-p0-pi45-r0-ri20.lg_32.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.7/left_eye-y0-yi45-p0-pi45-r0-ri20.lg_32.bin
priv-app/GoogleLoginService.apk
priv-app/GoogleSearch.apk
priv-app/GoogleOneTimeInitializer.apk
priv-app/GooglePartnerSetup.apk
priv-app/GoogleBackupTransport.apk
priv-app/SetupWizard.apk
priv-app/talkback.apk
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
lib/libvorbisencoder.so
lib/libjni_t13n_shared_engine.so
lib/libWVphoneAPI.so
lib/libjni_latinime.so
lib/libjgcastservice.so
lib/libnetjni.so
lib/libwebrtc_audio_coding.so
lib/libgcastv2_support.so
lib/libpatts_engine_jni_api.so
lib/libwebrtc_audio_preprocessing.so
lib/libocrclient.so
lib/libAppDataSearch.so
lib/libfilterpack_facedetect.so
lib/libvcdecoder_jni.so
lib/libgoogle_hotword_jni.so
lib/libndk1.so
lib/libpatts_engine_jni_api_ub.210030011.so
lib/libcrashreporter.so
lib/libvideochat_jni.so
lib/libfacelock_jni.so
lib/libpatts_engine_jni_api_ub.so
lib/libmicro_hotword_jni.so
lib/libphotoeditor_native.so
lib/libmoviemaker-jni.so
lib/libwebp_android.so
lib/libgcastv2_base.so
lib/libfilterframework_jni.so
lib/liblinearalloc.so
lib/libgames_rtmp_jni.so
lib/librectifier-v7a.so
lib/libspeexwrapper.so
lib/libjni_eglfence.so
lib/libgcam_swig_jni.so
lib/libjni_mosaic.so
lib/libnativehelper_compat.so
lib/libgcam.so
lib/liblightcycle.so
lib/libjni_filtershow_filters.so
app/ChromeBookmarksSyncAdapter.apk
app/Gmail.apk
app/FaceLock.apk
app/CloudPrint2.apk
app/LatinIME.apk
app/GoogleHome.apk
app/YouTube.apk
app/GoogleContactsSyncAdapter.apk
app/GoogleTTS.apk
app/GoogleCalendarSyncAdapter.apk
app/Hangouts.apk
app/GoogleEars.apk
app/GenieWidget.apk
app/Music.apk
app/PlusOne.apk
usr/srec/en-US/phone_state_map
usr/srec/en-US/hotword_classifier
usr/srec/en-US/hotword_prompt.txt
usr/srec/en-US/grammar.config
usr/srec/en-US/dictation.config
usr/srec/en-US/c_fst
usr/srec/en-US/g2p_fst
usr/srec/en-US/endpointer_voicesearch.config
usr/srec/en-US/phonelist
usr/srec/en-US/dnn
usr/srec/en-US/hotword.config
usr/srec/en-US/ep_acoustic_model
usr/srec/en-US/hclg_shotword
usr/srec/en-US/metadata
usr/srec/en-US/norm_fst
usr/srec/en-US/hotword_normalizer
usr/srec/en-US/rescoring_lm
usr/srec/en-US/endpointer_dictation.config
usr/srec/en-US/normalizer
usr/srec/en-US/hotword_word_symbols
usr/srec/en-US/offensive_word_normalizer
usr/srec/en-US/compile_grammar.config
usr/srec/en-US/clg
usr/srec/en-US/dict
usr/srec/en-US/contacts.abnf
usr/srec/en-US/wordlist
usr/srec/en-US/hmmlist
usr/srec/en-US/commands.abnf
usr/srec/en-US/hmm_symbols
tts/lang_pico/es-ES_zl0_sg.bin
tts/lang_pico/fr-FR_nk0_sg.bin
tts/lang_pico/de-DE_ta.bin
tts/lang_pico/it-IT_ta.bin
tts/lang_pico/de-DE_gl0_sg.bin
tts/lang_pico/it-IT_cm0_sg.bin
tts/lang_pico/es-ES_ta.bin
tts/lang_pico/fr-FR_ta.bin
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
