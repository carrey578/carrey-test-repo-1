# 状态报告生成指南

> 自动化状态报告生成机制使用说明

---

## 概述

`generate-status-report` 脚本用于自动生成仓库状态报告，适用于：

- 任务切换时的状态同步
- Handoff 前的状态汇总
- 人工 review 前的准备
- 定期巡检

---

## 快速开始

### Linux/macOS

```bash
# 生成默认报告
bash scripts/generate-status-report.sh

# 指定输出文件
bash scripts/generate-status-report.sh docs/collab/chatgpt-lingxi/my-report.md
```

### Windows

```powershell
# 生成默认报告
pwsh tools/generate-status-report.ps1

# 指定输出文件
pwsh tools/generate-status-report.ps1 -Output "docs/collab/chatgpt-lingxi/my-report.md"
```

---

## 报告内容

| 章节 | 内容 |
|------|------|
| 仓库状态 | 分支、Commit ID |
| 最近提交 | 最近10条 commit |
| 最近改动文件 | 最近10个改动 |
| 文档变动 | 新增/修改的 .md 文件 |
| 脚本变动 | 新增/修改的 .sh/.ps1 文件 |
| 共享目录最新文档 | 最近10个文档 |
| 建议操作 | Review/Verify/Handoff 清单 |

---

## 使用场景

### 场景1：任务切换

```bash
# 完成任务后，生成状态报告
bash scripts/generate-status-report.sh
# 输出: docs/collab/chatgpt-lingxi/auto-status-report.md
```

### 场景2：Handoff 前

```bash
# 生成报告供人工 review
bash scripts/generate-status-report.sh
# 人工查看后准备 handoff
```

### 场景3：定期巡检

```bash
# 定期检查仓库状态
bash scripts/generate-status-report.sh
# 记录状态变化
```

---

## 输出文件

默认输出到：`docs/collab/chatgpt-lingxi/auto-status-report.md`

可在使用时指定自定义路径：

```bash
bash scripts/generate-status-report.sh docs/collab/chatgpt-lingxi/custom-report.md
```

---

## 集成使用

### 集成到 dev-entry-v2

```bash
# 通过 dev-entry-v2 调用
bash scripts/dev-entry-v2.sh report
```

---

## 相关脚本

| 脚本 | 说明 |
|------|------|
| `generate-status-report.sh/ps1` | 状态报告生成 |
| `generate-handoff.sh/ps1` | Handoff 生成 |
| `generate-change-report.sh/ps1` | 变更报告生成 |
| `dev-entry-v2.sh/ps1` | 统一入口 |

---

*本文档由灵犀自动生成*
