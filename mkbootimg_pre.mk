LOCAL_PATH := $(call my-dir)

ifneq ($(BUILD_WITH_COLORS),0)
  CL_RED="\033[31m"
  CL_GRN="\033[32m"
  CL_YLW="\033[33m"
  CL_BLU="\033[34m"
  CL_MAG="\033[35m"
  CL_CYN="\033[36m"
  CL_RST="\033[0m"
endif

DTBTOOL := $(LOCAL_PATH)/mkbootimg_dtb
KERNEL := $(LOCAL_PATH)/kernel
DTB := $(LOCAL_PATH)/dt.img

#$(shell cp -f $(LOCAL_PATH)/dt.img $(PRODUCT_OUT)/dt.img)

INSTALLED_RECOVERYIMAGE_TARGET := $(PRODUCT_OUT)/recovery.img
INSTALLED_BOOTIMAGE_TARGET := $(PRODUCT_OUT)/boot.img

$(INSTALLED_BOOTIMAGE_TARGET): \
    $(MKBOOTIMG) \
    $(INTERNAL_BOOTIMAGE_FILES)
	@echo -e ${CL_CYN}"----- Made boot image -------- $@"${CL_RST}
	$(hide) $(DTBTOOL) --kernel $(KERNEL) --ramdisk $(PRODUCT_OUT)/ramdisk.img --cmdline "$(BOARD_KERNEL_CMDLINE)" $(BOARD_MKBOOTIMG_ARGS_PRE) --dt $(DTB)  --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_GRN}"----- Added DTB ------------------ $@"${CL_RST}
	
$(INSTALLED_RECOVERYIMAGE_TARGET): \
    $(MKBOOTIMG) \
	$(recovery_ramdisk)
	@echo -e ${CL_CYN}"----- Made recovery image -------- $@"${CL_RST}
	$(hide) $(DTBTOOL) --kernel $(KERNEL) --ramdisk $(PRODUCT_OUT)/ramdisk-recovery.img --cmdline "$(BOARD_KERNEL_CMDLINE)"  $(BOARD_MKBOOTIMG_ARGS_PRE) --dt $(DTB)  --output $@
	$(hide) $(call assert-max-image-size,$@, $(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_GRN}"----- Added DTB ------------------ $@"${CL_RST}

