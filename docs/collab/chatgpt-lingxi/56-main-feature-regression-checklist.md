# 任务36 - 主功能最小回归检查清单 - 执行报告

> 生成时间：2026-03-25 09:58 CST
> 执行者：灵犀
> 分支：chore/cursor-bootstrap

---

## 一、任务概述

为主功能（`dev-entry.sh` / `dev-entry.ps1`）建立轻量回归检查清单，用于每次改动后快速复查。

---

## 二、完成内容

### 2.1 创建的文件

| 文件 | 说明 |
|------|------|
| `docs/main-feature-regression-checklist.md` | 主功能最小回归检查清单 |
| `docs/collab/chatgpt-lingxi/56-main-feature-regression-checklist.md` | 本报告 |

### 2.2 回归检查清单结构

| 优先级 | 检查项数 | 说明 |
|--------|----------|------|
| P0: 阻塞级 | 8 | 入口/核心命令/依赖 |
| P1: 重要级 | 6 | 扩展功能/模式/错误处理 |
| P2: 增强级 | 3 | 参数兼容性 |
| **总计** | **17** | |

---

## 三、回归检查项摘要

### P0 - 阻塞级（必须通过）

| 序号 | 检查项 | 验证方法 |
|------|--------|----------|
| P0-1 | 入口脚本可执行 | `bash scripts/dev-entry.sh -h` |
| P0-2 | help 命令 | `bash scripts/dev-entry.sh help` |
| P0-3 | status 命令 | `bash scripts/dev-entry.sh status` |
| P0-4 | check 命令 | `bash scripts/dev-entry.sh check` |
| P0-5 | docs 命令 | `bash scripts/dev-entry.sh docs` |
| P0-6 | all 命令 | `bash scripts/dev-entry.sh all` |
| P0-7 | preflight 命令 | `bash scripts/dev-entry.sh preflight` |
| P0-8 | 依赖库可加载 | `source scripts/lib-common.sh` |

### P1 - 重要级（建议通过）

| 序号 | 检查项 | 验证方法 |
|------|--------|----------|
| P1-1 | report 命令 | `bash scripts/dev-entry.sh report` |
| P1-2 | handoff 命令 | `bash scripts/dev-entry.sh handoff` |
| P1-3 | reports 命令 | `bash scripts/dev-entry.sh reports` |
| P1-4 | verbose 模式 | `bash scripts/dev-entry.sh -v status` |
| P1-5 | 安静模式 | `bash scripts/dev-entry.sh -q status` |
| P1-6 | 错误处理 | `bash scripts/dev-entry.sh unknown` |

### P2 - 增强级（可选）

| 序号 | 检查项 | 验证方法 |
|------|--------|----------|
| P2-1 | -h 快捷参数 | `bash scripts/dev-entry.sh -h` |
| P2-2 | -v 快捷参数 | `bash scripts/dev-entry.sh -v` |
| P2-3 | --help 长参数 | `bash scripts/dev-entry.sh --help` |

---

## 四、回归检查流程

```
1. 修改代码
2. 执行 quick-regression-check.sh（自动）
3. 检查 P0 全部通过
4. 检查 P1 建议通过
5. 如有失败 → 修复后重新检查
```

---

## 五、Commit 信息

见下方 commit 记录。

---

*本文档为任务36执行报告 v1.0*
