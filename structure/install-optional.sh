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