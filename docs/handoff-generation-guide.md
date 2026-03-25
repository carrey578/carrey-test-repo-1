# Handoff 生成指南 v2

> 自动化 Handoff 生成机制使用说明

---

## 概述

`generate-handoff-v2` 是自动化的任务交接文档生成脚本，支持：

- 自动提取最近 commit
- 自动汇总 verify 结果
- 自动列出改动文件
- 保留人工补充空间

---

## 快速开始

### Linux/macOS

```bash
# 生成默认 handoff
bash scripts/generate-handoff-v2.sh

# 指定任务名
bash scripts/generate-handoff-v2.sh -t "任务45-测试"

# 指定输出文件
bash scripts/generate-handoff-v2.sh -o "docs/collab/chatgpt-lingxi/my-handoff.md"
```

### Windows

```powershell
# 生成默认 handoff
pwsh tools/generate-handoff-v2.ps1

# 指定任务名
pwsh tools/generate-handoff-v2.ps1 -Task "任务45-测试"

# 指定输出文件
pwsh tools/generate-handoff-v2.ps1 -Output "docs/collab/chatgpt-lingxi/my-handoff.md"
```

---

## 选项

| 选项 | 说明 | 示例 |
|------|------|------|
| -t, --task | 任务名称 | `-t "任务45"` |
| -o, --output | 输出文件 | `-o "custom.md"` |
| -v, --verbose | 详细输出 | `-v` |

---

## 输出内容

| 章节 | 内容 | 来源 |
|------|------|------|
| 本轮目标 | 任务目标列表 | 人工补充 |
| 最近提交 | 最近5条 commit | 自动提取 |
| 改动文件 | 所有改动/文档/脚本 | 自动提取 |
| Verify 结果 | 验证状态 | 自动运行 |
| 未完成事项 | 待办列表 | 人工补充 |
| 风险 | 风险列表 | 人工补充 |
| 下一步建议 | 建议列表 | 人工补充 |
| 人工补充区 | 补充说明 | 人工补充 |
| 统计信息 | 分支/提交/文件数 | 自动提取 |

---

## 使用场景

### 场景1：任务完成后 Handoff

```bash
# 完成任务后
bash scripts/generate-handoff-v2.sh -t "任务45-完成"

# 手动补充关键信息
# 提交并推送
```

### 场景2：阶段 Handoff

```bash
# 第5批完成后
bash scripts/generate-handoff-v2.sh -t "第5批阶段Handoff"
```

---

## 输出文件

默认输出：`docs/collab/chatgpt-lingxi/handoff-<timestamp>.md`

---

## v1 vs v2 对比

| 功能 | v1 | v2 |
|------|----|----|
| 最近 Commit | ✅ | ✅ (5条) |
| 改动文件 | ✅ | ✅ |
| 人工补充区 | ✅ | ✅ |
| Verify 结果 | ❌ | ✅ |
| 统计信息 | ❌ | ✅ |
| 新增文档列表 | ❌ | ✅ |
| 新增脚本列表 | ❌ | ✅ |

---

## 相关脚本

| 脚本 | 说明 |
|------|------|
| `generate-handoff-v2.sh/ps1` | Handoff 生成 v2 |
| `generate-status-report.sh/ps1` | 状态报告生成 |
| `generate-change-report.sh/ps1` | 变更报告生成 |
| `dev-entry-v2.sh/ps1` | 统一入口 |

---

*本文档由灵犀自动生成*
