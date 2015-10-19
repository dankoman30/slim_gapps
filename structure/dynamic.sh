#!/sbin/sh

# Variables
ARCH=`grep ro.product.cpu.abi= /system/build.prop | cut -d "=" -f 2`
DEVICE=`grep ro.product.device= /system/build.prop | cut -d "=" -f 2`
SETUPWIZARD=`grep ro.build.characteristics /system/build.prop | grep tablet`

# Cleanup
if ls /data/app/com.android.vending* 1> /dev/null 2>&1; then
 rm -rf /data/app/com.android.vending*
elif ls /data/app/com.google.android.gms* 1> /dev/null 2>&1; then
 rm -rf /data/app/com.google.android.gms*
elif ls /data/app/com.google.android.googlequicksearchbox* 1> /dev/null 2>&1; then
 rm -rf /data/app/com.google.android.googlequicksearchbox*
elif ls /data/app/com.google.android.tts* 1> /dev/null 2>&1; then
 rm -rf /data/app/com.google.android.tts*
fi

# HotwordEnrollment
if [ $DEVICE == flounder ]; then
 cp -rf /tmp/HotwordEnrollment/arm64/* /system
elif [ $DEVICE == Flounder ]; then
 cp -rf /tmp/HotwordEnrollment/arm64/* /system
elif [ $DEVICE == volantis ]; then
 cp -rf /tmp/HotwordEnrollment/arm64/* /system
elif [ $DEVICE == Volantis ]; then
 cp -rf /tmp/HotwordEnrollment/arm64/* /system
fi

# PrebuiltGmsCore
if [ $ARCH == armeabi-v7a ]; then
 cp -rf /tmp/PrebuiltGmsCore/arm/* /system
elif [ $ARCH == arm64-v8a ]; then
 cp -rf /tmp/PrebuiltGmsCore/arm64/* /system
fi

# SetupWizard
if [ ! $SETUPWIZARD == "" ]; then
 cp -rf /tmp/SetupWizard/tablet/* /system
else
 cp -rf /tmp/SetupWizard/phone/* /system
fi

# Swypelib
if [ $ARCH == armeabi-v7a ]; then
 cp -rf /tmp/Swypelib/lib/* /system/lib
elif [ $ARCH == arm64-v8a ]; then
 cp -rf /tmp/Swypelib/lib64/* /system/lib64
else
 cp -rf /tmp/Swypelib/lib/* /system/lib
fi

# FaceLock #mini
if [ $ARCH == armeabi-v7a ]; then #mini
 cp -rf /tmp/FaceLock/arm/* /system #mini
 cp -rf /tmp/FaceLock/vendor/* /system/vendor #mini
elif [ $ARCH == arm64-v8a ]; then #mini
 cp -rf /tmp/FaceLock/arm64/* /system #mini
 cp -rf /tmp/FaceLock/vendor/* /system/vendor #mini
else #mini
 cp -rf /tmp/FaceLock/arm/* /system #mini
 cp -rf /tmp/FaceLock/vendor/* /system/vendor #mini
fi #mini

# Velvet #mini
if [ $ARCH == armeabi-v7a ]; then #mini
 cp -rf /tmp/Velvet/arm/* /system #mini
 cp -rf /tmp/Velvet/usr/* /system/usr #mini
elif [ $ARCH == arm64-v8a ]; then #mini
 cp -rf /tmp/Velvet/arm64/* /system #mini
 cp -rf /tmp/Velvet/usr/* /system/usr #mini
else #mini
 cp -rf /tmp/Velvet/arm/* /system #mini
 cp -rf /tmp/Velvet/usr/* /system/usr #mini
fi #mini

exit 0
