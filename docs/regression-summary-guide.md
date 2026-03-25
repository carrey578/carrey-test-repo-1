# 回归汇总指南

> 自动化回归汇总机制使用说明

---

## 概述

`generate-regression-summary.sh` 用于汇总最近一轮验证和回归结果，帮助快速了解风险状态。

---

## 快速开始

### Linux/macOS

```bash
# 生成默认汇总（最近5个提交）
bash scripts/generate-regression-summary.sh

# 指定提交数量
bash scripts/generate-regression-summary.sh -n 10

# 指定输出文件
bash scripts/generate-regression-summary.sh -o "my-regression.md"
```

---

## 输出内容

| 章节 | 内容 |
|------|------|
| 执行摘要 | Verify 结果、最近改动、建议 |
| Verify 结果 | 验证执行输出 |
| 最近改动 | 最近 N 个提交的改动文件 |
| 风险点识别 | 按类型识别风险 |
| 建议 | 是否建议继续下一轮 |

---

## 使用场景

### 场景1：每次任务后汇总

```bash
# 完成任务后
bash scripts/generate-regression-summary.sh

# 查看是否建议继续
```

### 场景2：提交前检查

```bash
# 提交前
bash scripts/generate-regression-summary.sh -n 3
# 确认风险点后再提交
```

### 场景3：定期巡检

```bash
# 每周巡检
bash scripts/generate-regression-summary.sh -n 20
```

---

## 建议判断逻辑

| 条件 | 建议 |
|------|------|
| Verify 全部通过 | ✅ 建议继续 |
| Verify 部分通过 | ⚠️ 建议检查后继续 |
| Verify 失败 | ❌ 不建议继续 |

---

## 输出文件

默认：`docs/collab/chatgpt-lingxi/regression-summary-<timestamp>.md`

---

## 相关脚本

| 脚本 | 用途 |
|------|------|
| `generate-regression-summary.sh` | 回归汇总 |
| `verify-main-feature.sh` | 功能验证 |
| `generate-change-summary-v2.sh` | 变更摘要 |
| `generate-status-report.sh` | 状态报告 |

---

*本文档由灵犀自动生成*
