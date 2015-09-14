#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

USE_CAMERA_STUB := true

BOARD_VENDOR := xiaomi

# Default toolchain
TARGET_GCC_VERSION_EXP := 4.8

# External apps on SD
TARGET_EXTERNAL_APPS = sdcard1

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8226
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Platform
QCOM_BOARD_PLATFORMS  := msm8226
TARGET_BOARD_PLATFORM := msm8226
TARGET_BOARD_PLATFORM_GPU := qcom-adreno305

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_MEMCPY_BASE_OPT_DISABLE := true
TARGET_CPU_VARIANT := krait

# Kernel
TARGET_PREBUILT_KERNEL := device/xiaomi/dior/kernel
TARGET_KERNEL_SOURCE := kernel/xiaomi/dior
ifeq ("$(wildcard $(TARGET_KERNEL_SOURCE))","")
ifneq ("$(wildcard $(TARGET_PREBUILT_KERNEL))","")
$(shell mkdir -p $(OUT)/obj)
$(shell mkdir -p $(OUT)/obj/KERNEL_OBJ)
$(shell mkdir -p $(OUT)/obj/KERNEL_OBJ/usr)
endif
endif
TARGET_KERNEL_CONFIG := cyanogenmod_dior_defconfig
#TARGET_KERNEL_CONFIG := cm_dior_defconfig
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=dior user_debug=31 msm_rtb.filter=0x37
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_SEPARATED_DT := true
BOARD_CUSTOM_BOOTIMG_MK := device/xiaomi/dior/mkbootimg.mk
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x02000000 --tags_offset 0x01e00000

# Includes
TARGET_SPECIFIC_HEADER_PATH := device/xiaomi/dior/include

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "qualcomm-smd"

# Audio
BOARD_USES_ALSA_AUDIO := true
AUDIO_FEATURE_ENABLED_FM := true
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
BOARD_OMXCODEC_FFMPEG := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/xiaomi/dior/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true

# Camera
USE_DEVICE_SPECIFIC_CAMERA := true

# Charger
BOARD_CHARGER_SHOW_PERCENTAGE := true

# Filesystem
BOARD_RECOVERY_BLDRMSG_OFFSET		:= 2048
BOARD_BOOTIMAGE_PARTITION_SIZE		:= 16777216 #16M
BOARD_RECOVERYIMAGE_PARTITION_SIZE	:= 17418240
#BOARD_RECOVERYIMAGE_PARTITION_SIZE	:= 16777216 #16M 
BOARD_SYSTEMIMAGE_PARTITION_SIZE	:= 838860800 #800M
BOARD_USERDATAIMAGE_PARTITION_SIZE	:= 6241112064 # - 16384 for crypto footer
TARGET_USERIMAGES_USE_EXT4		:= true
BOARD_FLASH_BLOCK_SIZE			:= 131072

# FM
BOARD_HAVE_QCOM_FM := true
QCOM_FM_ENABLED := true

# GPS
TARGET_GPS_HAL_PATH := device/xiaomi/dior/gps
TARGET_PROVIDES_GPS_LOC_API := true

# No old RPC for prop
TARGET_NO_RPC := true

# Graphics
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true
USE_OPENGL_RENDERER := true
HAVE_ADRENO_SOURCE:= false
TARGET_USES_POST_PROCESSING := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so

# Shader cache config options
# Maximum size of the GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

# Hardware tunables
BOARD_HARDWARE_CLASS := device/xiaomi/dior/cmhw/

# Vendor Init
TARGET_UNIFIED_DEVICE := true
TARGET_INIT_VENDOR_LIB := libinit_dior
TARGET_LIBINIT_DEFINES_FILE := device/xiaomi/dior/init/init_dior.c

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Power
TARGET_POWERHAL_VARIANT := qcom

# Flags
COMMON_GLOBAL_CFLAGS += -DQCOM_HARDWARE -DQCOM_BSP
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD
COMMON_GLOBAL_CFLAGS += -D__ARM_USE_PLD -D__ARM_CACHE_LINE_SIZE=64

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true
#TARGET_USES_QCOM_BSP := true
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

# Recovery
TARGET_RECOVERY_FSTAB := device/xiaomi/dior/rootdir/etc/fstab.dior
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
RECOVERY_FSTAB_VERSION       := 2

# SELinux
include device/qcom/sepolicy/sepolicy.mk

BOARD_SEPOLICY_DIRS += device/xiaomi/dior/sepolicy

# The list below is order dependent
BOARD_SEPOLICY_UNION += \
       file.te \
       mediaserver.te \
       mpdecision.te \
       rmt_storage.te \
       shell.te \
       system_app.te \
       system_server.te \
       thermal-engine.te \
       vold.te \
       zygote.te
       
# Vold
BOARD_VOLD_DISC_HAS_MULTIPLE_MAJORS := true
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun0/file

# Wifi
BOARD_HAS_QCOM_WLAN := true
BOARD_WLAN_DEVICE := qcwcn
BOARD_NO_WIFI_HAL := true
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
WIFI_DRIVER_FW_PATH_AP := "ap"
WIFI_DRIVER_FW_PATH_STA := "sta"
WPA_SUPPLICANT_VERSION := VER_0_8_X
TARGET_USES_WCNSS_CTRL := true
TARGET_USES_QCOM_WCNSS_QMI := true

# inherit from the proprietary version
-include vendor/xiaomi/dior/BoardConfigVendor.mk
