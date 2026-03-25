# generate-change-summary-v2.ps1 - 自动化 Change Summary 生成脚本 v2 (Windows)
# 用法: pwsh tools/generate-change-summary-v2.ps1 [-Count <n>] [-Output <file>]

param(
    [int]$Count = 5,
    [string]$Output = "",
    [switch]$Verbose
)

$RepoRoot = Split-Path -Parent $PSScriptRoot

function Write-Info {
    param($msg)
    Write-Host "ℹ $msg" -ForegroundColor Cyan
}

Write-Info "开始生成 Change Summary v2..."

Push-Location $RepoRoot
try {
    # 获取基本信息
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $branch = git branch --show-current 2>$null
    $commit = git rev-parse --short HEAD 2>$null
    
    if (-not $branch) { $branch = "N/A" }
    if (-not $commit) { $commit = "N/A" }
    
    # 默认输出文件
    if ([string]::IsNullOrEmpty($Output)) {
        $Output = "docs/collab/chatgpt-lingxi/change-summary-$timestamp.md"
    }
    $outputPath = Join-Path $RepoRoot $Output
    
    # 确保目录存在
    $outputDir = Split-Path -Parent $outputPath
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }
    
    # 获取最近 commits
    $commits = git log --oneline -$Count 2>$null
    if (-not $commits) { $commits = @("无") }
    $commitsStr = $commits -join "`n"
    
    # 获取改动文件
    $changes = git diff --name-status HEAD~$Count..HEAD 2>$null
    if (-not $changes) { $changes = @("无") }
    
    # 分类改动
    $addedFiles = $changes | Where-Object { $_ -match "^\s*A\s+" }
    $modifiedFiles = $changes | Where-Object { $_ -match "^\s*M\s+" }
    $deletedFiles = $changes | Where-Object { $_ -match "^\s*D\s+" }
    
    if (-not $addedFiles) { $addedFiles = @("无") }
    if (-not $modifiedFiles) { $modifiedFiles = @("无") }
    if (-not $deletedFiles) { $deletedFiles = @("无") }
    
    $addedStr = ($addedFiles | ForEach-Object { "  - " + ($_ -replace '^\s*A\s+', '') }) -join "`n"
    $modifiedStr = ($modifiedFiles | ForEach-Object { "  - " + ($_ -replace '^\s*M\s+', '') }) -join "`n"
    $deletedStr = ($deletedFiles | ForEach-Object { "  - " + ($_ -replace '^\s*D\s+', '') }) -join "`n"
    
    # 统计
    $docCount = ($changes | Where-Object { $_ -match '\.md$' }).Count
    $scriptCount = ($changes | Where-Object { $_ -match '\.(sh|ps1)$' }).Count
    $configCount = ($changes | Where-Object { $_ -match '\.(json|yaml|yml|toml)$' }).Count
    
    if (-not $docCount) { $docCount = 0 }
    if (-not $scriptCount) { $scriptCount = 0 }
    if (-not $configCount) { $configCount = 0 }
    
    $addedCount = $addedFiles.Count
    $modifiedCount = $modifiedFiles.Count
    $deletedCount = $deletedFiles.Count
    
    if (-not $addedCount) { $addedCount = 0 }
    if (-not $modifiedCount) { $modifiedCount = 0 }
    if (-not $deletedCount) { $deletedCount = 0 }
    
    # 生成 Change Summary
    $content = @"
# Change Summary - 变更摘要

> 生成时间: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
> 分支: $branch
> 范围: 最近 $Count 个提交

---

## 一、变更概览

| 项目 | 数量 |
|------|------|
| 提交数 | $Count |
| 新增文件 | $addedCount |
| 修改文件 | $modifiedCount |
| 删除文件 | $deletedCount |
| 文档变动 | $docCount |
| 脚本变动 | $scriptCount |
| 配置变动 | $configCount |

---

## 二、最近提交

$commitsStr

---

## 三、改动详情

### 3.1 新增文件

$addedStr

### 3.2 修改文件

$modifiedStr

### 3.3 删除文件

$deletedStr

---

## 四、按类型统计

| 类型 | 数量 |
|------|------|
| 文档 (.md) | $docCount |
| 脚本 (.sh/.ps1) | $scriptCount |
| 配置 (.json/.yaml) | $configCount |

---

## 五、Review 建议

> 请 review 以下重点

- [ ] 检查新增文档内容是否完整
- [ ] 检查新增脚本是否有执行权限
- [ ] 检查配置变更是否影响现有功能
- [ ] 验证脚本可正常执行

---

## 六、验证命令

\`\`\`powershell
# 快速验证
pwsh tools/verify-main-feature.ps1 -Quick

# 状态报告
pwsh tools/generate-status-report.ps1

# Handoff
pwsh tools/generate-handoff-v2.ps1
\`\`\`

---

*本 Change Summary 由 generate-change-summary-v2.ps1 自动生成*
"@

    Set-Content -Path $outputPath -Value $content -Encoding UTF8
    
    Write-Info "Change Summary 已生成: $outputPath"
    
    Write-Host ""
    Write-Host "=== Change Summary v2 生成完成 ===" -ForegroundColor Green
    Write-Host "分支: $branch" -ForegroundColor White
    Write-Host "提交数: $Count" -ForegroundColor White
    Write-Host "新增: $addedCount 个" -ForegroundColor White
    Write-Host "修改: $modifiedCount 个" -ForegroundColor White
    Write-Host "输出: $outputPath" -ForegroundColor White

} finally {
    Pop-Location
}
