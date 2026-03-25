# generate-handoff-v2.ps1 - 自动化 Handoff 生成脚本 v2 (Windows)
# 用法: pwsh tools/generate-handoff-v2.ps1 [-Task <name>] [-Output <file>]

param(
    [string]$Task = "",
    [string]$Output = "",
    [switch]$Verbose
)

$RepoRoot = Split-Path -Parent $PSScriptRoot

function Write-Info {
    param($msg)
    if ($Verbose) { Write-Host "ℹ $msg" -ForegroundColor Cyan }
    else { Write-Host "ℹ $msg" -ForegroundColor Cyan }
}

Write-Info "开始生成 Handoff v2..."

Push-Location $RepoRoot
try {
    # 获取基本信息
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $branch = git branch --show-current 2>$null
    $commit = git rev-parse --short HEAD 2>$null
    
    if (-not $branch) { $branch = "N/A" }
    if (-not $commit) { $commit = "N/A" }
    
    # 默认任务名
    if ([string]::IsNullOrEmpty($Task)) {
        $Task = "任务-$timestamp"
    }
    
    # 默认输出文件
    if ([string]::IsNullOrEmpty($Output)) {
        $Output = "docs/collab/chatgpt-lingxi/handoff-$timestamp.md"
    }
    $outputPath = Join-Path $RepoRoot $Output
    
    # 确保目录存在
    $outputDir = Split-Path -Parent $outputPath
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }
    
    # 获取最近 commits
    $recentCommits = git log --oneline -5 2>$null
    if (-not $recentCommits) { $recentCommits = @("无") }
    $recentCommitsStr = $recentCommits -join "`n"
    
    # 获取改动文件
    $changedFiles = git diff --name-status HEAD~5..HEAD 2>$null
    if (-not $changedFiles) { $changedFiles = @("无") }
    $changedFilesStr = $changedFiles -join "`n"
    
    # 获取新增文档
    $docChanges = $changedFiles | Where-Object { $_ -match "^\s*A\s+.*\.md$" }
    if (-not $docChanges) { $docChanges = @("无") }
    $docChangesStr = $docChanges -join "`n"
    
    # 获取新增脚本
    $scriptChanges = $changedFiles | Where-Object { $_ -match "^\s*A\s+.*\.(sh|ps1)$" }
    if (-not $scriptChanges) { $scriptChanges = @("无") }
    $scriptChangesStr = $scriptChanges -join "`n"
    
    # 尝试运行 verify
    $verifyResult = "未运行"
    $verifyScript = Join-Path $PSScriptRoot "verify-main-feature.ps1"
    if (Test-Path $verifyScript) {
        Write-Info "运行 verify..."
        try {
            $verifyOutput = & $verifyScript -Quick 2>&1 | Out-String
            if ($verifyOutput -match "验证通过") { $verifyResult = "✅ 通过" }
            elseif ($verifyOutput -match "验证失败") { $verifyResult = "❌ 失败" }
            else { $verifyResult = "⚠️ 部分通过" }
        } catch {
            $verifyResult = "⚠️ 运行异常"
        }
    }
    
    # 获取共享文档数量
    $sharedDocPath = Join-Path $RepoRoot "docs\collab\chatgpt-lingxi"
    $sharedDocCount = 0
    if (Test-Path $sharedDocPath) {
        $sharedDocCount = (Get-ChildItem "$sharedDocPath\*.md" -ErrorAction SilentlyContinue | Measure-Object).Count
    }
    
    # 生成 Handoff
    $content = @"
# Handoff 文档 - $Task

> 生成时间: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
> 分支: $branch
> 提交: $commit

---

## 一、本轮目标

> 请在此处填写本次任务的目标

<!-- 人工补充区 -->
- [ ] 目标1: 
- [ ] 目标2: 
- [ ] 目标3: 

---

## 二、最近提交 (5条)

$recentCommitsStr

---

## 三、改动文件

### 3.1 所有改动

$changedFilesStr

### 3.2 新增文档

$docChangesStr

### 3.3 新增脚本

$scriptChangesStr

---

## 四、Verify 结果

| 项目 | 结果 |
|------|------|
| 功能验证 | $verifyResult |

> 如需重新验证，运行: \`pwsh tools/verify-main-feature.ps1 -Quick\`

---

## 五、未完成事项

> 请在此处填写未完成的事项

<!-- 人工补充区 -->
- [ ] 

---

## 六、风险

> 请在此处填写潜在风险

<!-- 人工补充区 -->
- 

---

## 七、下一步建议

### 建议1 (P0)
- 内容: 
- 理由: 

### 建议2 (P1)
- 内容: 
- 理由: 

---

## 八、人工补充区

> 以下区域供人工补充关键信息

### 8.1 补充说明

<!-- 在此处添加补充说明 -->

### 8.2 注意事项

<!-- 在此处添加注意事项 -->

### 8.3 关联文档

- 

---

## 九、验证命令

\`\`\`powershell
# 快速验证
pwsh tools/verify-main-feature.ps1 -Quick

# 完整验证
pwsh tools/verify-main-feature.ps1

# 状态报告
pwsh tools/generate-status-report.ps1
\`\`\`

---

## 十、统计信息

| 项目 | 值 |
|------|-----|
| 分支 | $branch |
| 提交 | $commit |
| 共享文档数 | $sharedDocCount |
| 改动文件数 | $($changedFiles.Count) |

---

*本 Handoff 由 generate-handoff-v2.ps1 自动生成*
"@

    Set-Content -Path $outputPath -Value $content -Encoding UTF8
    
    Write-Info "Handoff 已生成: $outputPath"
    
    Write-Host ""
    Write-Host "=== Handoff v2 生成完成 ===" -ForegroundColor Green
    Write-Host "任务名: $Task" -ForegroundColor White
    Write-Host "分支: $branch" -ForegroundColor White
    Write-Host "提交: $commit" -ForegroundColor White
    Write-Host "Verify: $verifyResult" -ForegroundColor White
    Write-Host "输出: $outputPath" -ForegroundColor White

} finally {
    Pop-Location
}
