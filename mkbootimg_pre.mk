LOCAL_PATH := $(call my-dir)

DTBTOOL := $(LOCAL_PATH)/mkbootimg_dtb
KERNEL := $(LOCAL_PATH)/kernel
DTB := $(LOCAL_PATH)/dt.img

INSTALLED_RECOVERYIMAGE_TARGET := $(PRODUCT_OUT)/recovery.img
INSTALLED_BOOTIMAGE_TARGET := $(PRODUCT_OUT)/boot.img

$(INSTALLED_BOOTIMAGE_TARGET): \
    $(MKBOOTIMG) \
    $(INTERNAL_BOOTIMAGE_FILES)
	@echo ----- Made boot image -------- $@
	$(hide) $(DTBTOOL) --kernel $(KERNEL) --ramdisk $(PRODUCT_OUT)/ramdisk.img --cmdline "$(BOARD_KERNEL_CMDLINE)" $(BOARD_MKBOOTIMG_ARGS_PRE) --dt $(DTB)  --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo ----- Added DTB ------------------ $@
	
$(INSTALLED_RECOVERYIMAGE_TARGET): \
    $(MKBOOTIMG) \
	$(recovery_ramdisk)
	@echo ----- Made recovery image -------- $@
	$(hide) $(DTBTOOL) --kernel $(KERNEL) --ramdisk $(PRODUCT_OUT)/ramdisk-recovery.img --cmdline "$(BOARD_KERNEL_CMDLINE)"  $(BOARD_MKBOOTIMG_ARGS_PRE) --dt $(DTB)  --output $@
	$(hide) $(call assert-max-image-size,$@, $(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo ----- Added DTB ------------------ $@

