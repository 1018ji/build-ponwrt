#!/bin/bash
#
# 删除 key 以 $1 开头的缓存，只保留最新的一份
# 每类缓存只留一份，避免超过仓库 10GB 上限后被自动淘汰
# 需要环境变量 GH_TOKEN 和 GH_REPO
#

set -eo pipefail

gh cache list --key "$1" --sort created_at --order desc --limit 100 --json id --jq '.[1:][].id' |
while read -r ID; do
  echo "deleting cache $ID"
  gh cache delete "$ID"
done
