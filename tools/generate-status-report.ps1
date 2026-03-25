# generate-status-report.ps1 - 自动化状态报告生成脚本 (Windows)
# 用法: pwsh tools/generate-status-report.ps1 [-Output <file>]

param(
    [string]$Output = "docs/collab/chatgpt-lingxi/auto-status-report.md"
)

$RepoRoot = Split-Path -Parent $PSScriptRoot
$OutputPath = Join-Path $RepoRoot $Output

function Write-Info {
    param($msg)
    Write-Host "ℹ $msg" -ForegroundColor Cyan
}

Write-Info "开始生成状态报告..."

# 确保目录存在
$outputDir = Split-Path -Parent $OutputPath
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

Push-Location $RepoRoot
try {
    # 获取基本信息
    $branch = git branch --show-current 2>$null
    if (-not $branch) { $branch = "N/A" }
    
    $commit = git rev-parse --short HEAD 2>$null
    if (-not $commit) { $commit = "N/A" }
    
    $commitFull = git rev-parse HEAD 2>$null
    if (-not $commitFull) { $commitFull = "N/A" }
    
    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    # 获取最近提交
    $recentCommits = git log --oneline -10 2>$null
    if (-not $recentCommits) { $recentCommits = "无提交记录" }
    $recentCommitsStr = $recentCommits -join "`n"
    
    # 获取最近改动文件
    $recentChanges = git diff --name-status HEAD~10..HEAD 2>$null
    if (-not $recentChanges) { $recentChanges = @("无改动") }
    $recentChangesStr = $recentChanges -join "`n"
    
    # 获取文档变动
    $docChanges = $recentChanges | Where-Object { $_ -match "^\s*[AM]\s+.*\.md$" }
    if (-not $docChanges) { $docChanges = @("无") }
    $docChangesStr = $docChanges -join "`n"
    
    # 获取脚本变动
    $scriptChanges = $recentChanges | Where-Object { $_ -match "^\s*[AM]\s+.*\.(sh|ps1)$" }
    if (-not $scriptChanges) { $scriptChanges = @("无") }
    $scriptChangesStr = $scriptChanges -join "`n"
    
    # 获取共享目录最新文档
    $sharedDocsPath = Join-Path $RepoRoot "docs\collab\chatgpt-lingxi"
    $sharedDocs = @()
    if (Test-Path $sharedDocsPath) {
        $sharedDocs = Get-ChildItem "$sharedDocsPath\*.md" -ErrorAction SilentlyContinue | 
            Sort-Object LastWriteTime -Descending | 
            Select-Object -First 10 | 
            ForEach-Object { $_.Name }
    }
    if (-not $sharedDocs) { $sharedDocs = @("无") }
    $sharedDocsStr = $sharedDocs -join "`n- "
    
    # 生成报告
    $content = @"
# 自动状态报告

> 生成时间: $date
> 分支: $branch
> 提交: $commit

---

## 一、仓库状态

| 项目 | 值 |
|------|-----|
| 分支 | $branch |
| 当前提交 | $commit |
| 完整 Commit ID | $commitFull |

---

## 二、最近提交 (10条)

$recentCommitsStr

---

## 三、最近改动文件 (10个)

$recentChangesStr

---

## 四、文档变动

$docChangesStr

---

## 五、脚本变动

$scriptChangesStr

---

## 六、共享目录最新文档

- $sharedDocsStr

---

## 七、相关脚本

| 脚本 | 说明 |
|------|------|
| \`tools/generate-status-report.ps1\` | 本报告生成脚本 |
| \`tools/dev-entry-v2.ps1\` | 统一开发入口 |
| \`tools/verify-main-feature.ps1\` | 功能验证脚本 |

---

## 八、建议操作

- [ ] Review 最近提交
- [ ] 检查新增/修改的文档
- [ ] 运行 verify 验证功能
- [ ] 准备 handoff（如需要）

---

*本报告由 generate-status-report.ps1 自动生成*
"@

    Set-Content -Path $OutputPath -Value $content -Encoding UTF8
    
    Write-Info "报告已生成: $OutputPath"
    
    Write-Host ""
    Write-Host "=== 报告摘要 ===" -ForegroundColor White
    Write-Host "分支: $branch" -ForegroundColor White
    Write-Host "提交: $commit" -ForegroundColor White
    Write-Host "输出: $OutputPath" -ForegroundColor White

} finally {
    Pop-Location
}
