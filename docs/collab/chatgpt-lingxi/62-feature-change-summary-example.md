# 功能 Change Summary 示例

> 基于模板的实际填写示例

---

## 必填项

| 字段 | 说明 | 示例 |
|------|------|------|
| `feature_name` | 功能名称 | 主功能文档体系 |
| `version` | 版本号 | v1.0 |
| `timestamp` | 生成时间 | 2026-03-25 10:05 |
| `author` | 作者 | 灵犀 |

---

## 1. 变更概述

> 一句话说明本次变更

为主功能（dev-entry）建立完整的文档体系，包括验证指南、测试清单、回归检查、回滚手册和使用说明。

变更类型:
- [x] 新功能
- [ ] 功能改进
- [ ] Bug 修复
- [x] 文档更新
- [ ] 重构

变更摘要: 建立主功能文档体系，产出8个新文档

---

## 2. 详细变更

### 2.1 新增

| 文件 | 说明 |
|------|------|
| `scripts/verify-main-feature.sh` | 验证脚本（Linux） |
| `tools/verify-main-feature.ps1` | 验证脚本（Windows） |
| `docs/main-feature-verify-guide.md` | 验证指南 |
| `docs/main-feature-test-checklist.md` | 测试清单（24项） |
| `docs/main-feature-regression-checklist.md` | 回归检查（17项） |
| `docs/main-feature-rollback-recovery-guide.md` | 回滚恢复手册 |
| `docs/main-feature-usage-guide.md` | 使用说明 |
| `docs/main-feature-dev-guide.md` | 开发维护说明 |

### 2.2 修改

| 文件 | 变更内容 |
|------|----------|
| 无 | |

### 2.3 删除

| 文件 | 原因 |
|------|------|
| 无 | |

---

## 3. 验证结果

> 测试/验证结果

| 测试项 | 结果 | 说明 |
|--------|------|------|
| verify-main-feature.sh | 通过 | 6/6 项通过 |
| help 命令 | 通过 | 显示完整帮助 |
| status 命令 | 通过 | 显示分支信息 |
| 回归检查 | 通过 | P0 全部通过 |

---

## 4. 影响范围

> 本次变更影响到的功能

- 影响1: 主功能文档体系完善
- 影响2: 后续开发/维护有据可依
- 影响3: 任务交接更规范

---

## 5. 回滚方案

> 如何回滚本次变更

```bash
# 回滚所有新增文档
git checkout HEAD -- docs/main-feature-verify-guide.md
git checkout HEAD -- docs/main-feature-test-checklist.md
git checkout HEAD -- docs/main-feature-regression-checklist.md
git checkout HEAD -- docs/main-feature-rollback-recovery-guide.md
git checkout HEAD -- docs/main-feature-usage-guide.md
git checkout HEAD -- docs/main-feature-dev-guide.md

# 或完全回滚
git reset --hard HEAD~1
```

---

## 6. 关联文档

| 文档 | 说明 |
|------|------|
| `docs/main-feature-verify-guide.md` | 验证指南 |
| `docs/main-feature-test-checklist.md` | 测试清单 |
| `docs/main-feature-regression-checklist.md` | 回归检查 |
| `docs/main-feature-rollback-recovery-guide.md` | 回滚手册 |
| `docs/main-feature-usage-guide.md` | 使用说明 |
| `docs/main-feature-dev-guide.md` | 开发维护说明 |

---

*示例版本: v1.0*
