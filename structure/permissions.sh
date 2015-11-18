#!/sbin/sh

# Copyright (C) 2015 TKruzze and osmOsis, TK GApps
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Functions
set_perm_recursive() {
  dirs=$(echo "$@" | awk '{ print substr($0, index($0,$5)) }');
  for i in $dirs; do
    chown -R "$1.$2" "$i"; chown -R "$1:$2" "$i";
    find "$i" -type d -exec chmod "$3" {} +;
    find "$i" -type f -exec chmod "$4" {} +;
  done;
}

ch_con_recursive() {
  dirs=$(echo "$@" | awk '{ print substr($0, index($0,$1)) }');
  for i in $dirs; do
    find "$i" -exec LD_LIBRARY_PATH=/system/lib /system/lib64 /system/bin/toolbox chcon u:object_r:system_file:s0 {} +;
    find "$i" -exec chcon u:object_r:system_file:s0 {} +;
  done;
}

# Set permissions
set_perm_recursive 0 0 755 755 "/system/addon.d";
set_perm_recursive 0 0 755 644 "/system/app" "/system/etc/permissions" "/system/etc/preferred-apps" "/system/etc/sysconfig" "/system/framework" "/system/lib" "/system/lib64" "/system/priv-app" "/system/usr/srec" "/system/vendor/pittpatt";

# Change pittpatt folders to root:shell
find "/system/vendor/pittpatt" -type d -exec chown 0.2000 '{}' \; -exec chown 0:2000 '{}' \;

# Set selinux contexts
ch_con_recursive "/system/addon.d" "/system/app" "/system/etc/permissions" "/system/etc/preferred-apps" "/system/etc/sysconfig" "/system/framework" "/system/lib" "/system/lib64" "/system/priv-app" "/system/usr/srec" "/system/vendor/pittpatt";

exit 0
