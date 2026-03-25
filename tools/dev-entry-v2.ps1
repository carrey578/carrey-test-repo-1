# dev-entry-v2.ps1 - 统一开发入口脚本 v2 (Windows)
# 用法: pwsh tools/dev-entry-v2.ps1 [-Verbose] [-Quiet] <command>

param(
    [switch]$Verbose,
    [switch]$Quiet,
    [string]$Command = ""
)

$RepoRoot = Split-Path -Parent $PSScriptRoot
$ScriptDir = $PSScriptRoot

# 颜色函数
function Write-Info { if (-not $Quiet) { Write-Host "ℹ $args" -ForegroundColor Cyan } }
function Write-Success { if (-not $Quiet) { Write-Host "✓ $args" -ForegroundColor Green } }
function Write-Error { Write-Host "✗ $args" -ForegroundColor Red }

# 显示帮助
function Show-Help {
    Write-Host "=== 开发任务统一入口 v2 ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "用法: pwsh dev-entry-v2.ps1 [options] <command>" -ForegroundColor White
    Write-Host ""
    Write-Host "全局选项:" -ForegroundColor Green
    Write-Host "  -Verbose   详细输出模式"
    Write-Host "  -Quiet     安静模式"
    Write-Host ""
    Write-Host "开发检查:" -ForegroundColor Green
    Write-Host "  check      - 运行开发环境检查"
    Write-Host "  preflight  - 运行预提交检查"
    Write-Host ""
    Write-Host "验证:" -ForegroundColor Green
    Write-Host "  verify     - 运行功能验证"
    Write-Host "  verify-all - 运行完整验证"
    Write-Host ""
    Write-Host "状态报告:" -ForegroundColor Green
    Write-Host "  status     - 显示仓库状态"
    Write-Host "  report     - 生成状态报告"
    Write-Host "  summary    - 生成变更摘要"
    Write-Host ""
    Write-Host "文档:" -ForegroundColor Green
    Write-Host "  docs       - 查看文档索引"
    Write-Host "  handoff    - 生成 handoff"
    Write-Host ""
    Write-Host "批量:" -ForegroundColor Green
    Write-Host "  all        - 运行所有检查"
    Write-Host "  full       - 完整检查+验证+报告"
    Write-Host ""
    Write-Host "示例:" -ForegroundColor Yellow
    Write-Host "  pwsh dev-entry-v2.ps1 check"
    Write-Host "  pwsh dev-entry-v2.ps1 verify"
    Write-Host "  pwsh dev-entry-v2.ps1 status"
}

# 命令: check
function Invoke-Check {
    Write-Info "运行开发环境检查..."
    if (Test-Path "$ScriptDir\check-dev-env-local.ps1") {
        & "$ScriptDir\check-dev-env-local.ps1"
    } else {
        Write-Error "check-dev-env-local.ps1 不存在"
    }
}

# 命令: preflight
function Invoke-Preflight {
    Write-Info "运行预提交检查..."
    if (Test-Path "$ScriptDir\preflight-check.ps1") {
        & "$ScriptDir\preflight-check.ps1"
    } else {
        Write-Error "preflight-check.ps1 不存在"
    }
}

# 命令: env
function Invoke-Env {
    Write-Host "=== 环境信息 ===" -ForegroundColor White
    Write-Host "用户: $env:USERNAME"
    Write-Host "计算机: $env:COMPUTERNAME"
    Write-Host "目录: $RepoRoot"
}

# 命令: verify
function Invoke-Verify {
    Write-Info "运行功能验证..."
    if (Test-Path "$ScriptDir\verify-main-feature.ps1") {
        & "$ScriptDir\verify-main-feature.ps1" -Quick
    } else {
        Write-Error "verify-main-feature.ps1 不存在"
    }
}

# 命令: verify-all
function Invoke-VerifyAll {
    Write-Info "运行完整验证..."
    if (Test-Path "$ScriptDir\verify-main-feature.ps1") {
        & "$ScriptDir\verify-main-feature.ps1"
    } else {
        Write-Error "verify-main-feature.ps1 不存在"
    }
}

