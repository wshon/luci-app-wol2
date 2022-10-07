#
# Copyright (C) 2022 wshon <code@wshon.com>
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Support for Wake-on-LAN2
LUCI_DEPENDS:=+etherwake
LUCI_PKGARCH:=all
PKG_VERSION:=1.0
PKG_RELEASE:=20221007
PKG_MAINTAINER:=wshon

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
