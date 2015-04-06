LOCAL_PATH:= $(call my-dir)

ifeq ($(strip $(BOARD_HAS_QCOM_WLAN)),true)

include $(CLEAR_VARS)
LOCAL_MODULE       := WCNSS_qcom_wlan_nv_h3w.bin
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/firmware/wlan/prima
include $(BUILD_PREBUILT)

# Make a symlink for WiFi firmware
SYMLINKS := $(TARGET_OUT_ETC)/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin
$(SYMLINKS): WIFI_FW := WCNSS_qcom_wlan_nv_h3w.bin
$(SYMLINKS): $(LOCAL_INSTALLED_MODULE) $(LOCAL_PATH)/Android.mk
	@echo "Symlink: $@ -> $(WIFI_FW)"
	$(hide) ln -sf $(WIFI_FW) $@

ALL_DEFAULT_INSTALLED_MODULES += $(SYMLINKS)

# We need this so that the installed files could be picked up based on the
# local module name
ALL_MODULES.$(LOCAL_MODULE).INSTALLED := \
    $(ALL_MODULES.$(LOCAL_MODULE).INSTALLED) $(SYMLINKS)

endif
