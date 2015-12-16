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

# vars
g_prop=/system/etc/g.prop
rom_build_prop=/system/build.prop
current_gapps_size_kb=0
buffer_kb=50000
force_install=0
# STATUS for use in edify (1=not enough space, 2=non-slim gapps installed,
# 3=rom not installed, 4=rom and gapps versions don't match,
# 5=architecture mismatch, 10=force install)
STATUS=0

# functions
special_status() {
    STATUS=${1}
}

# get file descriptor for output
OUTFD=$(ps | grep -v grep | grep -oE "update-binary(.*)" | cut -d " " -f 3)

ui_print() {
    if [ -n "$OUTFD" ]; then
        echo "ui_print ${1} " 1>&$OUTFD;
        echo "ui_print " 1>&$OUTFD;
    else
        echo "${1}";
    fi;
}

file_getprop() {
    grep "^$2" "$1" | cut -d= -f2;
}

if [ -e /system/priv-app/GoogleServicesFramework/GoogleServicesFramework.apk -a -e /system/priv-app/GoogleLoginService/GoogleLoginService.apk ]
then
    # gapps are installed
    if [ -e /system/etc/g.prop -a -n "$(grep slim $g_prop)" -a -n "$(grep ro.addon.size $g_prop)" ]
    then
        # and it is a recent slim gapps package
        ui_print "  found existing slim gapps package"
        current_gapps_size_kb=$(($(file_getprop $g_prop ro.addon.size) / 1024))
    else
        special_status 2
    fi
fi

if [ -e $rom_build_prop ]
then
    rom_build_name=$(file_getprop $rom_build_prop ro.build.display.id)
    ui_print "rom build: $rom_build_name"

    # prevent installation of incorrect gapps version
    rom_version_required=@version@
    rom_version_installed=$(file_getprop $rom_build_prop ro.build.version.release)
    ui_print "rom version required: $rom_version_required"
    ui_print "rom version installed: $rom_version_installed"
    if [ -z "${rom_version_installed##*$rom_version_required*}" ]
    then
        ui_print "ROM and GAPPS versions match! Proceeding...";
    else
        special_status 4
    fi

    # prevent installation of gapps on wrong architecture
    # (this package supports armeabi, armeabi-v7a, and arm64-v8.
    #  so, as long as the retrieved architecture from build.prop contains
    #  "arm" then the device is supported.)
    architecture_required=arm
    architecture_installed="$(file_getprop $rom_build_prop "ro.product.cpu.abilist=")"
    # If the recommended field is empty, fall back to the deprecated one
    if [ -z "$architecture_installed" ]; then
      architecture_installed="$(file_getprop $rom_build_prop "ro.product.cpu.abi=")"
    fi
    ui_print "architecture required: $architecture_required"
    ui_print "current cpu architecture(s) supported: $architecture_installed"
    if ! (echo "$architecture_installed" | grep -qi "$architecture_required"); then
        special_status 5
    else
        ui_print "architecture check passed! Proceeding...";
    fi

    # conditions in rom's build.prop that should force installation
    if [ -n "$(grep ArchiDroid $rom_build_prop)" ]
    then
        force_install=1
    fi
else
    # rom is not installed - special_status code 3
    special_status 3
fi

# Read and save system partition size details
df=$(df /system | tail -n 1)
case $df in
    /dev/block/*) df=$(echo $df | awk '{ print substr($0, index($0,$2)) }');;
esac
free_system_size_kb=$(echo $df | awk '{ print $3 }')

# add currently installed gapps size (since they will be removed)
# and subtract buffer size to get actual available system space
post_free_system_size_kb=$((free_system_size_kb + current_gapps_size_kb - buffer_kb))
needed_system_size_kb=$((@space_needed@ / 1024))

ui_print "system space before gapps removal: $free_system_size_kb KB"
ui_print "system space after gapps removal minus buffer: $post_free_system_size_kb KB"
ui_print "system space required: $needed_system_size_kb KB"
ui_print "current gapps size: $current_gapps_size_kb KB"
if [ "$post_free_system_size_kb" -ge $needed_system_size_kb ]
then
    # CONTINUE TO INSTALL GAPPS
    ui_print "size check passed..."
else
    short_by_kb=$((needed_system_size_kb - post_free_system_size_kb))
    ui_print "you need to increase the size of your system partition"
    ui_print "by at least $short_by_kb KB for this package to fit."
    special_status 1
fi

# check to see if force_install has been triggered
if [ "$force_install" == 1 ]
then
    special_status 10
fi

echo "ro.gapps.install.status=$STATUS" > /tmp/build.prop
