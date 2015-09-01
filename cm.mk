## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := dior

# Inherit some common CM stuff.
# $(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
# $(call inherit-product, device/xiaomi/dior/device_dior.mk)
$(call inherit-product, device/xiaomi/dior/full_dior.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := dior
PRODUCT_NAME := cm_dior
PRODUCT_BRAND := xiaomi
PRODUCT_MODEL := dior
PRODUCT_MANUFACTURER := xiaomi

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

# Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=HM_NOTE_1LTE \
    TARGET_DEVICE=dior \
    BUILD_FINGERPRINT=Xiaomi/dior/dior:4.4.4/KTU84Q/KHICNBF6.0:userdebug/release-keys \
    PRIVATE_BUILD_DESC="cm_dior-user 4.4.4 KTU84Q KHICNBF6.0 release-keys"
