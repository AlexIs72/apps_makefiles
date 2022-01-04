PWD ?= $(shell pwd)
SHELL = /bin/bash
SRC_DIR = $(PWD)/.src
OUT_DIR = $(PWD)/.out
BUILD_DIR = $(PWD)/.build
STAGE_DIR = $(PWD)/.stage
PATCHES_DIR = $(PWD)/patches
DL_DIR = $(PWD)/.dl
OWNER = $(shell echo ${USER})
ifneq (${SUDO_USER},)
OWNER = $(shell echo ${SUDO_USER})
endif
VERSION = $(shell cat .version)
ROOTFS_DIR = $(STAGE_DIR)/rootfs
ARCH=arm
ARM_HOST=arm-nuvoton-linux-uclibceabi
LORA_VERSION=1301

export SDK_PATH=/opt/nuvoton/arm_linux_4.8
#export LINUX_DEVKIT_PATH=$(TI_SDK_PATH)/linux-devkit
#export TI_SDK_ROOTFS=$(TI_SDK_PATH)/filesystem
export CROSS_COMPILE=$(SDK_PATH)/bin/arm-linux-
#export SYSROOT=$(LINUX_DEVKIT_PATH)/sysroots/armv7at2hf-neon-linux-gnueabi
export _CEF="-march=armv5te -mtune=arm926ej-s -mfloat-abi=soft -DUSE_EABI_SOFTFLOAT"
export PKG_CONFIG_LIBDIR=$(SDK_PATH)/usr/lib/pkgconfig
export CC=$(CROSS_COMPILE)gcc  --sysroot=$(SDK_PATH)
export CXX=$(CROSS_COMPILE)g++  --sysroot=$(SDK_PATH)
export LD=$(CROSS_COMPILE)ld  --sysroot=$(SDK_PATH)
export STRIP=$(CROSS_COMPILE)strip
#  --sysroot=$(SDK_PATH)
#export PATH:=$(SDK_PATH)/bin/:$(SDK_PATH)/arm-nuvoton-linux-uclibceabi/bin:$(SDK_PATH)/libexec/gcc/arm-nuvoton-linux-uclibceabi/4.8.4:${PATH}

#UBOOT_MACHINE=am335x_vega_$(PLATFORM)_defconfig
#UBOOT_NAME=u-boot-2019.01+gitAUTOINC+333c3e72d3-g333c3e72d3
#UBOOT_SRC_DIR=$(TI_SDK_PATH)/board-support/$(UBOOT_NAME)

#KERNEL_NAME=linux-4.19.94+gitAUTOINC+be5389fd85-gbe5389fd85
#KERNEL_SRC_DIR=$(PWD)/src/linux-3.12.10-ti2013.12.01
#KERNEL_SRC_DIR=$(TI_SDK_PATH)/board-support/$(KERNEL_NAME)

NUM_CORES = $(shell getconf _NPROCESSORS_ONLN)
MAKE_JOBS = $(shell echo $$(( $(NUM_CORES) * 2 )))
#export CC=$(CROSS_COMPILE)gcc
# --sysroot=$(SDK_PATH)" 
#export LD=$(CROSS_COMPILE)ld
# --sysroot=$(SDK_PATH)"
LOCAL_MAKE = $(MAKE) -j$(MAKE_JOBS) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)
