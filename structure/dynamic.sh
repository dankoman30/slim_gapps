#!/sbin/sh

# Variables
ARCH=`grep ro.product.cpu.abi= /system/build.prop | grep armeabi`
ARCH64=`grep ro.product.cpu.abi= /system/build.prop | grep arm64`
SETUPWIZARD=`grep ro.build.characteristics /system/build.prop | grep tablet`

# PrebuiltGmsCore
if [ ! $ARCH == "" ]; then
  cp -rf /tmp/PrebuiltGmsCore/arm/* /system
elif [ ! $ARCH64 == "" ]; then
  cp -rf /tmp/PrebuiltGmsCore/arm64/* /system
fi

# SetupWizard
if [ ! $SETUPWIZARD == "" ]; then
  cp -rf /tmp/SetupWizard/tablet/* /system
else
  cp -rf /tmp/SetupWizard/phone/* /system
fi

# LatinIME swypelib
if [ ! $ARCH == "" ]; then
  cp -rf /tmp/LatinIME_swypelib/lib/* /system/lib
  mkdir -p /system/app/LatinIME/lib/arm
  ln -s /system/lib/libjni_latinime.so /system/app/LatinIME/lib/arm/libjni_latinime.so
  ln -s /system/lib/libjni_latinimegoogle.so /system/app/LatinIME/lib/arm/libjni_latinimegoogle.so
elif [ ! $ARCH64 == "" ]; then
  cp -rf /tmp/LatinIME_swypelib/lib64/* /system/lib64
  mkdir -p /system/app/LatinIME/lib/arm64
  ln -s /system/lib64/libjni_latinime.so /system/app/LatinIME/lib/arm64/libjni_latinime.so
  ln -s /system/lib64/libjni_latinimegoogle.so /system/app/LatinIME/lib/arm64/libjni_latinimegoogle.so
fi

# FaceLock #mini
if [ ! $ARCH == "" ]; then #mini
  cp -rf /tmp/FaceLock/arm/* /system #mini
  mkdir -p /system/app/FaceLock/lib/arm #mini
  ln -s /system/lib/libfacelock_jni.so /system/app/FaceLock/lib/arm/libfacelock_jni.so #mini
elif [ ! $ARCH64 == "" ]; then #mini
  cp -rf /tmp/FaceLock/arm64/* /system #mini
  mkdir -p /system/app/FaceLock/lib/arm64 #mini
  ln -s /system/lib64/libfacelock_jni.so /system/app/FaceLock/lib/arm64/libfacelock_jni.so #mini
fi #mini

# Velvet #mini
if [ ! $ARCH == "" ]; then #mini
  cp -rf /tmp/Velvet/arm/* /system #mini
elif [ ! $ARCH64 == "" ]; then #mini
  cp -rf /tmp/Velvet/arm64/* /system #mini
fi #mini

exit 0
