#!/sbin/sh

# Variables
ARCH=$(grep ro.product.cpu.abi= /system/build.prop | cut -d "=" -f 2);
DEVICE=$(grep ro.product.device= /system/build.prop | cut -d "=" -f 2);
DYNAMIC="arm"
ANY="any"

if [ $ARCH == arm64-v8a ]; then
 $DYNAMIC="arm64"
fi

# COPY Applications TO SYSTEM
cp -af /tmp/$DYNAMIC/* /system

# COPY Additional files
for DIR in $(find /tmp/storage -maxdepth 1 -type d); 
do
	cp -af $DIR/$DYNAMIC/* /system 2>/dev/null 
	cp -af $DIR/$ANY/* /system 2>/dev/null 
done
