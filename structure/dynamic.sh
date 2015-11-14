#!/sbin/sh

# Variables
ARCH=`grep ro.product.cpu.abi= /system/build.prop | cut -d "=" -f 2`
SETUPWIZARD=`grep ro.build.characteristics /system/build.prop | grep tablet`

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

# LatinIME swypelib
if [ $ARCH == armeabi-v7a ]; then
 cp -rf /tmp/LatinIME_swypelib/lib/* /system/lib
elif [ $ARCH == arm64-v8a ]; then
 cp -rf /tmp/LatinIME_swypelib/lib64/* /system/lib64
else
 cp -rf /tmp/LatinIME_swypelib/lib/* /system/lib
fi

# FaceLock #mini
if [ $ARCH == armeabi-v7a ]; then #mini
 cp -rf /tmp/FaceLock/arm/* /system #mini
elif [ $ARCH == arm64-v8a ]; then #mini
 cp -rf /tmp/FaceLock/arm64/* /system #mini
else #mini
 cp -rf /tmp/FaceLock/arm/* /system #mini
fi #mini

# Velvet #mini
if [ $ARCH == armeabi-v7a ]; then #mini
 cp -rf /tmp/Velvet/arm/* /system #mini
elif [ $ARCH == arm64-v8a ]; then #mini
 cp -rf /tmp/Velvet/arm64/* /system #mini
else #mini
 cp -rf /tmp/Velvet/arm/* /system #mini
fi #mini
