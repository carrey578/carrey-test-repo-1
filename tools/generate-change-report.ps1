# generate-change-report.ps1 - 变更报告自动生成脚本 (Windows 端)
# 用法: .\generate-change-report.ps1 [-Output FILE]

param(
    [string]$Output = "docs\collab\chatgpt-lingxi\auto-change-report.md"
)

$ErrorActionPreference = "Continue"
$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

Write-Host "=== 变更报告生成 ===" -ForegroundColor Cyan
Write-Host ""

# 1. 获取最近 commit 信息
Write-Host "获取最近 commit 信息..." -ForegroundColor Cyan
$commitHash = git log -1 --format="%H"
$commitShort = git log -1 --format="%h"
$commitSubject = git log -1 --format="%s"
$commitAuthor = git log -1 --format="%an"
$commitEmail = git log -1 --format="%ae"
$commitDate = git log -1 --format="%ci"
$branch = git branch --show-current

# 2. 获取改动文件
Write-Host "获取改动文件..." -ForegroundColor Cyan
$changedFiles = git diff --name-only HEAD~1 HEAD 2>$null
if (-not $changedFiles) {
    $changedFiles = git diff --name-only HEAD^ HEAD 2>$null
}
if (-not $changedFiles) {
    $changedFiles = git diff --name-only
    $diffType = "未提交更改"
} else {
    $diffType = "最近一次提交"
}

# 3. 统计
$addedCount = ($changedFiles | Where-Object { $_ -match "^A " }).Count
$modifiedCount = ($changedFiles | Where-Object { $_ -match "^M " }).Count
$deletedCount = ($changedFiles | Where-Object { $_ -match "^D " }).Count
$totalCount = ($changedFiles -split "`n" | Where-Object { $_ }).Count

# 4. 生成报告
Write-Host "生成报告..." -ForegroundColor Cyan

$reportContent = @"
# 变更报告 - $(Get-Date -Format "yyyy-MM-dd")

> 自动生成时间: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
> 仓库: carrey-test-repo-1
> 分支: $branch

---

## 一、最近 Commit 信息

| 项目 | 值 |
|------|-----|
| Commit Hash | `$commitShort` (`$commitHash`) |
| 提交标题 | $commitSubject |
| 作者 | $commitAuthor |
| 邮箱 | $commitEmail |
| 提交时间 | $commitDate |
| 所在分支 | $branch |

---

## 二、改动文件列表

$diffType

```
$changedFiles
```

---

## 三、改动类型统计

| 类型 | 数量 |
|------|------|
| 新增 (Added) | $addedCount |
| 修改 (Modified) | $modifiedCount |
| 删除 (Deleted) | $deletedCount |
| 总计 | $totalCount |

---

## 四、建议 Review 点

基于改动内容，建议关注：

1. **脚本改动**：检查语法正确性
2. **文档改动**：检查内容完整性
3. **配置改动**：确认符合预期

---

## 五、Diff 摘要

``````bash
$(git diff --stat HEAD~1 HEAD 2>$null)
``````

---

## 六、验证建议

### 本地验证
```powershell
# 运行预提交检查
.\tools\preflight-check.ps1
```

### 服务器验证
```bash
# 运行开发环境检查
bash scripts/check-dev-env-server.sh
```

---

## 七、Handoff 信息

| 项目 | 值 |
|------|-----|
| 生成时间 | $(Get-Date -Format "yyyy-MM-dd HH:mm:ss") |
| 生成者 | 自动脚本 |
| 报告文件 | $Output |
| 下一步 | 人工 review 后可合并或继续开发 |

---

*本报告由 generate-change-report.ps1 自动生成*
"@

# 写入文件
$reportContent | Out-File -FilePath "$RepoRoot\$Output" -Encoding utf8

Write-Host ""
Write-Host "报告已生成: $Output" -ForegroundColor Green
Write-Host ""

# 显示摘要
Write-Host "=== 报告摘要 ===" -ForegroundColor Green
Write-Host "Commit: $commitShort - $commitSubject"
Write-Host "分支: $branch"
Write-Host "改动文件: $totalCount 个"
Write-Host "输出: $Output"
Write-Host ""