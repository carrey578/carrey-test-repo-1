# 主功能验证指南

> 本文档说明如何验证主功能（dev-entry）的正确性

## 概述

**主功能**: `dev-entry.sh` (Linux) / `dev-entry.ps1` (Windows)  
**用途**: 统一任务入口脚本，提供开发环境检查、状态查看、报告生成等功能

## 验证目标

| 目标 | 说明 |
|------|------|
| 功能能执行 | 脚本可正常运行，不报错 |
| 关键输出存在 | 核心命令输出预期内容 |
| 基本结果正确 | 输出格式符合预期 |

## 快速验证

### Linux/macOS

```bash
# 方式1: 使用验证脚本（推荐）
bash scripts/verify-main-feature.sh

# 方式2: 快速模式
bash scripts/verify-main-feature.sh --quick

# 方式3: 直接测试
bash scripts/dev-entry.sh help
```

### Windows

```powershell
# 方式1: 使用验证脚本（推荐）
pwsh tools/verify-main-feature.ps1

# 方式2: 快速模式
pwsh tools/verify-main-feature.ps1 -Quick

# 方式3: 直接测试
pwsh tools/dev-entry.ps1 help
```

## 手动验证清单

### 1. 文件存在性检查

```bash
# Linux
ls -la scripts/dev-entry.sh
ls -la tools/dev-entry.ps1
```

预期结果：文件存在，有执行权限（Linux）

### 2. help 命令验证

```bash
# Linux
bash scripts/dev-entry.sh help

# Windows
pwsh tools/dev-entry.ps1 help
```

预期输出：
- 显示"开发任务统一入口"
- 列出所有可用命令
- 包含使用示例

### 3. 核心命令验证

| 命令 | 验证方法 | 预期结果 |
|------|----------|----------|
| help | `dev-entry help` | 显示帮助信息 |
| status | `dev-entry status` | 显示分支名 |
| check | `dev-entry check` | 显示检查结果 |
| docs | `dev-entry docs` | 显示文档索引 |
| all | `dev-entry all` | 运行所有检查 |

### 4. 完整功能验证（非快速模式）

```bash
# Linux: 运行完整验证
bash scripts/verify-main-feature.sh

# 输出示例
# === 主功能最小验证 ===
# 
# ℹ 检查 dev-entry.sh 文件...
# ✓ dev-entry.sh 存在
# ℹ 检查执行权限...
# ✓ 有执行权限
# ℹ 测试 help 命令...
# ✓ help 命令正常
# ℹ 测试 status 命令...
# ✓ status 命令正常
# ℹ 测试 preflight 命令...
# ✓ preflight 命令可执行
# ℹ 检查命令列表...
# ✓ 所有核心命令存在
# 
# === 验证结果 ===
# 通过: 6
# 失败: 0
# 跳过: 0
# 
# ✅ 验证通过 - 主功能可正常使用
```

## 故障排查

### 问题1: 权限拒绝

```bash
# 解决方案: 添加执行权限
chmod +x scripts/dev-entry.sh
```

### 问题2: 依赖缺失

检查以下依赖：
- bash (Linux)
- git
- common lib (lib-common.sh)

### 问题3: 输出异常

检查脚本工作目录是否正确，应在仓库根目录执行。

## 验证脚本选项

| 选项 | 说明 |
|------|------|
| (无) | 完整验证（5项检查） |
| `--quick` / `-Quick` | 快速验证（2项检查） |

## 相关文件

| 文件 | 说明 |
|------|------|
| `scripts/dev-entry.sh` | Linux 主入口脚本 |
| `tools/dev-entry.ps1` | Windows 主入口脚本 |
| `scripts/lib-common.sh` | 公共函数库 |
| `scripts/verify-main-feature.sh` | Linux 验证脚本 |
| `tools/verify-main-feature.ps1` | Windows 验证脚本 |

---

*本文档由灵犀自动生成*