# 命令: status
function Invoke-Status {
    Write-Host "=== 仓库状态 ===" -ForegroundColor White
    Push-Location $RepoRoot
    try {
        $branch = git branch --show-current 2>$null
        $commit = git rev-parse --short HEAD 2>$null
        $changes = (git status --porcelain 2>$null | Measure-Object).Count
        
        Write-Host "分支: $branch"
        Write-Host "提交: $commit"
        Write-Host "状态: $changes 个更改"
    } finally {
        Pop-Location
    }
}

# 命令: report
function Invoke-Report {
    Write-Info "生成状态报告..."
    
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $reportFile = "docs/collab/chatgpt-lingxi/auto-status-report-$timestamp.md"
    
    # 确保目录存在
    $reportDir = Join-Path $RepoRoot "docs\collab\chatgpt-lingxi"
    if (-not (Test-Path $reportDir)) {
        New-Item -ItemType Directory -Path $reportDir -Force | Out-Null
    }
    
    Push-Location $RepoRoot
    try {
        $branch = git branch --show-current 2>$null
        $commit = git rev-parse --short HEAD 2>$null
        $log = git log --oneline -5 2>$null
        
        $content = @"
# 自动状态报告

生成时间: $(Get-Date)

## 仓库状态

- 分支: $branch
- 提交: $commit

## 最近提交

$log

"@
        Set-Content -Path (Join-Path $RepoRoot $reportFile) -Value $content -Encoding UTF8
        Write-Success "报告已生成: $reportFile"
    } finally {
        Pop-Location
    }
}

# 命令: summary
function Invoke-Summary {
    Write-Host "=== 变更摘要 ===" -ForegroundColor White
    Push-Location $RepoRoot
    try {
        Write-Host "最近5个提交:" -ForegroundColor White
        git log --oneline -5 2>$null
        Write-Host ""
        Write-Host "改动文件:" -ForegroundColor White
        git diff --name-status HEAD~3..HEAD 2>$null
    } finally {
        Pop-Location
    }
}

# 命令: docs
function Invoke-Docs {
    Write-Host "=== 文档目录 ===" -ForegroundColor White
    $docsPath = Join-Path $RepoRoot "docs"
    if (Test-Path $docsPath) {
        Get-ChildItem "$docsPath\*.md" -ErrorAction SilentlyContinue | Select-Object -First 10 | ForEach-Object { Write-Host $_.Name }
    }
}

# 命令: handoff
function Invoke-Handoff {
    Write-Info "生成 handoff..."
    if (Test-Path "$ScriptDir\generate-handoff.ps1") {
        & "$ScriptDir\generate-handoff.ps1"
    } else {
        Write-Error "generate-handoff.ps1 不存在"
    }
}

# 命令: all
function Invoke-All {
    Write-Info "运行所有检查..."
    Invoke-Check
    Invoke-Preflight
    Invoke-Status
    Write-Success "所有检查完成"
}

# 命令: full
function Invoke-Full {
    Write-Info "运行完整检查..."
    Invoke-Check
    Invoke-Preflight
    Invoke-Verify
    Invoke-Status
    Invoke-Report
    Write-Success "完整检查完成"
}

# 主逻辑
if ([string]::IsNullOrEmpty($Command)) {
    Show-Help
    exit 0
}

switch ($Command.ToLower()) {
    "check" { Invoke-Check }
    "preflight" { Invoke-Preflight }
    "env" { Invoke-Env }
    "verify" { Invoke-Verify }
    "verify-all" { Invoke-VerifyAll }
    "status" { Invoke-Status }
    "report" { Invoke-Report }
    "summary" { Invoke-Summary }
    "docs" { Invoke-Docs }
    "handoff" { Invoke-Handoff }
    "all" { Invoke-All }
    "full" { Invoke-Full }
    "help" { Show-Help }
    default { 
        Write-Error "未知命令: $Command"
        Show-Help
        exit 1
    }
}
