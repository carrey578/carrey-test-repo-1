# 《OpenClaw 原地切 Hermes 2.0——cutover 执行日志》

## 0. 文档状态

- 执行日期：`2026-05-02`
- 记录时间：`2026-05-02 15:33`
- 记录人：`人工 + Codex`
- 参考文档：`2026.04.26-OpenClaw-原地切-Hermes-操作指南2.0（基于环境4.6版）`
- 当前实例类型：
  - [ ] `Lighthouse（轻量应用服务器）`
  - [x] `CVM（云服务器）`
- 当前阶段状态：
  - [ ] 尚未开始
  - [ ] 执行中
  - [ ] 暂停
  - [x] 已完成

---

## 1. 计划动作

按 runbook 计划，本轮原定动作如下：

- [x] 确认实例类型
- [x] Codex 创建 / 更新 171 与 172 文档
- [ ] 灵犀重新执行本轮切换前盘点与导出
- [x] 人工下载 `openclaw-cutover`
- [x] 人工制作快照 / 自定义镜像
- [x] 人工执行重装系统 / 切换镜像
- [x] Codex 登录系统并安装 / 检查 Hermes
- [x] Codex 执行 `hermes claw migrate --dry-run`
- [x] 人工确认正式 `migrate`
- [x] Codex 执行正式 `migrate`
- [x] Codex 执行三层 smoke test
- [x] Codex / 人工完成平台侧主运行位验证
- [x] Codex 执行本地 4.6 收尾验收

---

## 2. 实际动作

本轮实际已执行动作：

