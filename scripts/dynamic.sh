#!/sbin/sh
#
# This file is part of slim_gapps.
#
# slim_gapps is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# slim_gapps is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with slim_gapps.  If not, see <http://www.gnu.org/licenses/>.

# Functions
file_getprop() {
    grep "^$2" "$1" | cut -d= -f2;
}

# Variables
rom_build_prop=/system/build.prop
device_architecture="$(file_getprop $rom_build_prop "ro.product.cpu.abilist=")"
# If the recommended field is empty, fall back to the deprecated one
if [ -z "$device_architecture" ]; then
  device_architecture="$(file_getprop $rom_build_prop "ro.product.cpu.abi=")"
fi
is_tablet="$(grep ro.build.characteristics $rom_build_prop | grep tablet)"

# PrebuiltGmsCore
if (echo "$device_architecture" | grep -qi "arm64"); then
  cp -rf /tmp/PrebuiltGmsCore/arm64/* /system
elif (echo "$device_architecture" | grep -i "armeabi" | grep -qiv "arm64"); then
  cp -rf /tmp/PrebuiltGmsCore/arm/* /system
fi

# SetupWizard
if [ -n "$is_tablet" ]; then
  cp -rf /tmp/SetupWizard/tablet/* /system
else
  cp -rf /tmp/SetupWizard/phone/* /system
fi

# LatinIME swypelib
if (echo "$device_architecture" | grep -qi "arm64"); then
  cp -rf /tmp/LatinIME_swypelib/lib64/* /system/lib64
  mkdir -p /system/app/LatinIME/lib/arm64
  ln -s /system/lib64/libjni_latinime.so /system/app/LatinIME/lib/arm64/libjni_latinime.so
  ln -s /system/lib64/libjni_latinimegoogle.so /system/app/LatinIME/lib/arm64/libjni_latinimegoogle.so
elif (echo "$device_architecture" | grep -i "armeabi" | grep -qiv "arm64"); then
  cp -rf /tmp/LatinIME_swypelib/lib/* /system/lib
  mkdir -p /system/app/LatinIME/lib/arm
  ln -s /system/lib/libjni_latinime.so /system/app/LatinIME/lib/arm/libjni_latinime.so
  ln -s /system/lib/libjni_latinimegoogle.so /system/app/LatinIME/lib/arm/libjni_latinimegoogle.so
fi

# libfrsdk
if (echo "$device_architecture" | grep -qi "arm64"); then
  cp -rf /tmp/libfrsdk/arm64/* /system
elif (echo "$device_architecture" | grep -i "armeabi" | grep -qiv "arm64"); then
  cp -rf /tmp/libfrsdk/arm/* /system
fi

# FaceLock #mini
if (echo "$device_architecture" | grep -qi "arm64"); then #mini
  cp -rf /tmp/FaceLock/arm64/* /system #mini
  mkdir -p /system/app/FaceLock/lib/arm64 #mini
  ln -s /system/lib64/libfacelock_jni.so /system/app/FaceLock/lib/arm64/libfacelock_jni.so #mini
elif (echo "$device_architecture" | grep -i "armeabi" | grep -qiv "arm64"); then #mini
  cp -rf /tmp/FaceLock/arm/* /system #mini
  mkdir -p /system/app/FaceLock/lib/arm #mini
  ln -s /system/lib/libfacelock_jni.so /system/app/FaceLock/lib/arm/libfacelock_jni.so #mini
fi #mini

# Velvet #mini
if (echo "$device_architecture" | grep -qi "arm64"); then #mini
  cp -rf /tmp/Velvet/arm64/* /system #mini
elif (echo "$device_architecture" | grep -i "armeabi" | grep -qiv "arm64"); then #mini
  cp -rf /tmp/Velvet/arm/* /system #mini
fi #mini
