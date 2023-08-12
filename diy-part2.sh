#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

########### 修改默认IP ###########
sed -i 's/192.168.1.1/192.168.100.10/g' package/base-files/files/bin/config_generate

########### 设置空密码及版本标识 ###########
ZZZ="package/lean/default-settings/files/zzz-default-settings"
sed -i '/CYXluq4wUazHjmCDBCqXF/d' $ZZZ
sed -i "s/OpenWrt /w.z $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" $ZZZ

########### 更改源码版本 ###########
# sed -i "s/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=6.1/g" target/linux/x86/Makefile

########### 安装msd_lite ###########
rm -rf feeds/packages/net/msd_lite
git clone https://github.com/ximiTech/msd_lite.git feeds/packages/net/msd_lite
# rm -rf feeds/luci/applications/luci-app-msd_lite
# git clone https://github.com/ximiTech/luci-app-msd_lite.git feeds/luci/applications/luci-app-msd_lite
#在.config文件中 48XX行的 # CONFIG_PACKAGE_luci-app-mosdns is not set下面新建一行：CONFIG_PACKAGE_luci-app-msd_lite=y
#修改.config文件中 63XX行的 # CONFIG_PACKAGE_mstpd is not set上面一行为： CONFIG_PACKAGE_msd_lite=y

########### 更改默认主题（可选）###########
# 删除自定义源默认的 argon 主题
# rm -rf package/lean/luci-theme-argon
# 拉取 argon 原作者的源码
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
# make menuconfig菜单中勾选LuCI ---> Applications ---> luci-app-argon-config
