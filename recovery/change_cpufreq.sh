#!/sbin/sh

HARDWARE=`cat /proc/cpuinfo | grep Hardware`

if [[ $HARDWARE == *"N2Plus"* ]]; then
    sed -i s/_big=\"1800\"/_big=\"2208\"/g /sdcard/env.ini;
    sed -i s/_little=\"1896\"/_little=\"1908\"/g /sdcard/env.ini;
fi
