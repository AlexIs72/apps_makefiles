include env.mk

INSTALL_DIR ?= $(PWD)/.install

TARGET_NAME = jq
TARGET_VERSION = 1.6
TARGET_FULL_NAME = $(TARGET_NAME)-$(TARGET_VERSION)
TARGET_ARCH_NAME = $(TARGET_FULL_NAME).tar.gz
TARGET_ARCH = $(DL_DIR)/$(TARGET_ARCH_NAME)
SRC_URI = https://github.com/stedolan/jq/releases/download/$(TARGET_FULL_NAME)/$(TARGET_ARCH_NAME)
#https://matt.ucc.asn.au/dropbear/$(TARGET_ARCH_NAME)

TARGET_DIR = $(BUILD_DIR)/$(TARGET_FULL_NAME)
TARGET_BIN = $(TARGET_DIR)/$(TARGET_NAME)
TARGET = $(INSTALL_DIR)/bin/$(TARGET_NAME)
#LZO_DIR=$(BUILD_DIR)/lzo-2.10/.install
#OPENSSL_DIR=$(BUILD_DIR)/openssl-1.1.1j/.install


$(TARGET): $(TARGET_DIR) $(TARGET_BIN) 
	$(LOCAL_MAKE) -C $(TARGET_DIR) install

$(TARGET_BIN): $(TARGET_DIR)/Makefile
	$(LOCAL_MAKE) -C $(TARGET_DIR) 
    
$(TARGET_DIR)/Makefile:
	cd $(TARGET_DIR) && \
	./configure \
        --target=$(ARM_HOST) \
        --host=$(ARM_HOST) \
        --build=i686-pc-linux-gnu \
        --prefix=$(INSTALL_DIR) \
        --disable-maintainer-mode \
        --enable-shared=no \
        --without-oniguruma 


#    CC=$(CROSS_COMPILE)gcc \

#    CC=$(CROSS_COMPILE)gcc \


$(TARGET_DIR): $(TARGET_ARCH)
	tar -C $(BUILD_DIR) -xmvf $(TARGET_ARCH)

$(TARGET_ARCH): 
	wget $(SRC_URI) -O $@


