# check-dev-env-local.ps1
# 本地开发环境检查脚本
# 适用：Windows PowerShell

$ErrorActionPreference = "Continue"

Write-Host "=== 本地开发环境检查 ===" -ForegroundColor Cyan
Write-Host ""

# 1. 检查分支
Write-Host "[1] 检查 Git 分支..." -NoNewline
$branch = git branch --show-current 2>$null
if ($branch -eq "chore/cursor-bootstrap") {
    Write-Host " OK" -ForegroundColor Green
} elseif ($branch) {
    Write-Host " 当前在: $branch (建议切换到 chore/cursor-bootstrap)" -ForegroundColor Yellow
} else {
    Write-Host " 不是 Git 仓库" -ForegroundColor Red
}

# 2. 检查 README
Write-Host "[2] 检查 README 文件..." -NoNewline
$readmeFiles = Get-ChildItem -Path . -Filter "README*" -File -ErrorAction SilentlyContinue
if ($readmeFiles) {
    Write-Host " OK ($($readmeFiles.Count) 个文件)" -ForegroundColor Green
} else {
    Write-Host " 未找到 README 文件" -ForegroundColor Red
}

# 3. 检查 docs 目录
Write-Host "[3] 检查 docs 目录..." -NoNewline
if (Test-Path "docs") {
    Write-Host " OK" -ForegroundColor Green
} else {
    Write-Host " 不存在 docs 目录" -ForegroundColor Red
}

# 4. 检查共享目录
Write-Host "[4] 检查共享目录..." -NoNewline
if (Test-Path "docs/collab/chatgpt-lingxi") {
    Write-Host " OK" -ForegroundColor Green
} else {
    Write-Host " 不存在共享目录" -ForegroundColor Red
}

# 5. 检查 Git 状态
Write-Host "[5] 检查 Git 状态..." -NoNewline
$status = git status --porcelain 2>$null
if ($LASTEXITCODE -eq 0) {
    if ($status) {
        Write-Host " 有未提交更改" -ForegroundColor Yellow
    } else {
        Write-Host " 工作区干净" -ForegroundColor Green
    }
} else {
    Write-Host " Git 不可用" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== 检查完成 ===" -ForegroundColor Cyan
