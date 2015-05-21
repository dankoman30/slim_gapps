#!/sbin/sh

device=$(grep -io '\(mako\|hammerhead\|shamu\|manta\|flo\|deb\)' /proc/cpuinfo)

if [ $device ]; then
echo "Installing specific google bits"
cp -a /tmp/common/* /system/

if [ $device = "hammerhead" ]; then
  echo "Installing Hammerhead-specific google bits"
  cp -a /tmp/hammerhead/* /system/
fi

if [ $device = "shamu" ]; then
  echo "Installing Shamu-specific google bits"
  cp -a /tmp/shamu/* /system/
fi

if [ $device = "manta" ]; then
  echo "Installing Manta-specific google bits"
  cp -a /tmp/manta/* /system/
fi
fi
