# 灵犀更高自治运行清单

> 任务59 - 第6批阶段更高自治运行清单
> 生成时间：2026-03-25 11:13 CST

---

## 一、概述

本清单定义了在第6批阶段，灵犀可以在更高自治程度下处理的事项。

### 自治级别定义

| 级别 | 说明 | 标记 |
|------|------|------|
| **L5** | 默认可直接执行 | ✅ |
| **L4** | 建议先出 plan | ⚠️ |
| **L3** | 必须人工确认 | ❌ |

---

## 二、事项清单

### 2.1 自动巡检

| 事项 | 触发条件 | 自治级别 | 输出 | 人工复核 |
|------|----------|----------|------|----------|
| 仓库状态检查 | 每次开始前 | ✅ L5 | 状态信息 | 不需要 |
| Git 状态检查 | 任意时间 | ✅ L5 | 状态信息 | 不需要 |
| 分支检查 | 任意时间 | ✅ L5 | 分支名 | 不需要 |

**命令**：
```bash
bash scripts/dev-entry-v2.sh status
```

---

### 2.2 自动状态汇总

| 事项 | 触发条件 | 自治级别 | 输出 | 人工复核 |
|------|----------|----------|------|----------|
| 状态报告生成 | 任务切换时 | ✅ L5 | Markdown 报告 | 可选 |
| 变更摘要 | 任意时间 | ✅ L5 | Markdown 报告 | 可选 |
| 回归汇总 | 任务完成后 | ✅ L5 | Markdown 报告 | 建议 |

**命令**：
```bash
# 状态报告
bash scripts/generate-status-report.sh

# 变更摘要
bash scripts/generate-change-summary-v2.sh

# 回归汇总
bash scripts/generate-regression-summary.sh
```

---

### 2.3 自动 Handoff 草稿

| 事项 | 触发条件 | 自治级别 | 输出 | 人工复核 |
|------|----------|----------|------|----------|
| Handoff 草稿生成 | 任务完成后 | ✅ L5 | Markdown 文档 | 必须 |

**命令**：
```bash
bash scripts/generate-handoff-v2.sh -t "任务XX"
```

---

### 2.4 自动 Change Summary 草稿

| 事项 | 触发条件 | 自治级别 | 输出 | 人工复核 |
|------|----------|----------|------|----------|
| Change Summary 草稿 | 任意时间 | ✅ L5 | Markdown 文档 | 可选 |

**命令**：
```bash
bash scripts/generate-change-summary-v2.sh -n 5
```

---

### 2.5 自动 Regression 汇总

| 事项 | 触发条件 | 自治级别 | 输出 | 人工复核 |
|------|----------|----------|------|----------|
| Regression 汇总 | 验证后 | ✅ L5 | Markdown 报告 | 建议 |

**命令**：
```bash
bash scripts/generate-regression-summary.sh
```

---

### 2.6 小范围模块化整理

| 事项 | 触发条件 | 自治级别 | 输出 | 人工复核 |
|------|----------|----------|------|----------|
| 抽取公共函数 | 需要复用时 | ⚠️ L4 | 修改脚本 | 必须 |
| 统一输出格式 | 需要一致时 | ⚠️ L4 | 修改脚本 | 必须 |
| 修复脚本 bug | 发现问题时 | ⚠️ L4 | 修改脚本 | 必须 |

**原则**：
- 改动不超过 2 个文件
- 不改变功能逻辑
- 先 commit 当前状态

---

### 2.7 小功能增强

| 事项 | 触发条件 | 自治级别 | 输出 | 人工复核 |
|------|----------|----------|------|----------|
| 添加新命令 | 需要新功能时 | ⚠️ L4 | 新增脚本 | 必须 |
| 增强现有功能 | 需要扩展时 | ⚠️ L4 | 修改脚本 | 必须 |
| Demo 增强 | 需要演示时 | ⚠️ L4 | 修改 demo | 必须 |

**原则**：
- 不超过 3 个文件
- 不改变现有接口
- 先出 plan

---

## 三、执行边界

### 3.1 默认可直接做（L5）

```bash
# 巡检类
bash scripts/dev-entry-v2.sh status
bash scripts/dev-entry-v2.sh check

# 报告类
bash scripts/generate-status-report.sh
bash scripts/generate-change-summary-v2.sh
bash scripts/generate-regression-summary.sh
bash scripts/generate-handoff-v2.sh

# 验证类
bash scripts/verify-main-feature.sh
bash scripts/verify-main-feature.sh --quick
```

### 3.2 建议先出 Plan（L4）

- 抽取公共函数
- 统一输出格式
- 添加新命令
- 增强现有功能

### 3.3 必须人工确认

- 删除文件
- 改变接口
- 超过 3 个文件的改动

---

## 四、决策流程

### 4.1 是否需要先出 Plan

```
改动范围 ≤ 2 个文件？
  ├── 是 → 能否保持接口不变？
  │         ├── 是 → ⚠️ L4 可执行
  │         └── 否 → ❌ 需要确认
  └── 否 → ❌ 需要确认
```

### 4.2 是否需要人工确认

```
改动是否：
- 删除文件？ → ❌
- 改变接口？ → ❌
- 超过 3 个文件？ → ❌
- 改变核心逻辑？ → ❌
└── 以上都不满足 → ⚠️ L4 可执行，但建议先沟通
```

---

## 五、相关文档

| 文档 | 说明 |
|------|------|
| `docs/collab/chatgpt-lingxi/74-phase6-autonomy-boundary.md` | 自治边界说明 |
| `docs/collab/chatgpt-lingxi/81-advanced-multi-agent-flow.md` | 多 Agent 协作规则 |
| `docs/collab/chatgpt-lingxi/80-phase-dashboard-v2.md` | 阶段状态面板 |

---

## 六、总结

| 自治级别 | 事项 | 数量 |
|----------|------|------|
| ✅ L5 | 巡检/报告/Handoff/验证 | 13 |
| ⚠️ L4 | 模块化整理/功能增强 | 6 |
| ❌ | 需确认事项 | 4 |

---

*本文档为任务59输出*
