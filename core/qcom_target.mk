# Target-specific configuration

# Enable DirectTrack on QCOM legacy boards
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)

    TARGET_GLOBAL_CFLAGS += -DQCOM_HARDWARE
    TARGET_GLOBAL_CPPFLAGS += -DQCOM_HARDWARE

    ifeq ($(TARGET_USES_QCOM_BSP),true)
        TARGET_GLOBAL_CFLAGS += -DQCOM_BSP
        TARGET_GLOBAL_CPPFLAGS += -DQCOM_BSP
    endif

    # Enable DirectTrack for legacy targets
    ifneq ($(filter caf bfam,$(TARGET_QCOM_AUDIO_VARIANT)),)
        ifeq ($(BOARD_USES_LEGACY_ALSA_AUDIO),true)
            TARGET_GLOBAL_CFLAGS += -DQCOM_DIRECTTRACK
            TARGET_GLOBAL_CPPFLAGS += -DQCOM_DIRECTTRACK
        endif
    endif

# HACK: check to see if build uses standard QC HAL paths by checking for CM path structure
AOSP_VARIANT_MAKEFILE := $(wildcard hardware/qcom/audio/default/Android.mk)
ifeq ("$(AOSP_VARIANT_MAKEFILE)","")
$(call project-set-path,qcom-audio,hardware/qcom/audio)
$(call project-set-path,qcom-display,hardware/qcom/display)
$(call project-set-path,qcom-media,hardware/qcom/media)
$(call set-device-specific-path,CAMERA,camera,hardware/qcom/camera)
$(call set-device-specific-path,GPS,gps,hardware/qcom/gps)
$(call set-device-specific-path,SENSORS,sensors,hardware/qcom/sensors)
$(call set-device-specific-path,LOC_API,loc-api,vendor/qcom/opensource/location)
$(call set-device-specific-path,DATASERVICES,dataservices,vendor/qcom/opensource/dataservices)
$(call project-set-path,ril,hardware/ril)
$(call project-set-path,wlan,hardware/qcom/wlan)
$(call project-set-path,bt-vendor,hardware/qcom/bt)
else
$(call project-set-path,qcom-audio,hardware/qcom/audio-caf/$(QCOM_HARDWARE_VARIANT))

ifeq ($(SONY_BF64_KERNEL_VARIANT),true)
$(call project-set-path,qcom-display,hardware/qcom/display-caf/sony)
$(call project-set-path,qcom-media,hardware/qcom/media-caf/sony)
else
$(call project-set-path,qcom-display,hardware/qcom/display-caf/$(QCOM_HARDWARE_VARIANT))
$(call project-set-path,qcom-media,hardware/qcom/media-caf/$(QCOM_HARDWARE_VARIANT))
endif

$(call set-device-specific-path,CAMERA,camera,hardware/qcom/camera)
$(call set-device-specific-path,GPS,gps,hardware/qcom/gps)
$(call set-device-specific-path,SENSORS,sensors,hardware/qcom/sensors)
$(call set-device-specific-path,LOC_API,loc-api,vendor/qcom/opensource/location)
$(call set-device-specific-path,DATASERVICES,dataservices,vendor/qcom/opensource/dataservices)

$(call ril-set-path-variant,ril)
$(call wlan-set-path-variant,wlan-caf)
$(call bt-vendor-set-path-variant,bt-caf)
endif # AOSP_VARIANT_MAKEFILE

else

$(call project-set-path,qcom-audio,hardware/qcom/audio/default)
$(call project-set-path,qcom-display,hardware/qcom/display/$(TARGET_BOARD_PLATFORM))
$(call project-set-path,qcom-media,hardware/qcom/media/$(TARGET_BOARD_PLATFORM))

$(call project-set-path,qcom-camera,hardware/qcom/camera)
$(call project-set-path,qcom-gps,hardware/qcom/gps)
$(call project-set-path,qcom-sensors,hardware/qcom/sensors)
$(call project-set-path,qcom-loc-api,vendor/qcom/opensource/location)
$(call project-set-path,qcom-dataservices,$(TARGET_DEVICE_DIR)/dataservices)

$(call ril-set-path-variant,ril)
$(call wlan-set-path-variant,wlan)
$(call bt-vendor-set-path-variant,bt)

endif
