# Repo Health Check 总结文档

## 文档概述

本文档记录当前仓库的 health check 链路，已通过本地验证，可作为协作控制台的统一参考。

## 当前验证通过的本地链路

| 脚本 | 功能 | 验证状态 |
|------|------|----------|
| `tools/dev-entry.ps1` | 统一任务入口 | ✅ PASS |
| `tools/preflight-check.ps1` | 预提交检查 | ✅ PASS |
| `tools/verify-dev-entry.ps1` | dev-entry 功能验证 | ✅ PASS |
| `tools/repo-health-check.ps1` | Wrapper 汇总入口 | ✅ PASS (exit code = 0) |

### Wrapper Summary 输出示例

```
[PASS] check-dev-env-local
[PASS] preflight-check
[PASS] verify-dev-entry
```

## 本地入口说明

### Windows PowerShell 环境

```powershell
# 进入仓库目录
Set-Location "D:\dev\carrey-test-repo-1"

# 方式1：通过 repo-health-check.ps1 统一入口
.\tools\repo-health-check.ps1

# 方式2：分步执行
.\tools\dev-entry.ps1 check        # 开发环境检查
.\tools\preflight-check.ps1       # 预提交检查
.\tools\verify-dev-entry.ps1      # 功能验证
```

## 推荐执行顺序

1. **先跑 `check-dev-env`** → 确认本地开发环境就绪
2. **再跑 `preflight-check`** → 确保代码符合提交规范
3. **可选跑 `verify-dev-entry`** → 验证入口脚本功能正常
4. **最后用 `repo-health-check.ps1`** → 一键汇总所有检查结果

## 各脚本职责

### dev-entry.ps1
- 统一任务入口，提供 check/status/docs/handoff/reports/all/preflight/report 等命令
- Windows 端主入口

### preflight-check.ps1
- 预提交检查
- 检查 Git 仓库、分支、工作区状态
- 验证代码规范

### verify-dev-entry.ps1
- dev-entry.ps1 功能验证脚本
- 确保入口脚本各命令正常工作

### repo-health-check.ps1
- Wrapper 汇总脚本
- 调用上述三个检查脚本，输出统一结果

## 阶段状态

| 阶段 | 状态 |
|------|------|
| 阶段 0-2 | ✅ 已完成并验证 |
| 阶段 3-4 | ✅ 统一说明文档已完成 |
| 阶段 5 | ✅ 已完成 |
| 阶段 6 | ⏸️ 暂缓，不影响阶段7 |
| 阶段 7 | 🔄 执行中 |

## 下一步

本阶段完成后，可根据需要：
- 补充更多检查项
- 扩展到服务器端链路
- 接入 CI/CD 自动化
