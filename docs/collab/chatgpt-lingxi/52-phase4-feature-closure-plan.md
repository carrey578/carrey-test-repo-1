# 任务32 - 统一入口完整闭环补强方案

> 生成时间：2026-03-25 03:14 CST
> 执行者：灵犀
> 分支： chore/cursor-bootstrap

---

## 一、当前功能现状

### 1.1 已具备

| 类型 | 文件 | 说明 |
|------|------|------|
| 功能实现 | `scripts/dev-entry.sh` | 8个命令 + 参数支持 |
| 功能实现 | `tools/dev-entry.ps1` | Windows 版同步 |
| 验证脚本 | `scripts/verify-dev-entry.sh` | 自动验证脚本 |
| 验证脚本 | `tools/verify-dev-entry.ps1` | Windows 版验证 |
| 使用说明 | `docs/feature-usage-guide.md` | 用户使用指南 |
| 开发说明 | `docs/feature-dev-notes.md` | 开发者指南 |
| 测试清单 | `docs/feature-test-checklist.md` | 功能测试清单 |
| 公共库 | `scripts/lib-common.sh` | 公共函数库 |
| Handoff | `docs/collab/chatgpt-lingxi/43-feature-handoff.md` | 交接文档 |

### 1.2 仍缺失

| 缺失项 | 优先级 | 说明 |
|--------|--------|------|
| 回归检查清单 | P1 | 改动后必做检查项 |
| 回滚/恢复手册 | P1 | 详细恢复步骤 |
| 完整 handoff | P1 | 标准化交接文档（需更新） |
| 测试覆盖增强 | P2 | 补充更多边界测试 |

---

## 二、子步骤拆解

### 步骤 1：生成回归检查清单

**目标**：建立改动后的必做检查清单  
**涉及文件**：新建 `docs/feature-regression-checklist.md`  
**是否新增**：是  
**验收方式**：覆盖正常/异常/输出存在性

---

### 步骤 2：生成详细回滚/恢复手册

**目标**：明确最小恢复操作步骤  
**涉及文件**：新建 `docs/feature-rollback-guide.md`  
**是否新增**：是  
**验收方式**：人工可按文档执行恢复

---

### 步骤 3：更新 Handoff 文档

**目标**：补齐完整的交接文档  
**涉及文件**：修改 `docs/collab/chatgpt-lingxi/43-feature-handoff.md`  
**是否新增**：否  
**验收方式**：包含所有必要字段

---

### 步骤 4：增强测试覆盖

**目标**：补充边界测试用例  
**涉及文件**：修改 `docs/feature-test-checklist.md`  
**是否新增**：否  
**验收方式**：覆盖更多边界情况

---

### 步骤 5：创建完整闭环索引

**目标**：汇总所有闭环文档的索引  
**涉及文件**：新建 `docs/feature-closure-index.md`  
**是否新增**：是  
**验收方式**：包含所有文档链接

---

## 三、最小完成标准

| 标准 | 说明 |
|------|------|
| 回归检查清单存在 | 至少覆盖 5 项检查 |
| 回滚手册存在 | 至少包含 3 种恢复场景 |
| Handoff 完整 | 包含功能/文件/验证/使用/后续建议 |
| 测试覆盖增强 | 新增至少 3 项边界测试 |
| 闭环索引完整 | 链接所有相关文档 |

---

## 四、文件清单

| 文件 | 操作 | 说明 |
|------|------|------|
| `docs/feature-regression-checklist.md` | 新建 | 回归检查清单 |
| `docs/feature-rollback-guide.md` | 新建 | 回滚/恢复手册 |
| `docs/collab/chatgpt-lingxi/43-feature-handoff.md` | 修改 | 更新 Handoff |
| `docs/feature-test-checklist.md` | 修改 | 增强测试覆盖 |
| `docs/feature-closure-index.md` | 新建 | 闭环索引 |

---

## 五、后续可扩展

闭环补齐后可快速复制到其他功能：
- preflight-check.sh
- generate-change-report.sh
- generate-handoff.sh

---

*本文档为完整闭环补强方案 v1.0*