#!/bin/bash

FILE="$1"
test "$FILE" || exit 255
VXIDIR=/home/src/vxi11
TMPFILE=/tmp/dump.$$.bmp
SIGLENTIP=10.11.13.220
MYIP=10.11.13.17/24

ETH=`dmesg | egrep 'asix.*eth' | tail -1 | awk '{print $4}' | awk -F: '{print $1}'`

ping -c1 "$SIGLENTIP" || sudo ifconfig $ETH "$MYIP"

LD_LIBRARY_PATH=$VXIDIR/library $VXIDIR/utils/vxi11_scdp "$SIGLENTIP" "$TMPFILE"
convert "$TMPFILE" "$FILE"
rm "$TMPFILE"
