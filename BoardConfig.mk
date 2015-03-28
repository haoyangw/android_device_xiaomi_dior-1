USE_CAMERA_STUB := true

# inherit from the proprietary version
-include vendor/xiaomi/dior/AndroidBoardVendor.mk

TARGET_OTA_ASSERT_DEVICE := dior

BOARD_VENDOR := xiaomi

# Bootloader
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := dior

# Platform
TARGET_BOARD_PLATFORM := msm8226
TARGET_BOARD_PLATFORM_GPU := qcom-adreno305

# Arch
TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_SMP := true

ARCH_ARM_HAVE_TLS_REGISTER := true


# Kernel
#TARGET_KERNEL_CONFIG := msm8226-perf_defconfig
TARGET_KERNEL_CONFIG := dior_debug_defconfig
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 earlyprintk androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_SEPARATED_DT := true
BOARD_MKBOOTIMG_ARGS := --dt device/xiaomi/dior/dt.img --kernel_offset 0x00008000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100
BOARD_CUSTOM_BOOTIMG_MK := device/xiaomi/dior/mkbootimg_pre.mk
TARGET_KERNEL_SOURCE := kernel/xiaomi/dior
TARGET_PREBUILT_KERNEL := device/xiaomi/dior/kernel
BOARD_KERNEL_SEPERATED_DT := true

# fix this up by examining /proc/mtd on a running device
# BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00380000
# BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00480000
# BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0x08c60000
# BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x105c0000


# Partitions
BOARD_RECOVERY_BLDRMSG_OFFSET := 2048
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216 #16M
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216 #16M 
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 838860800 #800M
BOARD_USERDATAIMAGE_PARTITION_SIZE := 6241112064 #6G
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_FLASH_BLOCK_SIZE := 131072


# QCOM HW
BOARD_USES_QCOM_HARDWARE 	:= true
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
TARGET_QCOM_AUDIO_VARIANT := caf
TARGET_QCOM_DISPLAY_VARIANT := caf-new
TARGET_QCOM_MEDIA_VARIANT := caf-new
# TARGET_USES_QCOM_BSP := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/xiaomi/dior/bluetooth

# Camera
COMMON_GLOBAL_CFLAGS += -DPROPERTY_PERMS_APPEND='{"xiaomi.camera.sensor.", AID_CAMERA, 0}, {"camera.4k2k.", AID_MEDIA, 0}, {"persist.camera.", AID_MEDIA, 0},'
USE_DEVICE_SPECIFIC_CAMERA := true

# Graphics
TARGET_USES_ION := true
TARGET_USES_C2D_COMPOSITION := true
USE_OPENGL_RENDERER := true
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
BOARD_EGL_CFG := device/xiaomi/dior/configs/egl.cfg

# Backlight
TARGET_PROVIDES_LIBLIGHT := true

# PowerHAL
TARGET_POWERHAL_VARIANT := qcom

# RIL
BOARD_PROVIDES_LIBRIL := true

# QC Time
BOARD_USES_QC_TIME_SERVICES := true
COMMON_GLOBAL_CFLAGS += -DQCOM_HARDWARE
# COMMON_GLOBAL_CFLAGS += -DQCOM_BSP
BOARD_HAS_NO_SELECT_BUTTON := true

# Wifi
BOARD_HAS_QCOM_WLAN := true
BOARD_WLAN_DEVICE := qcwcn
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
TARGET_USES_WCNSS_CTRL := true
WIFI_DRIVER_FW_PATH_STA := "sta"
WIFI_DRIVER_FW_PATH_AP := "ap"

# SELinux
BOARD_SEPOLICY_DIRS += \
    device/xiaomi/dior/sepolicy

BOARD_SEPOLICY_UNION += \
    app.te \
    bluetooth.te \
    device.te \
    domain.te \
    drmserver.te \
    file_contexts \
    file.te \
    hci_init.te \
    healthd.te \
    init_shell.te \
    init.te \
    keystore.te \
    kickstart.te \
    mediaserver.te \
    rild.te \
    surfaceflinger.te \
    system.te \
    ueventd.te \
    wpa_socket.te \
    wpa.te

# Vendor Init
# TARGET_UNIFIED_DEVICE := true

# Webkit
ENABLE_WEBGL := true
TARGET_FORCE_CPU_UPLOAD := true

# Recovery
TARGET_RECOVERY_FSTAB := device/xiaomi/dior/rootdir/etc/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_SUPPRESS_EMMC_WIPE := true
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_RECOVERY_SWIPE := true
RECOVERY_FSTAB_VERSION = 2
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_15x24.h\"
#BOARD_TOUCH_RECOVERY := true
BOARD_RECOVERY_SWIPE := true
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720
