#!/sbin/sh

# Variables
ARCH=$(grep ro.product.cpu.abi= /system/build.prop | cut -d "=" -f 2);
DEVICE=$(grep ro.product.device= /system/build.prop | cut -d "=" -f 2);

# HotwordEnrollment
if [ $DEVICE == flounder ]; then
 cp -af /tmp/HotwordEnrollment/arm64/* /system
fi

if [ $DEVICE == Flounder ]; then
 cp -af /tmp/HotwordEnrollment/arm64/* /system
fi

# PrebuiltGmsCore
# IF 64-BIT ARCHITECTURE INSTALL 240
if [ $ARCH == arm64-v8a ]; then
 cp -af /tmp/PrebuiltGmsCore/240/* /system
 cp -af /tmp/PrebuiltGmsCore/arm64/* /system
else
# COPY 230 (ARM VERSION) TO SYSTEM
 cp -af /tmp/PrebuiltGmsCore/230/* /system
 cp -af /tmp/PrebuiltGmsCore/arm/* /system
fi

# Swypelib
if [ $ARCH == armeabi-v7a ]; then
 cp -af /tmp/Swypelib/lib/* /system/lib
elif [ $ARCH == arm64-v8a ]; then
 cp -af /tmp/Swypelib/lib64/* /system/lib64
else
 cp -af /tmp/Swypelib/lib/* /system/lib
fi

# FaceLock #mini
if [ $ARCH == armeabi-v7a ]; then #mini
 cp -af /tmp/FaceLock/arm/* /system #mini
elif [ $ARCH == arm64-v8a ]; then #mini
 cp -af /tmp/FaceLock/arm64/* /system #mini
else #mini
 cp -af /tmp/FaceLock/arm/* /system #mini
fi #mini
#mini
# Velvet #mini
if [ $ARCH == armeabi-v7a ]; then #mini
 cp -af /tmp/Velvet/arm/* /system #mini
elif [ $ARCH == arm64-v8a ]; then #mini
 cp -af /tmp/Velvet/arm64/* /system #mini
else #mini
 cp -af /tmp/Velvet/arm/* /system #mini
fi #mini
