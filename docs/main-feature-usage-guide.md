# 主功能使用说明

> 面向最终用户的操作指南

## 概述

### 解决什么问题

`dev-entry` 是一个**统一任务入口脚本**，旨在解决以下问题：

| 问题 | 解决方案 |
|------|----------|
| 多个脚本分散 | 统一入口，一个命令搞定 |
| 忘记命令用法 | `help` 命令显示所有可用命令 |
| 环境检查繁琐 | `check` 命令一键检查 |
| 不知道状态 | `status` 命令查看仓库状态 |

---

## 快速开始

### 入口在哪里

```bash
# Linux/macOS
bash scripts/dev-entry.sh <command>

# Windows
pwsh tools/dev-entry.ps1 <command>
```

### 常用命令

| 命令 | 说明 | 示例 |
|------|------|------|
| help | 显示帮助 | `bash scripts/dev-entry.sh help` |
| status | 查看仓库状态 | `bash scripts/dev-entry.sh status` |
| check | 开发环境检查 | `bash scripts/dev-entry.sh check` |
| docs | 查看文档索引 | `bash scripts/dev-entry.sh docs` |
| all | 运行所有检查 | `bash scripts/dev-entry.sh all` |
| preflight | 预提交检查 | `bash scripts/dev-entry.sh preflight` |
| report | 生成变更报告 | `bash scripts/dev-entry.sh report` |

---

## 输入输出

### 输入

- **参数**: `-v/--verbose` (详细模式), `-q/--quiet` (安静模式)
- **命令**: 如 `status`, `check`, `help` 等

### 输出

- **正常输出**: 彩色格式化文本
- **错误输出**: 红色错误信息
- **报告文件**: `docs/collab/chatgpt-lingxi/` 目录下

---

## 使用示例

### 查看帮助

```bash
$ bash scripts/dev-entry.sh help

=== 开发任务统一入口 ===

用法: bash dev-entry.sh [options] <command>

可用命令:
  check    - 运行开发环境检查
  status   - 显示仓库状态摘要
  docs     - 查看文档索引
  ...
```

### 查看仓库状态

```bash
$ bash scripts/dev-entry.sh status

分支: chore/cursor-bootstrap
提交: abc1234
状态: 无待提交更改
```

### 运行所有检查

```bash
$ bash scripts/dev-entry.sh all
✓ 开发环境检查通过
✓ 预提交检查通过
✓ 仓库状态正常
```

### 安静模式

```bash
$ bash scripts/dev-entry.sh -q status
chore/cursor-bootstrap | abc1234 | clean
```

### 详细模式

```bash
$ bash scripts/dev-entry.sh -v status
[DEBUG] Loading lib-common.sh...
[DEBUG] Checking git status...
分支: chore/cursor-bootstrap
...
```

---

## 常见问题

### Q1: 提示 "Permission denied"

```bash
# 添加执行权限
chmod +x scripts/dev-entry.sh
```

### Q2: 提示 "lib-common.sh not found"

```bash
# 确保在仓库根目录执行
cd /path/to/repo
bash scripts/dev-entry.sh help
```

### Q3: 不知道有哪些命令

```bash
# 查看帮助
bash scripts/dev-entry.sh help
```

### Q4: report 命令生成的文件在哪里

```
docs/collab/chatgpt-lingxi/ 目录下
```

### Q5: 命令执行失败怎么办

参考文档：`docs/main-feature-rollback-recovery-guide.md`

---

## 相关文档

| 文档 | 说明 |
|------|------|
| `docs/main-feature-dev-guide.md` | 开发维护说明 |
| `docs/main-feature-verify-guide.md` | 验证指南 |
| `docs/main-feature-test-checklist.md` | 测试清单 |
| `docs/main-feature-regression-checklist.md` | 回归检查 |
| `docs/main-feature-rollback-recovery-guide.md` | 回滚恢复 |

---

*本文档由灵犀自动生成*
