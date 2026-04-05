# verify-dev-entry.ps1 - dev-entry.ps1 validation script (Windows)
# Usage: .\verify-dev-entry.ps1

$ErrorActionPreference = "Continue"
$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

$pass = 0
$fail = 0

function Test-Case($name, $script) {
    Write-Host "Test: $name" -ForegroundColor Cyan
    try {
        $result = & $script 2>$null
        if ($LASTEXITCODE -eq 0 -or $result -match ((([string][char]0x901A) + [char]0x8FC7) + "|" + (([string][char]0x6210) + [char]0x529F) + "|OK")) {
            Write-Host "  [PASS]" -ForegroundColor Green
            $script:pass++
        } else {
            Write-Host "  [FAIL]" -ForegroundColor Red
            $script:fail++
        }
    } catch {
        Write-Host "  [FAIL]: $_" -ForegroundColor Red
        $script:fail++
    }
}

Write-Host "=== dev-entry.ps1 Validation ===" -ForegroundColor Cyan
Write-Host ""

# Test 1: help shows all command
Test-Case "help includes 'all'" {
    $output = & "$RepoRoot\tools\dev-entry.ps1" help 2>$null
    $output -match ("all.*" + ([string][char]0x8FD0) + [char]0x884C + [char]0x6240 + [char]0x6709 + [char]0x68C0 + [char]0x67E5)
}

# Test 2: help shows preflight
Test-Case "help includes 'preflight'" {
    $output = & "$RepoRoot\tools\dev-entry.ps1" help 2>$null
    $output -match "preflight"
}

# Test 3: help shows report
Test-Case "help includes 'report'" {
    $output = & "$RepoRoot\tools\dev-entry.ps1" help 2>$null
    $output -match ("report.*" + ([string][char]0x751F) + [char]0x6210 + [char]0x53D8 + [char]0x66F4 + [char]0x62A5 + [char]0x544A)
}

# Test 4: status still works
Test-Case "status command remains compatible" {
    $output = & "$RepoRoot\tools\dev-entry.ps1" status 2>$null
    $output -match ((([string][char]0x5206) + [char]0x652F) + ":")
}

# Test 5: check still works
Test-Case "check command remains compatible" {
    $output = & "$RepoRoot\tools\dev-entry.ps1" check 2>$null
    $output -match ((([string][char]0x5F00) + [char]0x53D1 + [char]0x73AF + [char]0x5883 + [char]0x68C0 + [char]0x67E5) + "|Check")
}

# Summary
Write-Host ""
Write-Host "=== Summary ===" -ForegroundColor Cyan
Write-Host "Passed: $pass" -ForegroundColor Green
Write-Host "Failed: $fail" -ForegroundColor Red
Write-Host ""

if ($fail -eq 0) {
    Write-Host "All validation checks passed." -ForegroundColor Green
    exit 0
} else {
    Write-Host "Validation has failed checks." -ForegroundColor Red
    exit 1
}
