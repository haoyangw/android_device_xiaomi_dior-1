## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := dior

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/xiaomi/dior/device_dior.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := dior
PRODUCT_NAME := cm_dior
PRODUCT_BRAND := xiaomi
PRODUCT_MODEL := dior
PRODUCT_MANUFACTURER := xiaomi
