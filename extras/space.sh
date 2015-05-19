#!/sbin/sh

# vars
g_prop=/system/etc/g.prop
current_gapps_size=0
buffer=100000000
# FAILED for use in edify (1=not enough space, 2=non-slim gapps installed)
FAILED=0

# functions
abort() {
    FAILED=${1}
}

# get file descriptor for output
OUTFD=$(ps | grep -v grep | grep -oE "update-binary(.*)" | cut -d " " -f 3)

# same as ui_print command in updater_script, for example:
#
# ui_print "hello world!"
#
# will output "hello world!" to recovery, while
#
# ui_print
#
# outputs an empty line

ui_print() {
  if [ "$OUTFD" != "" ]; then
    echo "ui_print ${1} " 1>&$OUTFD;
    echo "ui_print " 1>&$OUTFD;
  else
    echo "${1}";
  fi;
}

file_getprop() {
    grep "^$2" "$1" | cut -d= -f2
}

if [ -e /system/priv-app/GoogleServicesFramework/GoogleServicesFramework.apk -a -e /system/priv-app/GoogleLoginService/GoogleLoginService.apk ]
then
    # gapps are installed
    if [ -e /system/etc/g.prop -a -n "$(grep slim $g_prop)" -a -n "$(grep ro.addon.size $g_prop)" ]
    then
        # and it is a recent slim gapps package
        ui_print "  found existing slim gapps package"
        current_gapps_size=$(file_getprop $g_prop ro.addon.size)
    else
        abort 2
    fi
fi

# Read and save system partition size details
#df=$(busybox df /system | tail -n 1)
df=$(df /system | tail -n 1)
case $df in
    /dev/block/*) df=$(echo $df | awk '{ print substr($0, index($0,$2)) }');;
esac
# NEED TO MULTIPLY BY 1000 BECAUSE THIS VALUE IS IN 1K BLOCKS
free_system_size_kb=$(echo $df | awk '{ print $3 }')
free_system_size=$(($free_system_size_kb \* 1000))

# add currently installed gapps size (since they will be removed)
# and subtract buffer size to get actual available system space
post_free_system_size=$(($free_system_size + $current_gapps_size - $buffer))
needed_system_size=@space_needed@

ui_print "system space before gapps removal: $free_system_size"
ui_print "system space after gapps removal: $post_free_system_size"
ui_print "system space required: $needed_system_size"
ui_print "current gapps size: $current_gapps_size"
if [ "$post_free_system_size" -ge $needed_system_size ]
then
    # CONTINUE TO INSTALL GAPPS
    ui_print "gapps installation will now proceed..."
else
    abort 1
fi

echo "ro.gapps.install.failed=$FAILED" > /tmp/build.prop
