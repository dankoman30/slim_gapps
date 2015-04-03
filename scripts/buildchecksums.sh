#!/bin/bash
if [ $# -ne 1 ] ; then
        echo "Usage $0 [directory]" 
        exit 1
fi
find $1 -type f  -print0 | while IFS= read -r -d $'\0' file; do
    (
    cd "$(dirname "$file")"
    filename="$(basename "$file")"
    filesize="size: $(stat -c%s "$filename") bytes"
    filemd5="md5: $(md5sum "$filename")"
    filesha1="sha1: $(sha1sum "$filename")"
    echo "$filename" > "$filename".checksum
    echo "$filesize" >> "$filename".checksum
    echo "$filemd5" >> "$filename".checksum
    echo "$filesha1" >> "$filename".checksum
    )
done
