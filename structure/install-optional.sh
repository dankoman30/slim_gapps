#!/sbin/sh

if (grep -qi "mako" /proc/cpuinfo ); then
  echo "Installing Mako-specific google bits"
  cp -a /tmp/common/* /system/
fi

if (grep -qi "hammerhead" /proc/cpuinfo ); then
  echo "Installing Hammerhead-specific google bits"
  cp -a /tmp/common/* /system/
  cp -a /tmp/hammerhead/* /system/
fi

if (grep -qi "shamu" /proc/cpuinfo ); then
  echo "Installing Shamu-specific google bits"
  cp -a /tmp/common/* /system/
  cp -a /tmp/shamu/* /system/
fi

if (grep -qi "manta" /proc/cpuinfo ); then
  echo "Installing Manta-specific google bits"
  cp -a /tmp/common/* /system/
  cp -a /tmp/manta/* /system/
fi

if (grep -qi "flo" /proc/cpuinfo ); then
  echo "Installing Razor-specific google bits"
  cp -a /tmp/common/* /system/
fi

if (grep -qi "deb" /proc/cpuinfo ); then
  echo "Installing Razor-specific google bits"
  cp -a /tmp/common/* /system/
fi

if (grep -qi "tuna" /proc/cpuinfo ); then
  echo "Installing Tuna-specific google bits"
  cp -a /tmp/common/* /system/
  cp -a /tmp/tuna/* /system/
fi
 #zero
good_ffc_device() { #zero
  if [ -f /sdcard/.forcefaceunlock ]; then #zero
    return 0 #zero
  fi #zero
  if cat /proc/cpuinfo |grep -q Victory; then #zero
    return 1 #zero
  fi #zero
  if cat /proc/cpuinfo |grep -q herring; then #zero
    return 1 #zero
  fi #zero
  if cat /proc/cpuinfo |grep -q sun4i; then #zero
    return 1 #zero
  fi #zero
  return 0 #zero
} #zero
 #zero
if good_ffc_device && [ -e /system/etc/permissions/android.hardware.camera.front.xml ]; then #zero
  echo "Installing face detection support" #zero
  cp -a /tmp/face/* /system/ #zero
  chmod 755 /system/addon.d/71-gapps-faceunlock.sh #zero
elif  [ -d /system/vendor/pittpatt/ ]; then #zero
  rm -rf /system/vendor/pittpatt/ #zero
  rm  -f /system/app/FaceLock.apk #zero
  rm  -f /system/lib/libfacelock_jni.so #zero
  rm  -f /system/addon.d/71-gapps-faceunlock.sh #zero
fi #zero
rm -rf /tmp/face #zero