# 133-external-model-session-log

## 外部模型任务会话记录模板

> **重要**：每次使用外部模型完成后，必须填写此记录。记录是追溯和预算统计的基础。

---

## 必填项

| 字段 | 说明 | 示例 |
|------|------|------|
| 本次任务名 | 任务的简要名称 | Claude 最小接入只读试运行 |
| 使用的外部模型 | 具体用了哪个模型 | Claude 3.5 Sonnet |
| 使用原因 | 为什么需要外部模型 | 默认 Coding Plan 模型不适合做长上下文读仓 |
| 开始时间 | 任务开始时间（ISO 格式） | 2026-04-01T14:00:00+08:00 |
| 结束时间 | 任务结束时间（ISO 格式） | 2026-04-01T14:30:00+08:00 |
| 是否已恢复默认 Coding Plan 路由 | 必须填"是" | 是 |
| 是否仍有待继续的后续任务 | 是否有下一轮 | 否 |

---

## 填写示例

```
## 2026-04-01 示例记录

- 本次任务名：Claude 最小接入只读试运行
- 使用的外部模型：Claude 3.5 Sonnet
- 使用原因：需要对当前仓做一次深度只读分析，默认 Coding Plan 模型不适合做这轮长上下文读仓
- 开始时间：2026-04-01T14:00:00+08:00
- 结束时间：2026-04-01T14:30:00+08:00
- 是否已恢复默认 Coding Plan 路由：是
- 是否仍有待继续的后续任务：否
- 备注：完成了最小只读报告，无代码改动
```

---

## 核心规则

### 1. 完成后即停用外部模型
- 任务一旦完成，立即停用外部模型
- 不得在任务结束后继续使用外部模型
- 不得将外部模型设为默认路由

### 2. 必须恢复默认 Coding Plan 路由
- 任务完成后必须执行恢复脚本：`sudo bash /root/workspace/config/model-routing/restore-default-route.sh`
- 验证恢复结果：
  - `active-provider.env` 应指向 Coding Plan
  - `external-model-approval.status` 应为 `APPROVED=0`

### 3. 必须记录本次外部模型使用情况
- 每次使用外部模型后，必须在此文件记录
- 记录内容包括：任务名、模型、使用原因、时间、是否已恢复
- 这是后续预算统计和行为追溯的依据

---

## 回退脚本位置

```
/root/workspace/config/model-routing/restore-default-route.sh
```

---

## 相关文件

- 默认路由配置：`/root/workspace/config/model-routing/default-provider.env`
- 运行时 active 配置：`/root/workspace/runtime/model-routing/active-provider.env`
- 授权状态文件：`/root/workspace/runtime/model-routing/external-model-approval.status`
- 模型切换指南：`137-model-switching-guide.md`
