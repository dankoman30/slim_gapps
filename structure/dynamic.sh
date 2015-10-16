#!/sbin/sh

# Variables
ARCH=$(grep ro.product.cpu.abi= /system/build.prop | cut -d "=" -f 2);

# PrebuiltGmsCore
if [ $ARCH == armeabi-v7a ]; then
 cp -af /tmp/PrebuiltGmsCore/arm/* /system
elif [ $ARCH == arm64-v8a ]; then
 cp -af /tmp/PrebuiltGmsCore/arm64/* /system
else
 cp -af /tmp/PrebuiltGmsCore/arm/* /system
fi
