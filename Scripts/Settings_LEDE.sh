#!/bin/bash

#修改immortalwrt.lan关联IP
sed -i "s/192\.168\.[0-9]*\.[0-9]*/$WRT_IP/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
#添加编译日期标识
sed -i "s/(\(luciversion || ''\))/(\1) + (' \/ $WRT_CI-$WRT_DATE')/g" $(find ./feeds/luci/modules/luci-mod-status/ -type f -name "10_system.js")
#调整位置
sed -i 's/services/system/g' $(find ./feeds/luci/applications/luci-app-ttyd/ -type f -name "luci-app-ttyd.json")
sed -i '3 a\\t\t"order": 10,' $(find ./feeds/luci/applications/luci-app-ttyd/ -type f -name "luci-app-ttyd.json")
sed -i 's/services/nas/g' $(find ./feeds/luci/applications/luci-app-alist/ -type f -name "luci-app-alist.json")
sed -i 's/services/nas/g' $(find ./feeds/luci/applications/luci-app-samba4/ -type f -name "luci-app-samba4.json")
sed -i 's/services/network/g' $(find ./feeds/luci/applications/luci-app-upnp/ -type f -name "luci-app-upnp.json")

#修改默认IP地址
sed -i "s/192\.168\.[0-9]*\.[0-9]*/$WRT_IP/g" ./package/base-files/files/bin/config_generate
#修改默认主机名
sed -i "s/hostname='\(.*\)'/hostname='$WRT_NAME'/g" ./package/base-files/files/bin/config_generate
