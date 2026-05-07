# 多Agent配置的近期阶段-Claude接入规划（基于开发环境5.0）

> 用途：作为开发环境 5.0 下近期多 Agent 协作中 Claude 接入方式、付费口径、风险边界与后续推进顺序的参考文档。  
> 当前状态：阶段七已通过 Claude 网页版轻量只读 review 完成形式闭环，Claude Code 终端版与 Claude API / SDK 暂未正式接入。  
> 版本日期：2026-05-07

---

## 1. 总体结论

当前不建议直接进入 Hermes 调用 Claude API / SDK 的高度自动化阶段。

推荐路线是：

```text
先网页 review 留痕；
再本地 Claude Code 只读 review；
再让 Hermes 生成 review prompt 包；
再让 Hermes 调 claude -p；
最后才考虑 Claude API / SDK 自动化。
```

核心原则：

```text
先人工，再半自动，再全自动；
先只读，再建议，再修复；
先免费，再 Pro 月付，再 Max，最后 API；
先小上下文，再大上下文；
先报告留痕，再允许写代码。
```

---

## 2. 阶段划分总览

| 阶段 | 接入方式 | 付费方式 | 是否必须 API | 总体风险 | 当前建议 |
|---|---|---|---:|---|---|
| 阶段 1 | Claude 网页版手动 review | 免费版可用 | 否 | 最低 | 已完成 |
| 阶段 2 | Claude Code 本地只读 review | Claude Pro 月付即可 | 否 | 低-中 | 后续可选 |
| 阶段 3 | Hermes 生成 prompt 包，人工喂给 Claude | 免费版或 Pro 月付 | 否 | 低-中 | 推荐下一步建设 |
| 阶段 4 | Hermes 调 `claude -p` 非交互 review | Pro / Max 月付 | 否，优先不用 API | 中 | 中期再做 |
| 阶段 5 | Hermes 直接调用 Claude API / SDK | API 按量计费 | 是 | 高 | 后期再做 |
| 阶段 6 | Claude 参与复杂修复 | Pro / Max 或 API，取决于方式 | 不一定 | 高 | 仅复杂任务启用 |

---

## 3. 阶段 1：Claude 网页版手动 Review

### 定位

最低成本、最低风险，用于完成阶段七形式闭环。

### 付费方式

```text
免费版即可。
```

### 执行方式

```text
人工把任务卡、关键代码、测试、requirements、change-summary 作为附件或文本提供给 Claude 网页版。
Claude 只做只读 review。
Codex / Hermes 将 Claude 输出整理为 review 报告，写入 docs/collab/chatgpt-lingxi/reports/。
```

### 风险情况

| 风险类型 | 等级 | 说明 |
|---|---|---|
| 费用风险 | 低 | 不走 API，不会自动产生 token 账单 |
| 权限风险 | 低 | Claude 看不到整个 repo，也没有 shell / Git / 文件写入权限 |
| 流程风险 | 低 | 只要 review 结果保存进 reports/，Hermes 后续可引用 |

### 当前状态

```text
已完成。
```

当前产物：

```text
docs/collab/chatgpt-lingxi/reports/2026-05-07-claude-web-review-fastapi-health-demo.md
```

---

## 4. 阶段 2：Claude Code 本地只读 Review

### 定位

正式验证 Claude Code，但仍保持只读和人工监督。

### 付费方式

```text
Claude Pro 月付即可。
暂不建议一开始使用 Max。
暂不建议一开始使用 API key。
```

### 执行方式

```powershell
cd D:\dev\carrey-test-repo-1
claude
```

给 Claude Code 的基础指令：

```text
请只做 code review，不要修改文件。
请 review 当前任务相关改动。
请输出必须修改项、建议优化项、可以不改项、是否建议合并。
```

### 风险情况

| 风险类型 | 等级 | 说明 |
|---|---|---|
| 费用风险 | 低-中 | 月费固定，但可能因使用频率提升而升级 Max |
| 权限风险 | 中 | Claude Code 可以读取本地 repo，需要明确只读边界 |
| 流程风险 | 低-中 | 需要避免 Claude 与 Codex 职责混淆 |

### 控制方式

```text
只读 review。
不让 Claude Code 改文件。
不让 Claude Code commit / push。
不让 Claude Code 处理 .env / token / 私钥。
review 输出保存到 reports/。
Codex 仍是默认代码施工者。
```

---

## 5. 阶段 3：Hermes 生成 Claude Review Prompt 包

### 定位

提升自动化，但 Claude 仍由人工触发。

### 付费方式

```text
免费版可用。
如果 review 频率增加，Claude Pro 月付更合适。
```

### 执行方式

```text
Hermes 自动整理 review 材料。
Hermes 不直接调用 Claude。
人工把 prompt 包喂给 Claude 网页版或 Claude Code。
Claude 输出 review 后，再由 Codex 或 Hermes 写回 reports/。
```

Prompt 包建议包含：

```text
1. 任务卡摘要
2. 本次变更文件清单
3. 关键 diff 或关键文件内容
4. 测试输出
5. change-summary
6. review 要求
7. 输出格式要求
```

### 风险情况

| 风险类型 | 等级 | 说明 |
|---|---|---|
| 费用风险 | 低 | Hermes 不直接调用 Claude，不会自动产生 API 费用 |
| 权限风险 | 低 | Hermes 只生成文本材料，人工决定是否交给 Claude |
| 流程风险 | 中 | Prompt 包如果太大或不规范，会影响 review 质量 |

### 控制方式

