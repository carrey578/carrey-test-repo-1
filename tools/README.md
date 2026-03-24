# 工具目录 (tools/)

> 本目录包含本地端 (Windows) 自动化脚本

---

## 脚本索引

| 脚本 | 用途 | 核心功能 |
|------|------|----------|
| `check-dev-env-local.ps1` | 开发环境检查 | 检查分支、README、docs、Git 状态、Node、npm、Cursor |
| `dev-entry.ps1` | 统一任务入口 | 整合 check/status/docs/handoff/reports 命令 |
| `preflight-check.ps1` | 预提交检查 | Git 仓库、分支、工作区、目录结构、PowerShell 语法检查 |
| `generate-change-report.ps1` | 变更报告生成 | 自动汇总最近 commit、改动文件、diff 统计 |
| `generate-handoff.ps1` | Handoff 生成 | 生成标准交接文档模板 |

---

## 快速开始

```powershell
# 进入仓库目录
cd D:\dev\carrey-test-repo-1

# 运行开发环境检查
.\tools\check-dev-env-local.ps1

# 运行预提交检查
.\tools\preflight-check.ps1

# 生成变更报告
.\tools\generate-change-report.ps1

# 生成 Handoff 文档
.\tools\generate-handoff.ps1 -TaskId TASK-001

# 使用统一入口
.\tools\dev-entry.ps1 help
.\tools\dev-entry.ps1 status
```

---

## 详细说明

各脚本详细用法请参考：
- `docs/preflight-check.md` - 预提交检查说明
- `docs/dev-entry-guide.md` - 统一入口使用指南
- `docs/change-report-guide.md` - 变更报告生成指南

---

## 依赖

- PowerShell 5.0+
- git

---

## 注意事项

- 所有脚本需要在仓库根目录执行
- 脚本仅做只读检查，无破坏性操作
- 建议在提交前运行 preflight-check.ps1
- 如遇执行策略问题，运行：`Set-ExecutionPolicy -RemoteSigned -Scope Process`