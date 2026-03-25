# Change Summary 生成指南 v2

> 自动化 Change Summary 生成机制使用说明

---

## 概述

`generate-change-summary-v2` 是自动化变更摘要生成脚本，用于总结最近一次或最近一轮改动。

---

## 快速开始

### Linux/macOS

```bash
# 生成最近5个提交的摘要
bash scripts/generate-change-summary-v2.sh

# 指定提交数量
bash scripts/generate-change-summary-v2.sh -n 10

# 指定输出文件
bash scripts/generate-change-summary-v2.sh -o "my-summary.md"
```

### Windows

```powershell
# 生成最近5个提交的摘要
pwsh tools/generate-change-summary-v2.ps1

# 指定提交数量
pwsh tools/generate-change-summary-v2.ps1 -Count 10

# 指定输出文件
pwsh tools/generate-change-summary-v2.ps1 -Output "my-summary.md"
```

---

## 选项

| 选项 | 说明 | 默认值 |
|------|------|--------|
| -n, --count | 提交数量 | 5 |
| -o, --output | 输出文件 | 自动生成 |

---

## 输出内容

| 章节 | 内容 |
|------|------|
| 变更概览 | 提交数、新增/修改/删除文件数 |
| 最近提交 | 最近 N 条 commit |
| 改动详情 | 新增/修改/删除文件列表 |
| 按类型统计 | 文档/脚本/配置文件统计 |
| Review 建议 | 重点检查项 |

---

## 使用场景

### 场景1：日常变更摘要

```bash
# 查看最近改动
bash scripts/generate-change-summary-v2.sh
```

### 场景2：周报/阶段总结

```bash
# 查看最近10个提交
bash scripts/generate-change-summary-v2.sh -n 10
```

### 场景3：Handoff 前

```bash
# 生成变更摘要供 review
bash scripts/generate-change-summary-v2.sh -n 5
```

---

## 输出文件

默认输出：`docs/collab/chatgpt-lingxi/change-summary-<timestamp>.md`

---

## v1 vs v2 对比

| 功能 | v1 | v2 |
|------|----|----|
| 最近提交 | ✅ | ✅ |
| 改动文件 | ✅ | ✅ |
| 改动分类 | - | ✅ |
| 类型统计 | - | ✅ |
| Review 建议 | - | ✅ |

---

## 相关脚本

| 脚本 | 说明 |
|------|------|
| `generate-change-summary-v2.sh/ps1` | Change Summary 生成 v2 |
| `generate-status-report.sh/ps1` | 状态报告生成 |
| `generate-handoff-v2.sh/ps1` | Handoff 生成 |
| `dev-entry-v2.sh/ps1` | 统一入口 |

---

*本文档由灵犀自动生成*
