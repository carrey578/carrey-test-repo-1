# Demo 入口指南

> 最小 Demo 入口和展示说明

---

## 概述

`demo-entry.sh` 是一个轻量 Demo 入口，用于展示当前仓库的自动化能力。

---

## 快速开始

### 运行 Demo

```bash
# 进入仓库目录
cd /path/to/carrey-test-repo-1

# 运行 Demo 入口
bash scripts/demo-entry.sh
```

### 选择 Demo

```
=== 最小 Demo 入口 ===

当前仓库自动化能力演示

  1. 自动化报告
     展示自动生成报告的能力
     
  2. 功能验证
     展示功能验证的能力
     
  3. 变更摘要
     展示变更摘要的能力
     
  4. 完整流程
     展示从验证到报告的完整流程
     
  5. 全部运行
     运行所有Demo
     
  0. 退出
```

---

## Demo 说明

### Demo 1: 自动化报告

展示自动生成状态报告的能力。

```bash
bash scripts/demo-entry.sh 1
```

**输出**：
- 状态报告文件

### Demo 2: 功能验证

展示功能验证的能力。

```bash
bash scripts/demo-entry.sh 2
```

**输出**：
- 验证结果（通过/失败/跳过数量）

### Demo 3: 变更摘要

展示变更摘要生成的能力。

```bash
bash scripts/demo-entry.sh 3
```

**输出**：
- 变更摘要文件

### Demo 4: 完整流程

展示从验证到报告的完整流程。

```bash
bash scripts/demo-entry.sh 4
```

**输出**：
- 验证结果
- 状态报告
- 变更摘要

### Demo 5: 全部运行

运行所有 Demo。

```bash
bash scripts/demo-entry.sh 5
```

---

## 当前限制

| 限制 | 说明 |
|------|------|
| 仅 Linux | 暂无 Windows 版本 |
| 需 Git | 需要 Git 仓库环境 |
| 需 bash | 需要 bash 环境 |
| 无远程调用 | 不支持远程执行 |

---

## 相关脚本

| 脚本 | 用途 |
|------|------|
| `demo-entry.sh` | Demo 入口 |
| `verify-main-feature.sh` | 功能验证 |
| `generate-status-report.sh` | 状态报告 |
| `generate-change-summary-v2.sh` | 变更摘要 |
| `generate-handoff-v2.sh` | Handoff 生成 |

---

*本文档由灵犀自动生成*
