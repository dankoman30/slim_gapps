#!/sbin/sh

device=$((grep -io '\( mako$\| hammerhead$\| shamu$\| manta$\| flo$\| deb$\| volantis$\| flounder$\)' /proc/cpuinfo)|awk '{print tolower($0)}')

if [ $device ]; then

if [ $device = "flounder" -o  $device = "volantis" ]; then
  cp -af /tmp/flounder/* /system/
  exit
fi

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