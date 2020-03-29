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
FLUID_CODENAME = Quenol
FLUID_NUM_VERSION = ZeroTwo

TARGET_PRODUCT_SHORT := $(subst FluidOS_,,$(FLUID_BUILD_TYPE))

ifndef FLUID_BUILD_TYPE
    FLUID_BUILD_TYPE := UNOFFICIAL # UNLIQUEFIED soon
endif

# Only include Updater for official, weeklies, and nightly builds
ifeq ($(filter-out OFFICIAL WEEKLIES NIGHTLY,$(FLUID_BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        Updater
endif

# Sign builds if building an official, weekly and nightly build
ifeq ($(filter-out OFFICIAL WEEKLIES NIGHTLY,$(FLUID_BUILD_TYPE)),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(KEYS_LOCATION)
endif

# Set all versions
BUILD_DATE := $(shell date -u +%Y%m%d)
BUILD_TIME := $(shell date -u +%H%M)
FLUID_BUILD_VERSION := $(FLUID_NUM_VERSION)-$(FLUID_CODENAME)
FLUID_DISPLAY_VERSION := $(FLUID_BUILD_VERSION)-$(FLUID_BUILD_TYPE)-$(FLUID_BUILD)-$(BUILD_DATE)
ROM_FINGERPRINT := Fluid/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(BUILD_TIME)
FLUID_VERSION := $(FLUID_DISPLAY_VERSION)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.fluid.build.version=$(FLUID_BUILD_VERSION) \
  ro.fluid.build.date=$(BUILD_DATE) \
  ro.fluid.buildtype=$(FLUID_BUILD_TYPE) \
  ro.fluid.fingerprint=$(ROM_FINGERPRINT) \
  ro.fluid.version=$(FLUID_VERSION) \
  ro.fluid.device=$(FLUID_BUILD) \
  ro.modversion=$(FLUID_VERSION)
