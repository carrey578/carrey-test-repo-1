# Change Summary 功能自述文件

> Change Summary 生成功能的完整自述
> 版本: v2.0

---

## 功能概述

**Change Summary**（变更摘要）是一个自动化脚本，用于总结最近一次或最近一轮代码改动。

### 它能做什么

- 自动提取最近 N 个 commit
- 自动分类改动文件（新增/修改/删除）
- 按类型统计（文档/脚本/配置）
- 生成适合 Review 的 Markdown 报告

---

## 快速开始

### 一键生成

```bash
bash scripts/generate-change-summary-v2.sh
```

### 输出示例

生成的报告包含以下章节：

```
# Change Summary - 变更摘要

## 一、变更概览
| 项目 | 数量 |
|------|------|
| 提交数 | 5 |
| 新增文件 | 3 |
| 修改文件 | 2 |

## 二、最近提交
- abc1234 feat: 新增功能X
- def5678 docs: 更新文档

## 三、改动详情
### 3.1 新增文件
  - docs/new-feature.md
  - scripts/new-script.sh

### 3.2 修改文件
  - docs/existing.md

## 四、按类型统计
| 类型 | 数量 |
|------|------|
| 文档 (.md) | 2 |
| 脚本 (.sh) | 1 |
```

---

## 使用场景

### 场景1：日常变更查看

```bash
# 查看最近5个提交
bash scripts/generate-change-summary-v2.sh

# 查看最近3个提交
bash scripts/generate-change-summary-v2.sh -n 3

# 查看最近10个提交
bash scripts/generate-change-summary-v2.sh -n 10
```

### 场景2：周报生成

```bash
# 查看本周所有改动
bash scripts/generate-change-summary-v2.sh -n 20
```

### 场景3：Handoff 前准备

```bash
# 生成变更摘要
bash scripts/generate-change-summary-v2.sh -n 5
# 输出到: docs/collab/chatgpt-lingxi/change-summary-20260325-xxxxxx.md

# 然后生成 Handoff
bash scripts/generate-handoff-v2.sh -t "任务XX"
```

### 场景4：Code Review 前

```bash
# 生成变更摘要
bash scripts/generate-change-summary-v2.sh -n 10
# 发送给 reviewer
```

---

## 命令选项

| 选项 | 简写 | 说明 | 默认值 |
|------|------|------|--------|
| --count | -n | 最近多少个提交 | 5 |
| --output | -o | 输出文件名 | 自动生成 |
| --verbose | -v | 详细输出 | false |

### 示例

```bash
# 只看最近1个提交
bash scripts/generate-change-summary-v2.sh -n 1

# 输出到指定文件
bash scripts/generate-change-summary-v2.sh -o "my-changes.md"

# 详细模式
bash scripts/generate-change-summary-v2.sh -v

# 组合使用
bash scripts/generate-change-summary-v2.sh -n 10 -o "weekly-summary.md"
```

---

## 输出文件

### 默认位置

```
docs/collab/chatgpt-lingxi/change-summary-<timestamp>.md
```

### 示例文件名

```
change-summary-20260325-110500.md
```

---

## 与其他功能的关系

### 配套使用

| 脚本 | 用途 | 典型顺序 |
|------|------|----------|
| generate-change-summary-v2.sh | 变更摘要 | 1. 先看改了什么 |
| generate-status-report.sh | 状态报告 | 2. 再看整体状态 |
| generate-handoff-v2.sh | Handoff | 3. 最后生成交接 |

### 入口脚本

你也可以通过 `dev-entry-v2.sh` 调用：

```bash
# 通过统一入口
bash scripts/dev-entry-v2.sh summary

# 完整检查（含 summary）
bash scripts/dev-entry-v2.sh full
```

---

## 常见问题

### Q1: 报错 "无提交记录"

这是正常的，说明这是一个新仓库或者没有 commit。

### Q2: 输出的文件在哪里

默认输出到 `docs/collab/chatgpt-lingxi/` 目录。

### Q3: 如何只看某个目录的改动

当前版本不支持按目录过滤，可以后续通过 Git 路径过滤实现。

### Q4: 报告可以自定义吗

可以修改脚本中的模板部分来自定义报告格式。

---

## 技术细节

### 依赖

- bash
- git
- 标准 Unix 工具 (grep, awk, wc)

### 输出格式

- 纯文本 Markdown
- 兼容所有 Markdown 编辑器

---

## 相关文档

| 文档 | 说明 |
|------|------|
| `docs/change-summary-v2-guide.md` | 详细使用指南 |
| `docs/collab/chatgpt-lingxi/68-change-summary-auto-example.md` | 示例输出 |

---

## 版本历史

| 版本 | 日期 | 变化 |
|------|------|------|
| v1.0 | 2026-03-25 | 初始版本 |
| v2.0 | 2026-03-25 | 增加分类统计、Review 建议 |

---

*本文档由灵犀自动生成*
