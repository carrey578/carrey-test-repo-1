# generate-handoff.ps1 - Handoff 文档生成脚本 (Windows 端)
# 用法: .\generate-handoff.ps1 [-TaskId STRING]

param(
    [string]$TaskId = ""
)

$ErrorActionPreference = "Continue"
$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

# 生成时间戳
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
if (-not $TaskId) {
    $TaskId = "TASK-$timestamp"
}

$OutputDir = "$RepoRoot\docs\collab\chatgpt-lingxi"
$OutputFile = "$OutputDir\handoff-$TaskId.md"

Write-Host "=== Handoff 文档生成 ===" -ForegroundColor Cyan

# 获取最近 commit 信息
$commitHash = git log -1 --format="%h" 2>$null
$commitSubject = git log -1 --format="%s" 2>$null
$branch = git branch --show-current 2>$null

# 获取改动文件
$changedFiles = git diff --name-only HEAD~1 HEAD 2>$null | Select-Object -First 10
if (-not $changedFiles) {
    $changedFiles = "无"
}

Write-Host "生成 Handoff 文档..." -ForegroundColor Cyan

$content = @"
# Handoff 文档 - $TaskId

> 生成时间: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
> 分支: $branch

---

## 一、任务信息

| 项目 | 值 |
|------|-----|
| 任务 ID | $TaskId |
| 生成时间 | $(Get-Date -Format "yyyy-MM-dd HH:mm:ss") |
| 生成者 | 灵犀 (自动脚本) |
| 当前分支 | $branch |

---

## 二、最近 Commit

| 项目 | 值 |
|------|-----|
| Commit | $commitHash |
| 标题 | $commitSubject |

---

## 三、改动文件

```
$changedFiles
```

---

## 四、工作摘要

> 请在此处填写本次任务的工作摘要

- [ ] 任务目标：???
- [ ] 完成情况：???
- [ ] 遗留问题：???
- [ ] 下一步建议：???

---

## 五、交接说明

### 已完成
-

### 待跟进
-

### 注意事项
-

---

## 六、 Review 建议

| 检查项 | 状态 |
|--------|------|
| 代码语法 | ⬜ 待检查 |
| 文档完整性 | ⬜ 待检查 |
| 脚本可执行性 | ⬜ 待检查 |
| 符合任务目标 | ⬜ 待检查 |

---

## 七、验证命令

```powershell
# 本地端验证
.\tools\preflight-check.ps1
.\tools\check-dev-env-local.ps1
```

```bash
# 服务器端验证
bash scripts/preflight-check.sh
bash scripts/check-dev-env-server.sh
```

---

## 八、联系方式

如有问题，请通过以下方式联系：

- Feishu: 孟安然
- GitHub Issue: (如适用)

---

*本 Handoff 由 generate-handoff.ps1 自动生成*
"@

# 写入文件
$content | Out-File -FilePath $OutputFile -Encoding utf8

Write-Host ""
Write-Host "Handoff 文档已生成: $OutputFile" -ForegroundColor Green
Write-Host ""
Write-Host "=== 生成完成 ===" -ForegroundColor Green
Write-Host "任务 ID: $TaskId"
Write-Host "输出文件: $OutputFile"
Write-Host ""