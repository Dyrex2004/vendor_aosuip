# Copyright (C) 2016-2017 AOSiP
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

# Versioning System
AOSUIP_NUM_VERSION = 3.0

TARGET_PRODUCT_SHORT := $(subst AOSuiP_,,$(AOSUIP_BUILD_TYPE))

ifndef AOSUIP_BUILD_TYPE
    AOSUIP_BUILD_TYPE := UNOFFICIAL
endif

# Only include Updater for official, weeklies, and nightly builds
ifeq ($(filter-out OFFICIAL WEEKLIES NIGHTLY,$(AOSUIP_BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        Updater
endif

# Sign builds if building an official, weekly and nightly build
ifeq ($(filter-out OFFICIAL WEEKLIES NIGHTLY,$(AOSUIP_BUILD_TYPE)),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(KEYS_LOCATION)
endif

# Set all versions
BUILD_DATE := $(shell date -u +%Y%m%d)
BUILD_TIME := $(shell date -u +%H%M)
AOSUIP_BUILD_VERSION := v$(AOSUIP_NUM_VERSION)
AOSUIP_DISPLAY_VERSION := $(AOSUIP_BUILD_VERSION)-$(AOSUIP_BUILD)-$(BUILD_DATE)-$(AOSUIP_BUILD_TYPE)
ROM_FINGERPRINT := aosuip/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(BUILD_TIME)
AOSUIP_VERSION := $(AOSUIP_DISPLAY_VERSION)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.aosuip.build.version=$(AOSUIP_BUILD_VERSION) \
  ro.aosuip.build.date=$(BUILD_DATE) \
  ro.aosuip.buildtype=$(AOSUIP_BUILD_TYPE) \
  ro.aosuip.fingerprint=$(ROM_FINGERPRINT) \
  ro.aosuip.version=$(AOSUIP_VERSION) \
  ro.aosuip.device=$(AOSUIP_BUILD) \
  ro.modversion=$(AOSUIP_VERSION)
