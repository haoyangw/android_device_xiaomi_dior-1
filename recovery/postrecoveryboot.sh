#!/sbin/sh
echo 100  > /sys/class/leds/lcd-backlight/brightness
echo 0 > /sys/devices/platform/msm_hsusb/gadget/lun0/ro
