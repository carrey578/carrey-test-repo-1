# 开发入口脚本 v2 使用指南

> 统一开发入口脚本 v2

---

## 概述

`dev-entry-v2` 是统一的开发任务入口，整合了以下功能：

| 类别 | 命令 |
|------|------|
| 开发检查 | check, preflight, env |
| 验证 | verify, verify-all |
| 状态报告 | status, report, summary |
| 文档 | docs, handoff |
| 批量 | all, full |

---

## 快速开始

### Linux/macOS

```bash
# 查看帮助
bash scripts/dev-entry-v2.sh help

# 开发环境检查
bash scripts/dev-entry-v2.sh check

# 功能验证
bash scripts/dev-entry-v2.sh verify

# 查看状态
bash scripts/dev-entry-v2.sh status

# 完整检查
bash scripts/dev-entry-v2.sh full
```

### Windows

```powershell
# 查看帮助
pwsh tools/dev-entry-v2.ps1

# 开发环境检查
pwsh tools/dev-entry-v2.ps1 check

# 功能验证
pwsh tools/dev-entry-v2.ps1 verify

# 查看状态
pwsh tools/dev-entry-v2.ps1 status

# 完整检查
pwsh tools/dev-entry-v2.ps1 full
```

---

## 命令详解

### 开发检查类

| 命令 | 说明 |
|------|------|
| check | 运行开发环境检查 |
| preflight | 运行预提交检查 |
| env | 检查本地/服务器环境信息 |

### 验证类

| 命令 | 说明 |
|------|------|
| verify | 运行快速功能验证（--quick） |
| verify-all | 运行完整功能验证 |

### 状态报告类

| 命令 | 说明 |
|------|------|
| status | 显示仓库状态（分支、提交数） |
| report | 生成状态报告到共享目录 |
| summary | 生成变更摘要（最近提交+改动文件） |

### 文档类

| 命令 | 说明 |
|------|------|
| docs | 查看文档目录索引 |
| handoff | 生成 handoff 文档 |

### 批量类

| 命令 | 说明 |
|------|------|
| all | 运行所有检查（check+preflight+status） |
| full | 完整检查+验证+报告 |

---

## 选项

| 选项 | 说明 |
|------|------|
| -v, --verbose | 详细输出模式 |
| -q, --quiet | 安静模式（只输出关键信息） |
| -h, --help | 显示帮助 |

---

## 使用示例

### 日常开发

```bash
# 1. 开始开发前检查环境
bash scripts/dev-entry-v2.sh check

# 2. 提交前预检
bash scripts/dev-entry-v2.sh preflight

# 3. 查看当前状态
bash scripts/dev-entry-v2.sh status
```

### 任务完成后

```bash
# 1. 运行验证
bash scripts/dev-entry-v2.sh verify-all

# 2. 生成状态报告
bash scripts/dev-entry-v2.sh report

# 3. 生成 handoff
bash scripts/dev-entry-v2.sh handoff
```

### 完整流程

```bash
# 一键完整检查
bash scripts/dev-entry-v2.sh full
```

---

## v1 vs v2 对比

| 功能 | v1 | v2 |
|------|----|----|
| check | ✅ | ✅ |
| status | ✅ | ✅ |
| preflight | ✅ | ✅ |
| docs | ✅ | ✅ |
| handoff | ✅ | ✅ |
| report | ✅ | ✅ |
| verify | ❌ | ✅ |
| verify-all | ❌ | ✅ |
| summary | ❌ | ✅ |
| env | ❌ | ✅ |
| all | ✅ | ✅ |
| full | ❌ | ✅ |

---

## 相关文件

| 文件 | 说明 |
|------|------|
| `scripts/dev-entry-v2.sh` | Linux 入口脚本 |
| `tools/dev-entry-v2.ps1` | Windows 入口脚本 |
| `scripts/dev-entry.sh` | 原有入口脚本 (v1) |
| `tools/dev-entry.ps1` | 原有入口脚本 (v1) |

---

*本文档由灵犀自动生成*
