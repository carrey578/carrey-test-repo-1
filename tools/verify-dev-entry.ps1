# verify-dev-entry.ps1 - dev-entry.ps1 功能验证脚本 (Windows 端)
# 用法: .\verify-dev-entry.ps1

$ErrorActionPreference = "Continue"
$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$PowerShellExe = Join-Path $env:WINDIR "System32\WindowsPowerShell\v1.0\powershell.exe"

$pass = 0
$fail = 0

function Invoke-DevEntry($command) {
    & $PowerShellExe -NoProfile -ExecutionPolicy Bypass -File "$RepoRoot/tools/dev-entry.ps1" $command 2>$null | Out-String
}

function Test-Case($name, $script) {
    Write-Host "测试: $name" -ForegroundColor Cyan
    try {
        $result = & $script 2>$null
        if ([bool]$result) {
            Write-Host "  ✓ 通过" -ForegroundColor Green
            $script:pass++
        } else {
            Write-Host "  ✗ 失败" -ForegroundColor Red
            $script:fail++
        }
    } catch {
        Write-Host "  ✗ 失败: $_" -ForegroundColor Red
        $script:fail++
    }
}

Write-Host "=== dev-entry.ps1 功能验证 ===" -ForegroundColor Cyan
Write-Host ""

# 测试 1: help 命令显示新命令
Test-Case "help 命令包含 'all' 命令" {
    $output = Invoke-DevEntry "help"
    $output -match "all.*运行所有检查"
}

# 测试 2: help 命令显示 'preflight'
Test-Case "help 命令包含 'preflight' 命令" {
    $output = Invoke-DevEntry "help"
    $output -match "preflight"
}

# 测试 3: help 命令显示 'report'
Test-Case "help 命令包含 'report' 命令" {
    $output = Invoke-DevEntry "help"
    $output -match "report.*生成变更报告"
}

# 测试 4: status 命令仍正常工作
Test-Case "status 命令兼容" {
    $output = Invoke-DevEntry "status"
    $output -match "分支:"
}

# 测试 5: check 命令仍正常工作
Test-Case "check 命令兼容" {
    $output = Invoke-DevEntry "check"
    $output -match "开发环境检查|Check"
}

# 总结
Write-Host ""
Write-Host "=== 验证结果 ===" -ForegroundColor Cyan
Write-Host "通过: $pass" -ForegroundColor Green
Write-Host "失败: $fail" -ForegroundColor Red
Write-Host ""

if ($fail -eq 0) {
    Write-Host "验证全部通过" -ForegroundColor Green
    exit 0
} else {
    Write-Host "验证有失败项" -ForegroundColor Red
    exit 1
}