```text
只打包任务卡、关键 diff、关键文件、测试输出、change-summary。
不打包整个 repo。
不打包 .env / token / 私钥。
设置 prompt 包模板。
设置文件数量和行数上限。
```

---

## 6. 阶段 4：Hermes 调 `claude -p` 非交互 Review

### 定位

半自动 review。Hermes 可以触发 Claude，但 Claude 仍然只读。

### 付费方式

```text
Claude Pro 月付优先。
高频使用再考虑 Max。
不建议默认使用 API key。
```

### 执行方式

```text
Hermes 在受控环境中调用 claude -p。
Claude Code 使用 Pro / Max 登录态。
禁用 ANTHROPIC_API_KEY。
限制 Claude Code 只读能力。
输出 review 文本。
Hermes 将结果写入 reports/。
```

示意命令：

```bash
claude -p "请只读 review 当前任务，不要修改文件。请输出必须修改项、建议优化项、是否建议合并。"
```

### 风险情况

| 风险类型 | 等级 | 说明 |
|---|---|---|
| 费用风险 | 中 | 若走 Pro / Max 登录态可控；误设 API key 可能变成 API 计费 |
| 权限风险 | 中-高 | Hermes 触发 Claude Code 后，需要控制 Claude 的读取和工具权限 |
| 流程风险 | 中 | 开始出现 Agent 调 Agent，需要日志和边界 |

### 控制方式

```text
禁用 ANTHROPIC_API_KEY。
确认走 Claude Code 登录态。
只允许 review。
限制为 Read / Grep / Glob 类能力。
不允许 Edit / Write / Bash / git push。
固定输出到 reports/。
每次调用先记录任务卡 ID。
保留调用日志。
```

---

## 7. 阶段 5：Hermes 直接调用 Claude API / SDK

### 定位

高度自动化、服务化，但费用和权限风险最高。

### 付费方式

```text
必须使用 API 按量计费。
不属于 Claude Pro 月付直接包住的使用方式。
```

### 执行方式

```text
Hermes 持有 Anthropic API key。
Hermes 直接调用 Claude API 或 SDK。
Hermes 将任务卡、diff、测试结果打包成请求。
Claude 返回 review 结果。
Hermes 写入 reports/。
```

### 风险情况

| 风险类型 | 等级 | 说明 |
|---|---|---|
| 费用风险 | 高 | 容易因大上下文、自动重试、批量调用导致 token 费用失控 |
| 权限风险 | 中-高 | Hermes 打包不当时可能泄露敏感内容 |
| 流程风险 | 中-高 | 需要预算、审计、失败处理、重试策略 |

### 成本控制要求

```text
单独 Anthropic workspace。
专用 API key。
低月度预算，例如 $5-$10 起步。
单次 token 上限。
每日调用次数上限。
Token Counting API 预估。
Usage / Cost API 监控。
超限自动停止。
```

输入控制：

```text
只发送任务卡、关键 diff、相关文件、测试输出、change-summary。
不发送整个 repo。
不发送完整 docs 历史。
不发送 .env、token、密钥、云配置。
大 diff 先摘要再 review。
超过阈值转人工确认。
```

建议阈值：

```text
单次输入超过 20k tokens：暂停，转人工确认。
单次输出 max_tokens：1200-2000。
单日自动 review：1-3 次起步。
月预算：先从 $5-$10 级别试点。
```

---

## 8. 阶段 6：Claude 参与复杂修复

### 定位

从只读 review 升级到复杂问题辅助，但不让 Claude 和 Codex 抢同一任务。

### 付费方式

```text
不固定。
如果本地 Claude Code 参与修复：Pro / Max 月付即可。
如果 Hermes 自动调用 Claude API 生成修复建议：需要 API。
如果 Claude 只是网页给建议：免费版或 Pro 都可以。
```

### 触发条件

```text
Codex 连续失败 2 轮。
测试错误原因复杂。
涉及 5 个以上文件。
diff 超过 300 行。
需要跨模块重构。
需要第二意见 code review。
```

### 风险情况

| 风险类型 | 等级 | 说明 |
|---|---|---|
| 费用风险 | 中-高 | 复杂修复通常上下文大、轮次多 |
| 权限风险 | 高 | 一旦允许 Claude 改文件，就进入高风险区 |
| 流程风险 | 高 | 多 Agent 同时改代码，容易冲突和责任不清 |

### 控制方式

```text
Codex 默认执行。
Claude 默认 review。
Claude 只有在明确授权时才参与修复。
一次只允许一个 Agent 改同一批文件。
Claude 直接改文件前必须有任务卡。
必须跑测试。
必须写 change-summary。
不得直接 push main。
```

---

## 9. 当前推荐推进顺序

```text
当前：阶段 1 已完成。
下一步：阶段 8 让 Hermes 汇总近期阶段结果。
后续可选：阶段 3，建设 Hermes 生成 Claude review prompt 包。
再后续：如需正式体验 Claude Code，开 Claude Pro 月付后执行阶段 2。
暂缓：阶段 4、阶段 5、阶段 6。
```

不建议当前立即执行：

```text
Hermes 直接调用 Claude API。
Claude 自动修改代码。
Claude 与 Codex 同时改同一批文件。
直接开 Max。
在没有预算和日志前使用 API key。
```

---

## 10. 一句话口径

```text
阶段 1 和阶段 3：免费版也能做；
阶段 2 和阶段 4：Claude Pro 月付优先；
阶段 5：必须 API；
阶段 6：看使用方式，优先 Pro / Max，不急着 API。
```
