# check-dev-env-local.ps1
# Local development environment check script
# For: Windows PowerShell

$ErrorActionPreference = "Continue"

Write-Host "=== Local Development Environment Check ===" -ForegroundColor Cyan
Write-Host ""

# 1. Check Git branch
Write-Host "[1] Check Git branch..." -NoNewline
$branch = git branch --show-current 2>$null
if ($branch -eq "chore/cursor-bootstrap") {
    Write-Host " OK" -ForegroundColor Green
} elseif ($branch) {
    Write-Host " Current: $branch (recommend: chore/cursor-bootstrap)" -ForegroundColor Yellow
} else {
    Write-Host " Not a Git repository" -ForegroundColor Red
}

# 2. Check README files
Write-Host "[2] Check README files..." -NoNewline
$readmeFiles = Get-ChildItem -Path . -Filter "README*" -File -ErrorAction SilentlyContinue
if ($readmeFiles) {
    Write-Host " OK ($($readmeFiles.Count) file(s))" -ForegroundColor Green
} else {
    Write-Host " No README found" -ForegroundColor Red
}

# 3. Check docs directory
Write-Host "[3] Check docs directory..." -NoNewline
if (Test-Path "docs") {
    Write-Host " OK" -ForegroundColor Green
} else {
    Write-Host " docs directory not found" -ForegroundColor Red
}

# 4. Check shared directory
Write-Host "[4] Check shared directory..." -NoNewline
if (Test-Path "docs/collab/chatgpt-lingxi") {
    Write-Host " OK" -ForegroundColor Green
} else {
    Write-Host " shared directory not found" -ForegroundColor Red
}

# 5. Check Git status
Write-Host "[5] Check Git status..." -NoNewline
$status = git status --porcelain 2>$null
if ($LASTEXITCODE -eq 0) {
    if ($status) {
        Write-Host " Uncommitted changes" -ForegroundColor Yellow
    } else {
        Write-Host " Working tree clean" -ForegroundColor Green
    }
} else {
    Write-Host " Git unavailable" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== Check Complete ===" -ForegroundColor Cyan
