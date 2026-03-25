# 主功能最小回滚与恢复手册

> 面向当前仓库协作流程的快速回滚指南

## 概述

**主功能**: `dev-entry.sh` / `dev-entry.ps1`  
**分支策略**: `chore/cursor-bootstrap`（非 main）  
**核心原则**: 不使用 force push

---

## 快速回滚命令

### 单文件回滚（最常用）

```bash
# 回滚主脚本
git checkout HEAD -- scripts/dev-entry.sh

# 回滚依赖库
git checkout HEAD -- scripts/lib-common.sh

# 回滚 Windows 版本
git checkout HEAD -- tools/dev-entry.ps1

# 验证
bash scripts/dev-entry.sh help
```

### 多文件同时回滚

```bash
# 回滚主功能相关所有文件
git checkout HEAD -- scripts/dev-entry.sh tools/dev-entry.ps1 scripts/lib-common.sh

# 验证
bash scripts/dev-entry.sh help
```

---

## 场景与处理

### 场景 1：本轮改动需要撤回

**信号**: 刚提交的代码不对，想撤回

**处理**:
```bash
# 方法1: 撤销最近一次提交（保留修改）
git reset --soft HEAD~1

# 方法2: 完全撤销，不保留修改
git reset --hard HEAD~1

# 验证
bash scripts/dev-entry.sh help
```

### 场景 2：verify 失败

**信号**: `bash scripts/verify-main-feature.sh` 报错

**处理**:
```bash
# 1. 查看失败原因
bash scripts/verify-main-feature.sh

# 2. 如果是关键功能失败，回滚
git checkout HEAD -- scripts/dev-entry.sh

# 3. 重新验证
bash scripts/verify-main-feature.sh
```

### 场景 3：多文件改动后功能异常

**信号**: 改了多个文件后，命令执行出错

**处理**:
```bash
# 1. 查看改动
git status

# 2. 回滚所有相关文件
git checkout HEAD -- scripts/ tools/

# 3. 验证
bash scripts/verify-main-feature.sh
```

### 场景 4：文档与实现不一致

**信号**: 文档说的命令与实际不符

**处理**:
```bash
# 更新文档以匹配实现
# 或
# 修复实现以匹配文档

# 推荐：先验证当前状态
bash scripts/dev-entry.sh help
# 然后更新 docs/main-feature-verify-guide.md
```

---

## 推荐 vs 不推荐

| 操作 | 推荐 | 不推荐 |
|------|------|--------|
| 回滚单文件 | `git checkout HEAD -- file` | `git reset --hard`（会丢失未提交工作） |
| 撤销提交 | `git reset --soft HEAD~1` | `git push -f` |
| 查看历史 | `git log --oneline -10` | 直接改历史 |
| 恢复删除文件 | `git checkout HEAD -- path` | 手动重建 |

---

## 分支协作原则

### 当前分支
- 分支名: `chore/cursor-bootstrap`
- 协作方式: 提交后推送到远程

### 非 Force Push 原则

```bash
# ✅ 推荐：正常推送
git push origin-write chore/cursor-bootstrap

# ❌ 禁止：force push
git push -f origin-write chore/cursor-bootstrap

# ❌ 禁止：强制回滚远程历史
git reset --hard origin/chore/cursor-bootstrap
```

### 如果必须重置远程

```bash
# 1. 先在本地操作
git reset --hard <good-commit>

# 2. 告知协作者（孟安然）
# 3. 协商后由协作者执行 reset
```

---

## 验证清单

回滚后请验证：

```bash
# P0 必须通过
bash scripts/dev-entry.sh help          # 显示帮助
bash scripts/dev-entry.sh status        # 显示状态
bash scripts/dev-entry.sh check         # 执行检查

# P1 建议通过
bash scripts/verify-main-feature.sh     # 完整验证
```

---

## 相关文件

| 文件 | 用途 |
|------|------|
| `scripts/dev-entry.sh` | 主入口 |
| `scripts/lib-common.sh` | 依赖库 |
| `tools/dev-entry.ps1` | Windows 版 |
| `scripts/verify-main-feature.sh` | 验证脚本 |
| `docs/main-feature-regression-checklist.md` | 回归检查 |

---

*本文档由灵犀自动生成*
