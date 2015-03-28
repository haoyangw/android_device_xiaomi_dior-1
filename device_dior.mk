$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
# $(call inherit-product, device/common/gps/gps_us_supl.mk)

<<<<<<< HEAD
# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Proprietary files
$(call inherit-product, vendor/xiaomi/dior/dior-vendor.mk)

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

=======
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Proprietary files
$(call inherit-product, vendor/xiaomi/dior/dior-vendor.mk)

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

>>>>>>> dba863d27465b97a4b47812ec9c7e045aea22c42
LOCAL_PATH := device/xiaomi/dior
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Audio configuration
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/configs/audio_effects.conf:system/vendor/etc/audio_effects.conf \
$(LOCAL_PATH)/configs/audio_policy.conf:system/etc/audio_policy.conf \
$(LOCAL_PATH)/configs/mixer_paths.xml:system/etc/mixer_paths.xml

# GPS
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/configs/gps.conf:system/etc/gps.conf

# IRSC
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/configs/sec_config:system/etc/sec_config

# Keylayouts
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/keylayout/ft5x06.kl:system/usr/keylayout/ft5x06.kl \
$(LOCAL_PATH)/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
$(LOCAL_PATH)/keylayout/msm8226-tapan-snd-card_Button_Jack.kl:system/usr/keylayout/msm8226-tapan-snd-card_Button_Jack.kl

# Media
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
$(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml

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
ro.qualcomm.cabl=0 \
ro.vendor.extension_library=/vendor/lib/libqc-opt.so

# Ramdisk
PRODUCT_PACKAGES += \
init.qcom.bt.sh \
init.qcom.fm.sh

PRODUCT_PACKAGES += \
chargeonlymode \
<<<<<<< HEAD
init.recovery.qcom.rc \
=======
>>>>>>> dba863d27465b97a4b47812ec9c7e045aea22c42
fstab.qcom \
init.qcom.rc \
init.qcom.usb.rc \
ueventd.qcom.rc

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
p2p_supplicant_overlay.conf \
wpa_supplicant_overlay.conf \
WCNSS_cfg.dat \
WCNSS_qcom_cfg.ini \
WCNSS_qcom_wlan_nv.bin
