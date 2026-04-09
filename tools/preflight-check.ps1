# preflight-check.ps1 - preflight check script (Windows)
# Usage: .\preflight-check.ps1 [-Strict]

$ErrorActionPreference = "Continue"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

function Write-Log($type, $message) {
    switch ($type) {
        "Pass"  { Write-Host "[PASS] $message" -ForegroundColor Green }
        "Fail"  { Write-Host "[FAIL] $message" -ForegroundColor Red; $script:Errors++ }
        "Warn"  { Write-Host "[WARN] $message" -ForegroundColor Yellow; $script:Warnings++ }
        "Info"  { Write-Host "[INFO] $message" -ForegroundColor Cyan }
    }
}

$Errors = 0
$Warnings = 0

Write-Host "=== Preflight Check ===" -ForegroundColor Cyan
Write-Host ""

# 1. Check Git repository
Write-Log "Info" "1. Checking Git repository..."
try {
    $gitCheck = git rev-parse --git-dir 2>$null
    Write-Log "Pass" "Git repository detected"
} catch {
    Write-Log "Fail" "Not a Git repository"
}

# 2. Check branch
Write-Log "Info" "2. Checking current branch..."
$branch = git branch --show-current 2>$null
if ($branch -eq "chore/cursor-bootstrap") {
    Write-Log "Pass" "Current branch: $branch"
} elseif ($branch -eq "main") {
    if ($Strict) {
        Write-Log "Fail" "Do not commit directly to main"
    } else {
        Write-Log "Warn" "Currently on main; use a feature branch if possible"
    }
} else {
    Write-Log "Warn" "Current branch: $branch"
}

# 3. Check working tree status
Write-Log "Info" "3. Checking working tree status..."
$status = git status --porcelain 2>$null
if (-not $status) {
    Write-Log "Info" "Working tree is clean"
} else {
    $untracked = ($status -split "`n" | Where-Object { $_ -match "^\?\?" }).Count
    $modified = ($status -split "`n" | Where-Object { $_ -match "^( M|M )" }).Count
    Write-Log "Info" "Untracked: $untracked, Modified: $modified"
}

# 4. Check key directories
Write-Log "Info" "4. Checking key directories..."
$dirs = @("docs", "scripts", "tools")
foreach ($dir in $dirs) {
    if (Test-Path "$RepoRoot\$dir") {
        Write-Log "Pass" "$dir/ exists"
    } else {
        Write-Log "Fail" "$dir/ is missing"
    }
}

# 5. Check README
Write-Log "Info" "5. Checking README files..."
$readmeFiles = Get-ChildItem -Path $RepoRoot -Filter "README*" -File -ErrorAction SilentlyContinue
if ($readmeFiles) {
    Write-Log "Pass" "Found $($readmeFiles.Count) README file(s)"
} else {
    Write-Log "Warn" "No README files found"
}

# 6. Markdown check
Write-Log "Info" "6. Checking Markdown files..."
$mdFiles = Get-ChildItem -Path $RepoRoot -Recurse -Filter "*.md" -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer }
$emptyMd = ($mdFiles | Where-Object { $_.Length -eq 0 }).Count
if ($emptyMd -eq 0) {
    Write-Log "Pass" "All Markdown files are non-empty (total $($mdFiles.Count))"
} else {
    Write-Log "Warn" "$emptyMd empty Markdown file(s)"
}

# 7. PowerShell syntax check
Write-Log "Info" "7. Checking script syntax..."
$psFiles = Get-ChildItem -Path "$RepoRoot\tools" -Filter "*.ps1" -ErrorAction SilentlyContinue
if ($psFiles) {
    $syntaxOk = $true
    foreach ($f in $psFiles) {
        try {
            $null = [System.Management.Automation.PSParser]::Tokenize((Get-Content $f.FullName -Raw), [ref]$null)
        } catch {
            Write-Log "Fail" "Script syntax error: $($f.Name)"
            $syntaxOk = $false
        }
    }
    if ($syntaxOk) {
        Write-Log "Pass" "All PowerShell scripts parsed successfully"
    }
} else {
    Write-Log "Info" "No PowerShell scripts found"
}

# 8. Repository structure
Write-Log "Info" "8. Checking repository structure..."
$requiredDirs = @("docs", "scripts", "tools")
$missing = 0
foreach ($d in $requiredDirs) {
    if (-not (Test-Path "$RepoRoot\$d")) {
        $missing++
    }
}
if ($missing -eq 0) {
    Write-Log "Pass" "Repository structure is complete"
} else {
    Write-Log "Fail" "Missing $missing required directorie(s)"
}

# Summary
Write-Host ""
Write-Host "=== Summary ===" -ForegroundColor Cyan
Write-Host "Errors: $Errors"
Write-Host "Warnings: $Warnings"
Write-Host ""

if ($Errors -gt 0) {
    Write-Host "Check failed. Fix the errors above." -ForegroundColor Red
    exit 1
} elseif ($Warnings -gt 0) {
    Write-Host "Check passed with warnings." -ForegroundColor Yellow
    exit 0
} else {
    Write-Host "Check passed." -ForegroundColor Green
    exit 0
}
