# Copyright (C) 2018 HardKernel Co., Ltd.
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
# This file is the build configuration for a full Android
# build for Meson reference board.
#

# Dynamic enable start/stop zygote_secondary in 64bits
# and 32bit system, default closed
#
ANDROID_BUILD_TYPE := 64
#TARGET_DYNAMIC_ZYGOTE_SECONDARY_ENABLE := true

# Inherit from those products. Most specific first.
ifeq ($(ANDROID_BUILD_TYPE), 64)
ifeq ($(TARGET_DYNAMIC_ZYGOTE_SECONDARY_ENABLE), true)
$(call inherit-product, device/hardkernel/common/dynamic_zygote_seondary/dynamic_zygote_64_bit.mk)
else
$(call inherit-product, build/target/product/core_64_bit.mk)
endif
endif

BOARD_INSTALL_VULKAN := true

$(call inherit-product, build/target/product/languages_full.mk)
$(call inherit-product, device/hardkernel/odroidn2/vendor_prop.mk)
$(call inherit-product, device/hardkernel/common/products/mbox/product_mbox.mk)
$(call inherit-product, device/hardkernel/odroidn2/device.mk)

# Media extension
TARGET_WITH_MEDIA_EXT_LEVEL := 4
TARGET_WITH_MEDIA_EXT :=true
TARGET_WITH_SWCODEC_EXT := true
TARGET_WITH_CODEC_EXT := true
TARGET_WITH_PLAYERS_EXT := true

PRODUCT_NAME := odroidn2
PRODUCT_DEVICE := odroidn2
PRODUCT_BRAND := ODROID
PRODUCT_MODEL := ODROID-N2
PRODUCT_MANUFACTURER := HardKernel Co., Ltd.

PRODUCT_TYPE := mbox

WITH_LIBPLAYER_MODULE := false

OTA_UP_PART_NUM_CHANGED := false

BOARD_AML_VENDOR_PATH := vendor/amlogic/common/

# dtsi
TARGET_PARTITION_DTSI := partition_mbox_ab.dtsi
TARGET_PARTITION_DTSI := partition_mbox_normal_P_64.dtsi
TARGET_FIRMWARE_DTSI := firmware_normal.dtsi

# WiFi
WIFI_MODULE := multiwifi
include device/hardkernel/common/wifi.mk
# Change this to match target country
# 11 North America; 14 Japan; 13 rest of world
PRODUCT_DEFAULT_WIFI_CHANNELS := 11

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
#BOARD_HAVE_BLUETOOTH_BCM := true
include device/hardkernel/common/bluetooth.mk

# Audio
BOARD_ALSA_AUDIO=tiny
include device/hardkernel/common/audio.mk

# DRM Widevine
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 3

$(call inherit-product, device/hardkernel/common/media.mk)

# LowMemoryKiller
BUILD_WITH_LOWMEM_COMMON_CONFIG := true

include device/hardkernel/common/software.mk

ifeq ($(TARGET_BUILD_GOOGLE_ATV),true)
DEVICE_MANIFEST_FILE := device/hardkernel/common/products/mbox/manifest/manifest_gtvs.xml
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=320
else
DEVICE_MANIFEST_FILE := device/hardkernel/common/products/mbox/manifest/manifest_aosp.xml
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=240
endif

# GPS
PRODUCT_PACKAGES += gps.$(PRODUCT_DEVICE)

# VU backlights
PRODUCT_PACKAGES += lights.$(PRODUCT_DEVICE)

# U-Boot Env Tools
PRODUCT_PACKAGES += \
    fw_printenv \
    fw_setenv

include device/hardkernel/common/gpu/gondul-user-arm64.mk

# Busybox
PRODUCT_PACKAGES += \
    static_busybox

# Updater
PRODUCT_PACKAGES += updater

PRODUCT_PACKAGES += \
     com.android.future.usb.accessory

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hdmi.device_type=4 \
    persist.sys.hdmi.keep_awake=false

PRODUCT_COPY_FILES += \
    device/hardkernel/odroidn2/fstab.system.odroidn2:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.odroidn2

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.external.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.external.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/files/hardkernel-720.bmp.gz:$(PRODUCT_OUT)/hardkernel-720.bmp.gz

