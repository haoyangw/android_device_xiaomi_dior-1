$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
# $(call inherit-product, device/common/gps/gps_us_supl.mk)

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Proprietary files
$(call inherit-product, vendor/xiaomi/dior/dior-vendor.mk)

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

LOCAL_PATH := device/xiaomi/dior
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio_policy.msm8226 \
    audio.primary.msm8226 \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    libqcomvisualizer \
    tinymix

PRODUCT_PACKAGES += \
    libaudioamp

# Audio configuration
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/audio/audio_effects.conf:system/vendor/etc/audio_effects.conf \
$(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf \
$(LOCAL_PATH)/audio/mixer_paths0.xml:system/etc/mixer_paths0.xml \
$(LOCAL_PATH)/audio/mixer_paths1.xml:system/etc/mixer_paths1.xml \
$(LOCAL_PATH)/audio/mixer_paths2.xml:system/etc/mixer_paths2.xml

# Camera
PRODUCT_PACKAGES += \
    camera.msm8226

# Keystore
PRODUCT_PACKAGES += \
    keystore.msm8226

# Lights
PRODUCT_PACKAGES += \
    lights.msm8226

# GPS
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/configs/gps.conf:system/etc/gps.conf

# IRSC
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/configs/sec_config:system/etc/sec_config

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

PRODUCT_PACKAGES += \
	e2fsck

# FM radio
PRODUCT_PACKAGES += \
     qcom.fmradio \
     libqcomfm_jni \
     FM2 \
     FMRecord

# Display
PRODUCT_PACKAGES += \
    libgenlock \
    liboverlay \
    libtilerenderer \
    hwcomposer.msm8226 \
    gralloc.msm8226 \
    copybit.msm8226 \
    memtrack.msm8226

# Keylayouts
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/keylayout/ft5x06.kl:system/usr/keylayout/ft5x06.kl \
$(LOCAL_PATH)/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
$(LOCAL_PATH)/keylayout/msm8226-tapan-snd-card_Button_Jack.kl:system/usr/keylayout/msm8226-tapan-snd-card_Button_Jack.kl

# Media
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
$(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml

# libxml2 is needed for camera
PRODUCT_PACKAGES += libxml2

# Power
PRODUCT_PACKAGES += \
    power.msm8226

# QCOM rngd
PRODUCT_PACKAGES += \
    qrngd \
    qrngp

# USB
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Wifi firmware
PRODUCT_PACKAGES += \
	libwcnss_qmi \
    wcnss_service

# Permissions
PRODUCT_COPY_FILES += \
frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

# Qualcomm
PRODUCT_PROPERTY_OVERRIDES += \
persist.timed.enable=true \
qcom.hw.aac.encoder=true \
#ro.qualcomm.cabl=0 \
ro.vendor.extension_library=/vendor/lib/libqc-opt.so \
wifi.interface=wlan0 \
PRODUCT_TAGS += dalvik.gc.type-precise

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp

# Xiaomi Confs
PRODUCT_PROPERTY_OVERRIDES += \
	ro.com.google.clientidbase=android-xiaomi \
	ro.com.google.clientidbase.ms=android-xiaomi \
	ro.com.google.clientidbase.am=android-xiaomi \
	ro.com.google.clientidbase.gmm=android-xiaomi \
	ro.com.google.clientidbase.yt=android-xiaomi

PRODUCT_PROPERTY_OVERRIDES += \
    mm.enable.smoothstreaming=true

# Ramdisk
#PRODUCT_PACKAGES += \
#init.qcom.bt.sh \
#init.qcom.fm.sh

#PRODUCT_PACKAGES += \
#chargeonlymode \
#init.recovery.qcom.rc \
#fstab.qcom \
#init.qcom.rc \
#init.qcom.usb.rc \
#ueventd.qcom.rc

# Ramdisk
PRODUCT_PACKAGES += \
chargeonlymode \
init.qcom.class_core.sh \
init.qcom.syspart_fixup.sh \
fstab.qcom \
init.qcom.early_boot.sh \
init.qcom.usb.rc \
init.qcom.factory.sh \
init.qcom.usb.sh \
init.qcom.fm.sh \
init.qcom.wifi.sh \
init.class_main.sh \
init.qcom.post_boot.sh \
init.recovery.qcom.rc \
init.mdm.sh \
init.qcom.rc \
init.target.rc \
init.qcom.audio_conf.sh \
init.qcom.sh \
ueventd.qcom.rc \
init.qcom.bt.sh \
init.qcom.ssr.sh

# Recovery
PRODUCT_PROPERTY_OVERRIDES += \
ro.cwm.enable_key_repeat=true \
ro.cwm.forbid_mount=/persist,/firmware \
ro.cwm.forbid_format=/fsg,/firmware,/boot,/persist

# Thermal
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/configs/thermal-engine-8226.conf:system/etc/thermal-engine-8226.conf

# Wifi
PRODUCT_PACKAGES += \
hostapd.accept \
hostapd.deny \
hostapd_default.conf \
#p2p_supplicant_overlay.conf \
#wpa_supplicant_overlay.conf \
WCNSS_cfg.dat \
WCNSS_qcom_cfg.ini \
WCNSS_qcom_wlan_nv.bin

# WPA Supplicant
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/p2p_supplicant_overlay.conf:/system/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/configs/wpa_supplicant_overlay.conf:/system/etc/wifi/wpa_supplicant_overlay.conf

