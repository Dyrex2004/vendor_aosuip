# Copyright (C) 2019 Yodita
# Copyright (C) 2020 FluidOS
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

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Extra packages
PRODUCT_PACKAGES += \
    libjni_latinimegoogle

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Common overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/aosuip/overlay/common

# Lawnchair overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/aosuip/overlay/lawnchair

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/aosuip/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/aosuip/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/aosuip/prebuilt/common/bin/50-base.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-base.sh \
    vendor/aosuip/prebuilt/common/bin/blacklist:$(TARGET_COPY_OUT_SYSTEM)/addon.d/blacklist

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/aosuip/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/aosuip/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/aosuip/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Copy all aosuip specific init rc files
$(foreach f,$(wildcard vendor/aosuip/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Sysconfigs
PRODUCT_COPY_FILES += \
    vendor/aosuip/prebuilt/common/etc/sysconfig/aosuip-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/aosuip-power-whitelist.xml \
    vendor/aosuip/prebuilt/common/etc/sysconfig/dialer_experience.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/dialer_experience.xml \
    vendor/aosuip/prebuilt/common/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml

# Permissions
PRODUCT_COPY_FILES += \
    vendor/aosuip/prebuilt/common/etc/permissions/privapp-permissions-elgoog.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-elgoog.xml \
    vendor/aosuip/prebuilt/common/etc/permissions/privapp-permissions-lawnchair.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-lawnchair.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

PRODUCT_DEXPREOPT_SPEED_APPS += \
    Settings \
    SystemUI

# Packages
include vendor/aosuip/config/packages.mk

# Version
include vendor/aosuip/config/version.mk

# Bootanimation
include vendor/aosuip/config/bootanimation.mk

# Props
include vendor/aosuip/config/props.mk

# Telephony
include vendor/aosuip/config/telephony.mk

# Themes and overlays
include vendor/themes/themes.mk
