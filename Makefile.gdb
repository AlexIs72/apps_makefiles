include env.mk

#SRC = https://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.gz
#https://download.samba.org/pub/ppp/ppp-2.4.9.tar.gz



TARGET_NAME = gdb
TARGET_VERSION = 10.2
TARGET_FULL_NAME = $(TARGET_NAME)-$(TARGET_VERSION)
TARGET_ARCH_NAME = $(TARGET_FULL_NAME).tar.gz
TARGET_ARCH = $(DL_DIR)/$(TARGET_ARCH_NAME)
SRC_URI = https://ftp.gnu.org/gnu/$(TARGET_NAME)/$(TARGET_ARCH_NAME)

TARGET_DIR = $(BUILD_DIR)/$(TARGET_FULL_NAME)
INSTALL_DIR ?= $(TARGET_DIR)/.install
BUILD_OPTS = PREFIX=$(INSTALL_DIR) 
TARGETS = $(TARGET_DIR)/src/stdbuf

all: $(TARGETS)
	make -j $(MAKE_JOBS) -C $(TARGET_DIR) $(BUILD_OPTS) install

$(TARGETS): $(TARGET_DIR) $(TARGET_DIR)/Makefile
	make -C $(TARGET_DIR) $(BUILD_OPTS)

$(TARGET_BIN): $(TARGET_DIR) $(TARGET_DIR)/Makefile
#	LDFLAGS=-L$(INSTALL_DIR)/lib \
#	make -j $(MAKE_JOBS) -C $(TARGET_DIR) $(BUILD_OPTS)
    
$(TARGET_DIR)/Makefile:
	cd $(TARGET_DIR) && \
	CC_FOR_TARGET=$(CROSS_COMPILE)gcc \
	./configure \
	    ${CONFIGURE_FLAGS} \
        --prefix=$(INSTALL_DIR) \

#	CC=$(CROSS_COMPILE)gcc \
#	    ${CONFIGURE_FLAGS} \
#	    --target=arm-linux-gnueabi \

#	CC=$(CROSS_COMPILE)gcc \
#        --with-libtool-sysroot=/opt/ti-processor-sdk-linux-am335x-evm-06.03.00.106/linux-devkit/sysroots/armv7at2hf-neon-linux-gnueabi \

#	CC=$(CROSS_COMPILE)gcc \
#	AR=$(CROSS_COMPILE)ar \
#        --target=arm-linux \
#        --host=$(ARM_HOST) \
#        --build=i686-pc-linux-gnu \
#	    ${CONFIGURE_FLAGS} \

#        --target=$(ARM_HOST) \
#        --host=$(ARM_HOST) \
#        --build=i686-pc-linux-gnu \
 
#        --cross_compile=$(CROSS_COMPILE) \
#        --cc=gcc \
#        --cflags=-I$(INSTALL_DIR)/include    \
#        --disable-plugins \
#        --disable-debug

$(TARGET_DIR): $(TARGET_ARCH)
	tar -C $(BUILD_DIR) -xmvf $(TARGET_ARCH)

$(TARGET_ARCH):
	wget $(SRC_URI) -O $@
	touch $@


