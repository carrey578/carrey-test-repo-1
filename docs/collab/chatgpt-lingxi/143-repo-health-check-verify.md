# Repo Health Check 验证指南

## 概述

本文档提供各脚本的验证方法和验收标准。

## 验证方法

### 方式1：统一入口验证

```powershell
Set-Location "D:\dev\carrey-test-repo-1"
.\tools\repo-health-check.ps1
```

**预期输出：**
```
=== Repo Health Check ===
[PASS] check-dev-env-local
[PASS] preflight-check
[PASS] verify-dev-entry
=== Check Complete ===
```

**验收标准：**
- exit code = 0
- 三个子检查全部 PASS

### 方式2：分步验证

#### 1. 验证 dev-entry.ps1

```powershell
.\tools\dev-entry.ps1 help
.\tools\dev-entry.ps1 check
.\tools\dev-entry.ps1 status
```

**验收标准：**
- help 显示所有可用命令
- check 正常执行并输出检查结果
- status 显示仓库摘要

#### 2. 验证 preflight-check.ps1

```powershell
.\tools\preflight-check.ps1
```

**验收标准：**
- 输出预提交检查结果
- 检查 Git 仓库、分支状态
- 检查工作区干净度

#### 3. 验证 verify-dev-entry.ps1

```powershell
.\tools\verify-dev-entry.ps1
```

**验收标准：**
- 所有测试用例通过
- 输出验证结果汇总

### 方式3：PowerShell 环境检查

```powershell
# 设置执行策略（如需要）
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# 直接执行脚本
.\tools\check-dev-env-local.ps1
```

**验收标准：**
- Node.js 版本正常
- npm 可用
- Git 状态正常
- docs/shared 目录存在

## 本地验证结果（当前已通过）

| 检查项 | 结果 |
|--------|------|
| dev-entry.ps1 | ✅ PASS |
| preflight-check.ps1 | ✅ PASS |
| verify-dev-entry.ps1 | ✅ PASS |
| repo-health-check.ps1 | ✅ PASS (exit code 0) |
| Wrapper Summary | ✅ 3/3 PASS |

## 常见问题

### Q1: PowerShell 执行策略报错

**解决：**
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### Q2: 脚本找不到

**解决：**
确保已进入仓库目录：
```powershell
Set-Location "D:\dev\carrey-test-repo-1"
```

### Q3: exit code 非 0

**解决：**
检查具体哪个检查项失败，针对性修复后重新运行。

## 确认命令

```powershell
# 快速确认当前状态
git status
git branch --show-current

# 运行完整检查
.\tools\repo-health-check.ps1
```