- [x] 确认当前实例为 `Tencent Cloud CVM`，公网 IP 为 `43.134.165.90`
- [x] 在仓库中创建 `171-openclaw-hermes-cutover-runbook.md` 与本日志文件
- [x] 人工在腾讯云控制台完成重装相关操作，并保留了重装前系统盘快照
- [x] 因重装后新系统缺少 `/root/.openclaw`，人工又将当前实例直接回滚到重装前快照
- [x] 回滚后确认旧数据恢复：`/root/.openclaw` 与 `/home/ubuntu/migration/openclaw-cutover/backup`
- [x] 将 `openclaw-cutover` 关键材料重新下载到本地：
  - `D:\dev\_xfer_lingxi\download\openclaw-cutover-20260430\openclaw-cutover\`
- [x] 执行 `hermes claw migrate --dry-run`
- [x] 停用 root user-level `openclaw-gateway.service`，清理 OpenClaw 运行冲突
- [x] 执行正式 `hermes claw migrate --preset full --yes`
- [x] 完成三层 smoke test
- [x] 将 Hermes 主模型切换到 `tencentcodingplan + minimax-m2.5`
- [x] 启动 `hermes gateway run --replace`
- [x] 通过 Telegram DM 验证 Hermes 已成为实际主入口
- [x] 执行本地 4.6 收尾验收：
  - `git status`
  - `tools/dev-entry.ps1`
  - `tools/verify-dev-entry.ps1`

---

## 3. 未执行动作

本轮明确未执行动作：

- [x] 未重新让灵犀执行一轮“新鲜导出”；本轮依赖的是快照回滚后恢复出的旧导出产物
- [x] 未保留“重装后新系统 + Hermes v0.11.0”作为最终运行态；该状态已被快照回滚覆盖
- [x] 未安装长期 `hermes-gateway.service` systemd 服务；本轮按文档要求采用前台命令后台化运行

---

## 4. 偏差原因

| 偏差项 | 原计划 | 实际情况 | 原因 | 是否影响结论 |
| --- | --- | --- | --- | --- |
| 切换前导出 | 由灵犀按本轮流程重新导出 | 未重新执行，改为使用快照回滚后恢复的旧导出目录 | 阶段 8 卡在新系统缺少 `/root/.openclaw`，只能先救回旧数据源 | 是 |
| 系统基线 | 重装到新系统后继续推进 | 当前实例后续被回滚到重装前快照 | 为恢复旧 OpenClaw 源数据与 `backup/` 目录 | 是 |
| 云上备份校验 | `sha256sum.txt` 与大包完全匹配 | `openclaw-home.tar.gz` 与旧 `sha256sum.txt` 中对应项不一致，但云上/本地同包一致且可正常解压 | 大包已发生版本漂移，旧摘要记录过期 | 否 |
| 运行级 provider | 原先尝试走 OpenRouter | 最终改为 `tencentcodingplan + minimax-m2.5` | OpenRouter key 已生效，但 credits 不足；腾讯云 Coding Plan 可直接打通 | 否 |

---

## 5. 切换前前置条件检查

### 5.1 实例与入口信息

- 当前实例类型：`CVM`
- 当前实例名称：`VM-0-5-ubuntu`
- 当前公网 IP：`43.134.165.90`
- 当前登录方式：`ubuntu@IP + sudo -i`

### 5.2 Go / No-Go 门禁

- [x] 已确认实例类型
- [x] 本地 `openclaw-cutover` 已下载到本地
- [x] 重装前系统盘快照已可用
- [x] 旧 OpenClaw 数据已重新取回
- [x] 已记录公网 IP、登录方式、回滚路径

门禁结论：

- [x] `Go`
- [ ] `No-Go`
- 备注：`虽然中途发生过回滚，但最终已恢复出可用迁移源，且本地备份已补齐。`

---

## 6. 切换前导出与备份结果

### 6.1 灵犀执行结果

- 是否重新执行本轮导出：`否`
- 实际导出来源：`通过重装前快照回滚，恢复旧系统中的 openclaw-cutover 产物`
- 恢复后的产物清单：
  - `inventory/`：`已存在`
  - `backup/`：`已存在`
  - `sha256sum.txt`：`已存在`

### 6.2 本地下载结果

- 是否已下载到本地：`是`
- 本地目录：`D:\dev\_xfer_lingxi\download\openclaw-cutover-20260430\openclaw-cutover\`
- 本地校验结果：
  - `xfer.tar.gz`：与 `sha256sum.txt` 一致
  - `repo-working.diff`：空文件，一致
  - `openclaw-home.tar.gz`：与当前云机同包一致，且 `gzip -t` / `tar -tzf` 通过
  - 备注：旧 `sha256sum.txt` 中 `openclaw-home.tar.gz` 对应条目已过期，不再反映当前大包摘要

### 6.3 快照 / 自定义镜像结果

- 是否执行：`是`
- 类型：`CVM 系统盘快照`
- 名称：`重装前系统盘快照（控制台可见）`
- 状态：`可用`

---

## 7. 腾讯云控制台执行结果

### 7.1 重装路线

- 是否进入重装页面：`是`
- 实际执行路径：
  - [x] `Ubuntu 24.04 重装`
  - [ ] `Hermes 镜像直接作为最终状态`
- 是否保留了回滚能力：`是，后续实际使用了重装前快照回滚当前实例`

### 7.2 控制台关键结果

- 曾完成一次重装后的新系统启动
- 后续为恢复旧 OpenClaw 数据，人工在当前实例上直接执行了重装前快照回滚
- 最终当前实例处于：`回滚后的旧系统状态 + 已完成 Hermes 迁移与接管`

---

## 8. Hermes 安装与迁移结果

### 8.1 登录与系统信息

- SSH / 控制台登录是否成功：`是`
- 登录用户：`ubuntu -> root`
- 系统版本：`Ubuntu 24.04 LTS`
- 内核版本：`Linux 6.8.0-71-generic`
- `df -h` 摘要：`/dev/vda2 59G，总可用约 4.5G（删除云上大备份后）`
- 是否存在额外数据盘：`否`

### 8.2 Hermes 安装结果

- 是否已可用：`是`
- `hermes --version`：`Hermes Agent v0.10.0 (2026.4.16)`
- `hermes doctor`：`通过（有非致命警告）`
- 是否存在致命错误：`否`

### 8.3 dry-run 结果

- 是否执行 `hermes claw migrate --dry-run`：`是`
- dry-run 摘要：
  - `Source: /root/.openclaw`
  - `Target: /root/.hermes`
  - `6 would migrate`
  - `18 conflicts`
  - `25 skipped`
- 是否识别到 `/root/.openclaw`：`是`
- 是否建议正式 `migrate`：`是，但必须先停掉 OpenClaw 运行冲突`

### 8.4 正式 migrate 结果

- 是否执行正式 `migrate`：`是`
- 迁移摘要：
  - 与 dry-run 一致，实际完成迁移 6 项
  - 冲突项 18 项跳过
  - 跳过项 25 项
  - 迁移目录生成：`/root/.hermes/migration/openclaw/20260502T110634`
- `~/.hermes` 是否生成并合理：`是`
- 是否需要补充 `setup` / key / OAuth：`是，后续补了 provider key，并切换到 tencentcodingplan + minimax-m2.5`

---

## 9. 三层 smoke test 结果

### 9.1 安装级

- [x] `hermes --version` 正常
- [x] `hermes doctor` 无致命错误
- 结果：`通过`

### 9.2 交互级

- [x] 可进入 Hermes CLI
- [x] `/help` 正常
- 结果：`通过`

### 9.3 运行级

- [x] 完成一轮真实模型对话
- [x] 返回可读回答
- 结果：`通过`
- 说明：
  - 初始阻塞依次经历了：`无 provider` -> `磁盘满` -> `OpenRouter credits 不足`
  - 最终切换到 `tencentcodingplan + minimax-m2.5`
  - 实测命令 `hermes chat -Q -q 'Reply with exactly: ok'` 返回 `ok`

---

## 10. 平台侧主运行位验证

### 10.1 当前活跃服务

- 当前平台显示：
  - [ ] `OpenClaw 运行中`
  - [x] `Hermes 运行中`
  - [ ] `Hermes 已安装但未运行`
  - [ ] `未验证`

### 10.2 运行位判定

- OpenClaw 是否仍在运行：`否`
- OpenClaw 是否仍占用消息通道：`否`
- Hermes 是否已成为主入口：`是`
- 是否完成平台侧验证：`是`

### 10.3 当前真实结论

- 当前真实结论：`Hermes 正式接管`

补充证据：

- `hermes gateway run --replace` 已启动并保持运行
- Telegram `getMe` 返回 `200`
- Telegram 私聊实际回复正常
- 机器人在 Telegram 中报告当前模型为 `minimax-m2.5`

---

## 11. 本轮状态判断

### 11.1 是否只是迁移准备完成

- [ ] 是
- [x] 否
- 说明：`正式 migrate 已执行，且后续 smoke test 与平台侧验证已完成。`

### 11.2 是否达到 Hermes 最小可用

- [x] 是
- [ ] 否
- 说明：`安装级、交互级、运行级 smoke test 均已通过。`

### 11.3 是否达到 Hermes 正式接管

- [x] 是
- [ ] 否
- 说明：`OpenClaw 已退出主运行位，Hermes gateway 已实际连接 Telegram 并完成真实消息回复。`

### 11.4 是否仍需回滚

- [ ] 是
- [x] 否
- 说明：`当前实例已具备稳定的 Hermes 主入口与可用 provider，未触发回滚条件。`

---

## 12. OpenClaw 停用标准检查

- OpenClaw 主进程是否已停止：`是`
- OpenClaw gateway 是否仍占用通道：`否`
- OpenClaw 是否仍作为对外消息入口：`否`
- 是否存在残留浏览器 / 僵尸进程：`否`
- 残留进程是否影响“正式接管”判断：`否`

---

## 13. 回滚判断

### 13.1 是否触发回滚条件

- [ ] 新系统无法稳定 SSH
- [ ] Hermes 安装失败且短时间内无法修复
- [ ] dry-run 无法识别 OpenClaw 数据
- [ ] 正式 `migrate` 后 Hermes 无法启动
- [ ] Hermes 未接管而 OpenClaw 也失效
- [ ] 人工判断恢复成本过高

### 13.2 回滚路线

- [ ] `Lighthouse 自定义镜像恢复`
- [x] `CVM 快照 / 镜像恢复`
- [ ] `保留新系统，只恢复功能`
- [x] `暂不回滚`

备注：`本轮中途实际使用过 CVM 重装前快照回滚来恢复旧数据源；当前最终状态不再需要继续回滚。`

---

## 14. 本地 4.6 收尾验收

- `git status`：`仅 171 / 172 两个文档文件为未跟踪状态`
- `tools/dev-entry.ps1`：`执行成功，输出开发任务统一入口帮助与命令索引`
- `tools/verify-dev-entry.ps1`：`执行成功，5/5 通过`
- 其它本地验收：`当前未发现本地 4.6 基线异常`

---

## 15. 最终结论

一句话结论：

`本轮已完成正式接管，当前主入口为 Hermes。`

补充说明：

- 当前实例不是“重装后新系统 + Hermes v0.11.0”那条路线的最终态，而是“回滚后的旧系统 + 完成迁移 + 完成接管”的最终态
- 但按 2.0 文档的最终判断标准，这不影响结论：
  - `Hermes 最小可用`：已达到
  - `Hermes 正式接管`：已达到
  - `OpenClaw 原地切 Hermes 切换完成`：可以成立

---

## 16. 后续控制台动作补充（应用模板切换后）

### 16.1 额外动作

- 在上述结论形成后，人工又执行了额外控制台动作：
  - 为当前云机制作快照 / 镜像留存
  - 在腾讯云控制台直接选择并运行 `使用应用模板 - Hermes Agent`

### 16.2 运行态变化

- 当前实例运行态因此发生切换：
  - 系统回到 `Ubuntu 24.04.4 LTS / kernel 6.8.0-101-generic`
  - `/root/.openclaw` 不再存在
  - 当前活跃 Hermes 不再运行于 `root`，而是运行于 `ubuntu` 用户环境
  - 当前可执行文件位于 `/home/ubuntu/.local/bin/hermes`
  - 当前 gateway 为 `ubuntu` 用户级 `systemd --user` 服务：`hermes-gateway.service`

### 16.3 平台侧验证结果（应用模板环境）

- 平台侧主运行位已重新验证：
  - 飞书新应用 `灵犀-Hermes-Tencent` 可正常收发消息
  - 对话中可收到 Hermes 自我介绍与状态回复
  - 首条 `No home channel is set for Feishu` 仅为提示，不构成故障
  - 如需将该会话设为默认回传通道，可在飞书中发送 `/sethome`

- 当前 gateway 连接形态：
  - `hermes-gateway.service` 处于 `active (running)`
  - 日志可见已成功连接 Feishu / Lark websocket
  - 运行级命令探针 `hermes chat -Q -q 'Reply with exactly: ok'` 返回 `ok`
  - 人工在飞书中执行 `/sethome` 后已收到成功反馈，当前对话已设为该平台的 home channel

### 16.4 结论更新

- 旧的 `root + Telegram` 接管态应视为**历史阶段性状态**
- 当前现网主入口应更新为：
  - `ubuntu 用户下的 Hermes 应用模板运行态`
  - `平台侧主入口：飞书 / Lark`

- 因此，最新真实结论为：
  - `Hermes 最小可用`：已达到
  - `Hermes 正式接管`：已达到
  - `当前主入口`：`Hermes（应用模板环境，Feishu/Lark 已验证）`

### 16.5 Key 清理收口

- 已完成云机侧旧 key 留痕清理：
  - 删除 `/home/ubuntu/.hermes/config.yaml.bak-*`
  - 删除 `/home/ubuntu/.hermes/.env.bak-*`
  - 删除 `/root/.hermes/config.yaml.bak-*`
  - 删除 `/root/.hermes/.env.bak-*`
  - 清理 `root` 与 `ubuntu` 的 `.bash_history`

- 复核结果：
  - 备份残留查询为空，未再发现 `config.yaml.bak-*` / `.env.bak-*` / `*.backup*`
  - `hermes-gateway.service` 仍为 `active`
  - 运行级命令探针 `hermes chat -Q -q 'Reply with exactly: ok'` 继续返回 `ok`

- 判断：
  - 旧 key 备份文件已清理完成
  - 清理动作未影响当前 Hermes 的飞书主入口与运行状态
