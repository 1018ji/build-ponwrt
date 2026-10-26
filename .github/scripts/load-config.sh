#!/bin/bash
#
# 载入机型配置：复制配置文件、执行 diy-part2.sh、按缓存模式开启 ccache，再展开为完整配置
# 用法：在 openwrt 目录下执行 load-config.sh <配置文件>
#

set -e

cp "$GITHUB_WORKSPACE/$1" .config
chmod +x "$GITHUB_WORKSPACE/$DIY_P2_SH"
"$GITHUB_WORKSPACE/$DIY_P2_SH"
if [ "$CACHE_MODE" != "不使用缓存" ]; then
  sed -i '/^CONFIG_DEVEL=/d; /^# CONFIG_DEVEL is not set$/d; /^CONFIG_CCACHE=/d; /^# CONFIG_CCACHE is not set$/d' .config
  printf 'CONFIG_DEVEL=y\nCONFIG_CCACHE=y\n' >> .config
fi
make defconfig
