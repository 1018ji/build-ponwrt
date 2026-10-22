# build-ponwrt

使用 GitHub Actions 编译 PonWrt 固件，目标平台为 Airoha **AN7581** 和 **AN7583**。

> [!IMPORTANT]
> 本仓库编译的源码是 **[1018ji/ponwrt](https://github.com/1018ji/ponwrt)**（`master` 分支），
> **不是**原版 [pbs05/ponwrt](https://github.com/pbs05/ponwrt)。
> `1018ji/ponwrt` 是 `pbs05/ponwrt` 的下游仓库，供本人向原版提交 PR 使用。

> [!TIP]
> 如果你 fork 本仓库，记得把 `release.yml` 和 `dev.yml` 中的 `REPO_URL` 改为原版仓库
> `https://github.com/pbs05/ponwrt`（或你自己的源码仓库），并确认 `REPO_BRANCH` 分支名正确。

## Workflow

| Workflow | 触发方式 | 产物 | 保留 |
| --- | --- | --- | --- |
| **RELEASE Builder**（`release.yml`） | 每天北京时间 05:00 自动运行，也可手动触发 | Release `RELEASE-YYYY-MM-DD` | 最近 7 个 |
| **DEV Builder**（`dev.yml`） | 仅手动触发，可选开启 SSH 调试 | Artifact `DEV-YYYY-MM-DD-<机型>` | 3 天 |

两个 workflow 都会在两台 runner 上并行编译 AN7581 和 AN7583，一个机型失败不影响另一个。每个 workflow 的 Actions 运行记录仅保留最新 7 条（含日志，删除后不可恢复）。

### RELEASE

- 编译前检查 `1018ji/ponwrt` 的最新 commit，与上一个 Release 相同则跳过，不重复发布。
- Release 说明中记录本次编译所用的 `1018ji/ponwrt` commit。
- tag 为秒级时间戳（如 `2026-10-21-10-23-05`），由 workflow 自动创建。

### DEV

- 在 Actions 页面选择 `DEV Builder` → `Run workflow`，勾选 `ssh` 可在编译前进入 SSH 调试。
- 编译完成后在本次运行页面底部下载 Artifact（zip 格式，解压后为固件）。

## 固件

每个机型只发布以下两类文件，位于源码的 `bin/targets/airoha/<机型>/`：

- `*initramfs-recovery.itb`
- `*squashfs-sysupgrade.itb`

## 自定义

- `an7581.config` / `an7583.config`：各机型的编译配置
- `diy-part1.sh`：更新 feeds 前执行，可修改 feeds 源
- `diy-part2.sh`：安装 feeds 后执行，可修改默认配置

## Credits

- [1018ji/ponwrt](https://github.com/1018ji/ponwrt)
- [pbs05/ponwrt](https://github.com/pbs05/ponwrt)
- [P3TERX/Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt)
- [OpenWrt](https://github.com/openwrt/openwrt)

## License

[MIT](LICENSE)
