# Copyright (C) 2016 http://www.brobwind.com
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

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := tests
LOCAL_PACKAGE_NAME := BroNativeV1

ifneq ($(ONE_SHOT_MAKEFILE),)
TARGET_BUILD_APPS := $(LOCAL_PACKAGE_NAME)
endif

LOCAL_JNI_SHARED_LIBRARIES := \
	libnative-jni
LOCAL_DIST_BUNDLED_BINARIES := true

# Only compile source java files in this apk.
LOCAL_SRC_FILES := \
	$(call all-java-files-under, src) \

LOCAL_ASSET_DIR := \
	$(LOCAL_PATH)/assets

define my-add-executable
my_libs_$(2) := assets/bin/armeabi-v7a/$(2)

$$(LOCAL_PATH)/$$(my_libs_$(2)): $$(call intermediates-dir-for,EXECUTABLES,$(2))/$(2)
	$$(copy-file-to-target)

$$(call intermediates-dir-for,SHARED_LIBRARIES,$(1))/LINKED/$(1).so: $$(LOCAL_PATH)/$$(my_libs_$(2))
endef

$(eval $(call my-add-executable,libnative-jni,logwrapper))
$(eval $(call my-add-executable,libnative-jni,hello-native))

include $(BUILD_PACKAGE)

include $(call all-makefiles-under,$(LOCAL_PATH))
