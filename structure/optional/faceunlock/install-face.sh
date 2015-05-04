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
fi

good_ffc_device() {
  if [ -f /sdcard/.forcefaceunlock ]; then
    return 0
  fi
  if cat /proc/cpuinfo |grep -q Victory; then
    return 1
  fi
  if cat /proc/cpuinfo |grep -q herring; then
    return 1
  fi
  if cat /proc/cpuinfo |grep -q sun4i; then
    return 1
  fi
  return 0
}

if good_ffc_device && [ -e /system/etc/permissions/android.hardware.camera.front.xml ]; then
  echo "Installing face detection support"
  cp -a /tmp/face/* /system/
  chmod 755 /system/addon.d/71-gapps-faceunlock.sh
elif  [ -d /system/vendor/pittpatt/ ]; then
  rm -rf /system/vendor/pittpatt/
  rm  -f /system/app/FaceLock.apk
  rm  -f /system/lib/libfacelock_jni.so
  rm  -f /system/addon.d/71-gapps-faceunlock.sh
fi
rm -rf /tmp/face
