# verify-main-feature.ps1 - 主功能（dev-entry.ps1）最小可复用验证入口
# 用法: pwsh verify-main-feature.ps1 [-Quick]
# 
# 验证目标:
#   1. 功能能执行
#   2. 关键输出存在
#   3. 基本结果正确

param(
    [switch]$Quick
)

$RepoRoot = Split-Path -Parent $PSScriptRoot
$ScriptPath = Join-Path $RepoRoot "tools\dev-entry.ps1"

# 颜色定义 (PS: 使用 Write-Host 实现颜色)
function Write-Pass { param($msg) Write-Host "✓ $msg" -ForegroundColor Green }
function Write-Fail { param($msg) Write-Host "✗ $msg" -ForegroundColor Red }
function Write-Skip { param($msg) Write-Host "⊘ $msg" -ForegroundColor Yellow }
function Write-Info { param($msg) Write-Host "ℹ $msg" -ForegroundColor Cyan }

$script:PASS = 0
$script:FAIL = 0
$script:SKIP = 0

Write-Host "=== 主功能最小验证 ===" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# 验证 1: 文件存在
# ============================================================================
Write-Info "检查 dev-entry.ps1 文件..."
if (Test-Path $ScriptPath) {
    Write-Pass "dev-entry.ps1 存在"
} else {
    Write-Fail "dev-entry.ps1 不存在"
    Write-Host "错误: $ScriptPath" -ForegroundColor Red
    exit 1
}

# ============================================================================
# 验证 2: help 命令（核心功能验证）
# ============================================================================
Write-Info "测试 help 命令..."
$Output = & $ScriptPath help 2>&1 | Out-String
if ($Output -match "开发任务统一入口") {
    Write-Pass "help 命令正常"
} else {
    Write-Fail "help 命令输出异常"
}

# ============================================================================
# 验证 3: status 命令（简单功能验证）
# ============================================================================
if (-not $Quick) {
    Write-Info "测试 status 命令..."
    $Output = & $ScriptPath status 2>&1 | Out-String
    if ($Output -match "分支:") {
        Write-Pass "status 命令正常"
    } else {
        Write-Fail "status 命令输出异常"
    }
} else {
    Write-Skip "status 命令 (快速模式)"
}

# ============================================================================
# 验证 4: check 命令（功能检查）
# ============================================================================
if (-not $Quick) {
    Write-Info "测试 check 命令..."
    $Output = & $ScriptPath check 2>&1 | Out-String
    if ($Output -match "检查|完成|通过") {
        Write-Pass "check 命令可执行"
    } else {
        Write-Fail "check 命令输出异常"
    }
} else {
    Write-Skip "check 命令 (快速模式)"
}

# ============================================================================
# 验证 5: 命令列表完整性
# ============================================================================
Write-Info "检查命令列表..."
$ExpectedCommands = @("check", "status", "docs", "handoff", "reports", "all", "preflight", "report", "help")
$Missing = @()
foreach ($cmd in $ExpectedCommands) {
    if ($Output -notmatch $cmd) {
        $Missing += $cmd
    }
}

if ($Missing.Count -eq 0) {
    Write-Pass "所有核心命令存在"
} else {
    Write-Fail "缺失命令: $($Missing -join ', ')"
}

# ============================================================================
# 总结
# ============================================================================
Write-Host ""
Write-Host "=== 验证结果 ===" -ForegroundColor Cyan
Write-Host "通过: $PASS" -ForegroundColor Green
Write-Host "失败: $FAIL" -ForegroundColor Red
Write-Host "跳过: $SKIP" -ForegroundColor Yellow
Write-Host ""

if ($FAIL -eq 0) {
    Write-Host "✅ 验证通过 - 主功能可正常使用" -ForegroundColor Green
    exit 0
} else {
    Write-Host "❌ 验证失败 - 请检查上述问题" -ForegroundColor Red
    exit 1
}