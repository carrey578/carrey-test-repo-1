<#
.SYNOPSIS
    Repo Health Check Wrapper - 一键检查开发环境状态

.DESCRIPTION
    调用 check-dev-env-local、preflight-check、verify-dev-entry 三个脚本，
    输出统一的检查结果摘要。

.PARAMETER Help
    显示本帮助信息

.EXAMPLE
    .\tools\repo-health-check.ps1
    执行完整检查

.EXAMPLE
    .\tools\repo-health-check.ps1 -Help
    显示帮助信息
#>

param(
    [switch]$Help
)

# 显示帮助信息
if ($Help) {
    Get-Help $MyInvocation.MyCommand.Path
    exit 0
}

$ErrorActionPreference = "Continue"
$PowerShellExe = Join-Path $env:WINDIR "System32\WindowsPowerShell\v1.0\powershell.exe"

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  Repo Health Check  开始检查..." -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

$scriptResults = @()

function Invoke-CheckScript {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    Write-Host "  → 正在检查: $Name ..." -ForegroundColor Yellow -NoNewline

    if (-not (Test-Path $Path)) {
        $script:scriptResults += [pscustomobject]@{
            Name = $Name
            ExitCode = 1
        }
        Write-Host " [未找到]" -ForegroundColor Red
        Write-Host "  └─ 提示: 脚本路径 $Path 不存在" -ForegroundColor Gray
        return
    }

    # Use a child PowerShell process so wrapper exit codes stay reliable.
    & $PowerShellExe -NoProfile -ExecutionPolicy Bypass -File $Path
    $exitCode = if ($null -ne $LASTEXITCODE) { [int]$LASTEXITCODE } else { 0 }

    $script:scriptResults += [pscustomobject]@{
        Name = $Name
        ExitCode = $exitCode
    }

    if ($exitCode -eq 0) {
        Write-Host " [通过]" -ForegroundColor Green
    } else {
        Write-Host " [失败] (exit code: $exitCode)" -ForegroundColor Red
        Write-Host "  └─ 提示: 请检查脚本输出以了解详情" -ForegroundColor Gray
    }
}

Invoke-CheckScript -Name "check-dev-env-local" -Path (Join-Path $PSScriptRoot "check-dev-env-local.ps1")
Invoke-CheckScript -Name "preflight-check"      -Path (Join-Path $PSScriptRoot "preflight-check.ps1")

$verifyDevEntryPath = Join-Path $PSScriptRoot "verify-dev-entry.ps1"
if (Test-Path $verifyDevEntryPath) {
    Invoke-CheckScript -Name "verify-dev-entry"   -Path $verifyDevEntryPath
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  检查结果汇总" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan

$hasFailures = $scriptResults | Where-Object { $_.ExitCode -ne 0 }
$passCount = ($scriptResults | Where-Object { $_.ExitCode -eq 0 }).Count
$totalCount = $scriptResults.Count

foreach ($result in $scriptResults) {
    if ($result.ExitCode -eq 0) {
        Write-Host "  ✓ $($result.Name)" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $($result.Name) (exit $($result.ExitCode))" -ForegroundColor Red
    }
}

Write-Host ""
if ($hasFailures) {
    Write-Host "  状态: $passCount/$totalCount 通过" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  提示: 部分检查未通过，请查看上方输出了解详情" -ForegroundColor Gray
    Write-Host "        如需帮助，请检查相关脚本是否正确安装" -ForegroundColor Gray
} else {
    Write-Host "  状态: 全部通过 ($passCount/$totalCount) 🎉" -ForegroundColor Green
    Write-Host ""
    Write-Host "  提示: 开发环境检查完成，可以继续后续工作" -ForegroundColor Gray
}

Write-Host ""

exit $(if ($hasFailures) { 1 } else { 0 })
