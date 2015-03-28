#!/bin/sh

set -e

echo "For Redmi Note 4G(dior) ONLY! "

mkdir -p bluetooth
#chown haoyangw.haoyangw bluetooth
mkdir -p configs
#chown haoyangw.haoyangw configs
mkdir -p keylayout
#chown haoyangw.haoyangw keylayout
mkdir -p rootdir/etc
#chown haoyangw.haoyangw rootdir
#chown haoyangw.haoyangw rootdir/etc
mkdir -p wifi
#chown haoyangw.haoyangw wifi

ETC=/system/etc
KEY=/system/usr/keylayout

# Copy device configs from device
echo "Let's wait for an Android device to be connected! "
adb wait-for-device

echo "Okay let's start! :) "
echo "Generating configs/ directory "
adb pull $ETC/audio_effects.conf configs
adb pull $ETC/audio_policy.conf configs
adb pull /system/lib/egl/egl.cfg configs
adb pull $ETC/gps.conf configs
adb pull $ETC/media_codecs.xml configs
adb pull $ETC/media_profiles.xml configs
adb pull $ETC/mixer_paths.xml configs
adb pull $ETC/sec_config configs
adb pull $ETC/thermal-engine-8226.conf configs

echo "Generating keylayout/ directory "
adb pull $KEY/ft5x06.kl keylayout
adb pull $KEY/gpio-keys.kl keylayout
adb pull $KEY/msm8226-tapan-snd-card_Button_Jack.kl keylayout

echo "Generating rootdir/Android.mk "
sudo bash -c 'cat << "EOF" > rootdir/Android.mk
LOCAL_PATH:= $(call my-dir)

# Configuration scripts

include $(CLEAR_VARS)
LOCAL_MODULE       := init.qcom.bt.sh
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.qcom.bt.sh
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.qcom.fm.sh
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.qcom.fm.sh
include $(BUILD_PREBUILT)

# Init scripts

include $(CLEAR_VARS)
LOCAL_MODULE       := chargeonlymode
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/chargeonlymode
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)/sbin
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := fstab.qcom
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/fstab.qcom
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.qcom.usb.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.qcom.usb.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.qcom.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.qcom.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := ueventd.qcom.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/ueventd.qcom.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)
EOF'

echo "Generating wifi/ directory "
wget -O wifi/WCNSS_cfg.dat https://github.com/Jackeagle/android_device_xiaomi_dior/blob/cm-11.0/wifi/WCNSS_cfg.dat?raw=true
wget -P wifi/ https://github.com/Jackeagle/android_device_xiaomi_dior/raw/cm-11.0/wifi/WCNSS_qcom_cfg.ini
wget -O wifi/WCNSS_qcom_wlan_nv_h3gbl.bin https://github.com/Jackeagle/android_device_xiaomi_dior/blob/cm-11.0/wifi/WCNSS_qcom_wlan_nv_h3gbl.bin?raw=true
wget -O wifi/WCNSS_qcom_wlan_nv_h3td.bin https://github.com/Jackeagle/android_device_xiaomi_dior/blob/cm-11.0/wifi/WCNSS_qcom_wlan_nv_h3td.bin?raw=true
wget -O wifi/WCNSS_qcom_wlan_nv_h3w.bin https://github.com/Jackeagle/android_device_xiaomi_dior/blob/cm-11.0/wifi/WCNSS_qcom_wlan_nv_h3w.bin?raw=true
adb pull $ETC/wifi/wpa_supplicant_overlay.conf wifi
adb pull $ETC/wifi/p2p_supplicant_overlay.conf wifi
adb pull $ETC/hostapd/hostapd.accept wifi
adb pull $ETC/hostapd/hostapd.deny wifi
adb pull $ETC/hostapd/hostapd_default.conf wifi
sudo bash -c 'cat << "EOF" > wifi/Android.mk
LOCAL_PATH:= $(call my-dir)

ifeq ($(strip $(BOARD_HAS_QCOM_WLAN)),true)

include $(CLEAR_VARS)
LOCAL_MODULE       := hostapd.accept
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/hostapd
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := hostapd.deny
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/hostapd
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := hostapd_default.conf
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/hostapd
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := wpa_supplicant_overlay.conf
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/wifi
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := p2p_supplicant_overlay.conf
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/wifi
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := WCNSS_cfg.dat
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/firmware/wlan/prima
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := WCNSS_qcom_cfg.ini
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/firmware/wlan/prima
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := WCNSS_qcom_wlan_nv_h3gbl.bin
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/firmware/wlan/prima
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := WCNSS_qcom_wlan_nv_h3td.bin
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/firmware/wlan/prima
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := WCNSS_qcom_wlan_nv_h3w.bin
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/firmware/wlan/prima
include $(BUILD_PREBUILT)

endif
EOF'

echo "Generating rootdir/ directory "
wget -O rootdir/etc/chargeonlymode https://github.com/Jackeagle/android_device_xiaomi_dior/blob/cm-11.0/rootdir/etc/chargeonlymode?raw=true
adb shell mkdir -p /sdcard/tmp/init
adb shell su -c cp /fstab.qcom /sdcard/tmp/init
adb shell su -c cp /init.class_main.sh /sdcard/tmp/init
adb shell su -c cp /init.mdm.sh /sdcard/tmp/init
adb shell su -c cp /init.qcom.class_core.sh /sdcard/tmp/init
adb shell su -c cp /init.qcom.early_boot.sh /sdcard/tmp/init
adb shell su -c cp /init.qcom.factory.sh /sdcard/tmp/init
adb shell su -c cp /init.qcom.rc /sdcard/tmp/init
adb shell su -c cp /init.qcom.sh /sdcard/tmp/init
adb shell su -c cp /init.qcom.ssr.sh /sdcard/tmp/init
adb shell su -c cp /init.qcom.syspart_fixup.sh /sdcard/tmp/init
adb shell su -c cp /init.qcom.usb.sh /sdcard/tmp/init
adb shell su -c cp /init.qcom.usb.rc /sdcard/tmp/init
adb shell su -c cp /init.target.rc /sdcard/tmp/init
adb shell su -c cp /ueventd.qcom.rc /sdcard/tmp/init
adb pull /sdcard/tmp/init ../dior/rootdir/etc/
adb pull $ETC/init.qcom.bt.sh rootdir/etc
adb pull $ETC/init.qcom.fm.sh rootdir/etc
adb shell rm -R /sdcard/tmp/init

echo "Generating bluetooth/ directory "
wget -O bluetooth/bdroid_buildcfg.h https://github.com/Jackeagle/android_device_xiaomi_dior/raw/cm-11.0/bluetooth/bdroid_buildcfg.h 

echo "Done pulling device configs! "
echo "Device tree should be done now! ;) Thanks for your hard work! "
