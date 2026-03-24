# 统一入口功能闭环索引

> 生成时间：2026-03-25 03:17 CST
> 执行者：灵犀
> 分支： chore/cursor-bootstrap

---

## 一、闭环文档概览

本文档汇总统一入口功能（dev-entry.sh）的所有闭环相关文档。

---

## 二、文档索引

### 2.1 功能实现

| 文档 | 路径 | 说明 |
|------|------|------|
| 主脚本 | `scripts/dev-entry.sh` | Linux 端入口脚本 |
| Windows 脚本 | `tools/dev-entry.ps1` | Windows 端入口脚本 |
| 公共库 | `scripts/lib-common.sh` | 公共函数库 |

### 2.2 验证与测试

| 文档 | 路径 | 说明 |
|------|------|------|
| 验证脚本 | `scripts/verify-dev-entry.sh` | 自动验证脚本 |
| 验证脚本(Win) | `tools/verify-dev-entry.ps1` | Windows 验证脚本 |
| 测试清单 | `docs/feature-test-checklist.md` | 功能测试清单（45项） |
| 回归检查清单 | `docs/feature-regression-checklist.md` | 改动后检查项 |

### 2.3 使用与开发

| 文档 | 路径 | 说明 |
|------|------|------|
| 使用说明 | `docs/feature-usage-guide.md` | 用户使用指南 |
| 开发说明 | `docs/feature-dev-notes.md` | 开发者指南 |

### 2.4 回滚与恢复

| 文档 | 路径 | 说明 |
|------|------|------|
| 回滚手册 | `docs/feature-rollback-guide.md` | 恢复步骤指南 |

### 2.5 交接与模板

| 文档 | 路径 | 说明 |
|------|------|------|
| Handoff | `docs/collab/chatgpt-lingxi/43-feature-handoff.md` | 功能交接文档 |
| 任务模板 | `docs/collab/chatgpt-lingxi/template-feature-task.md` | 任务模板 |
| 计划模板 | `docs/collab/chatgpt-lingxi/template-feature-plan.md` | 计划模板 |
| 验证模板 | `docs/collab/chatgpt-lingxi/template-feature-verify.md` | 验证模板 |
| 改动模板 | `docs/collab/chatgpt-lingxi/template-code-change.md` | 代码改动模板 |
| 交接模板 | `docs/collab/chatgpt-lingxi/template-feature-handoff.md` | 交接模板 |

### 2.6 方案与报告

| 文档 | 路径 | 说明 |
|------|------|------|
| 功能选择 | `docs/collab/chatgpt-lingxi/51-phase4-feature-selection.md` | 功能选择分析 |
| 闭环方案 | `docs/collab/chatgpt-lingxi/52-phase4-feature-closure-plan.md` | 闭环补强方案 |
| 实现摘要 | `docs/collab/chatgpt-lingxi/53-feature-implementation-gap-fill-summary.md` | 本次实现摘要 |

---

## 三、快速入口

### 验证功能
```bash
bash scripts/verify-dev-entry.sh
```

### 运行回归检查
```bash
# 查看回归检查清单
cat docs/feature-regression-checklist.md

# 执行快速检查
for cmd in help check status; do bash scripts/dev-entry.sh $cmd; done
```

### 回滚恢复
```bash
# 查看回滚手册
cat docs/feature-rollback-guide.md

# 快速回滚
git checkout HEAD -- scripts/dev-entry.sh
```

---

## 四、版本信息

- 闭环版本：v1.0
- 生成时间：2026-03-25
- 主功能：dev-entry.sh

---

*本文档为闭环索引 v1.0*