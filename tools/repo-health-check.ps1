$ErrorActionPreference = "Continue"

$scriptResults = @()

function Invoke-CheckScript {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        $script:scriptResults += [pscustomobject]@{
            Name = $Name
            ExitCode = 1
        }
        Write-Host "[wrapper] Missing script: $Path" -ForegroundColor Red
        return
    }

    & $Path
    $exitCode = if ($null -ne $LASTEXITCODE) { $LASTEXITCODE } else { 0 }

    $script:scriptResults += [pscustomobject]@{
        Name = $Name
        ExitCode = $exitCode
    }
}

Invoke-CheckScript -Name "check-dev-env-local" -Path (Join-Path $PSScriptRoot "check-dev-env-local.ps1")
Invoke-CheckScript -Name "preflight-check" -Path (Join-Path $PSScriptRoot "preflight-check.ps1")

$verifyDevEntryPath = Join-Path $PSScriptRoot "verify-dev-entry.ps1"
if (Test-Path $verifyDevEntryPath) {
    Invoke-CheckScript -Name "verify-dev-entry" -Path $verifyDevEntryPath
}

Write-Host ""
Write-Host "=== Wrapper Summary ===" -ForegroundColor Cyan

$hasFailures = $scriptResults | Where-Object { $_.ExitCode -ne 0 }
foreach ($result in $scriptResults) {
    if ($result.ExitCode -eq 0) {
        Write-Host "[PASS] $($result.Name)" -ForegroundColor Green
    } else {
        Write-Host "[FAIL] $($result.Name) (exit $($result.ExitCode))" -ForegroundColor Red
    }
}

exit $(if ($hasFailures) { 1 } else { 0 })
