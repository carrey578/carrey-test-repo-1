# preflight-check.ps1 - 预提交检查脚本 (Windows 端)
# 用法: .\preflight-check.ps1 [-Strict]

$ErrorActionPreference = "Continue"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

function Write-Log($type, $message) {
    switch ($type) {
        "Pass"  { Write-Host "✓ $message" -ForegroundColor Green }
        "Fail"  { Write-Host "✗ $message" -ForegroundColor Red; $script:Errors++ }
        "Warn"  { Write-Host "⚠ $message" -ForegroundColor Yellow; $script:Warnings++ }
        "Info"   { Write-Host "ℹ $message" -ForegroundColor Cyan }
    }
}

$Errors = 0
$Warnings = 0

Write-Host "=== 预提交检查 ===" -ForegroundColor Cyan
Write-Host ""

# 1. 检查 Git 仓库
Write-Log "Info" "1. 检查 Git 仓库..."
try {
    $gitCheck = git rev-parse --git-dir 2>$null
    Write-Log "Pass" "Git 仓库正常"
} catch {
    Write-Log "Fail" "不是 Git 仓库"
}

# 2. 检查分支
Write-Log "Info" "2. 检查当前分支..."
$branch = git branch --show-current 2>$null
if ($branch -eq "chore/cursor-bootstrap") {
    Write-Log "Pass" "当前分支: $branch"
} elseif ($branch -eq "main") {
    if ($Strict) {
        Write-Log "Fail" "不应直接提交到 main"
    } else {
        Write-Log "Warn" "当前在 main 分支，建议在 feature 分支开发"
    }
} else {
    Write-Log "Warn" "当前分支: $branch"
}

# 3. 检查工作区状态
Write-Log "Info" "3. 检查工作区状态..."
$status = git status --porcelain 2>$null
if (-not $status) {
    Write-Log "Info" "工作区干净"
} else {
    $untracked = ($status -split "`n" | Where-Object { $_ -match "^\?\?" }).Count
    $modified = ($status -split "`n" | Where-Object { $_ -match "^( M|M )" }).Count
    Write-Log "Info" "未暂存: $untracked, 已修改: $modified"
}

# 4. 检查关键目录
Write-Log "Info" "4. 检查关键目录..."
$dirs = @("docs", "scripts", "tools")
foreach ($dir in $dirs) {
    if (Test-Path "$RepoRoot/$dir") {
        Write-Log "Pass" "$dir/ 存在"
    } else {
        Write-Log "Fail" "$dir/ 目录缺失"
    }
}

# 5. 检查 README
Write-Log "Info" "5. 检查 README 文件..."
$readmeFiles = Get-ChildItem -Path $RepoRoot -Filter "README*" -File -ErrorAction SilentlyContinue
if ($readmeFiles) {
    Write-Log "Pass" "找到 $($readmeFiles.Count) 个 README 文件"
} else {
    Write-Log "Warn" "未找到 README 文件"
}

# 6. Markdown 检查
Write-Log "Info" "6. Markdown 检查..."
$mdFiles = Get-ChildItem -Path $RepoRoot -Recurse -Filter "*.md" -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer }
$emptyMd = ($mdFiles | Where-Object { $_.Length -eq 0 }).Count
if ($emptyMd -eq 0) {
    Write-Log "Pass" "所有 Markdown 文件非空 (共 $($mdFiles.Count) 个)"
} else {
    Write-Log "Warn" "$emptyMd 个空 Markdown 文件"
}

# 7. PowerShell 语法检查
Write-Log "Info" "7. 脚本语法检查..."
$psFiles = Get-ChildItem -Path "$RepoRoot/tools" -Filter "*.ps1" -ErrorAction SilentlyContinue
if ($psFiles) {
    $syntaxOk = $true
    foreach ($f in $psFiles) {
        try {
            $null = [System.Management.Automation.PSParser]::Tokenize((Get-Content $f.FullName -Raw), [ref]$null)
        } catch {
            Write-Log "Fail" "脚本语法错误: $($f.Name)"
            $syntaxOk = $false
        }
    }
    if ($syntaxOk) {
        Write-Log "Pass" "所有 PowerShell 脚本语法正常"
    }
} else {
    Write-Log "Info" "无 PowerShell 脚本"
}

# 8. 仓库结构
Write-Log "Info" "8. 仓库结构检查..."
$requiredDirs = @("docs", "scripts", "tools")
$missing = 0
foreach ($d in $requiredDirs) {
    if (-not (Test-Path "$RepoRoot/$d")) {
        $missing++
    }
}
if ($missing -eq 0) {
    Write-Log "Pass" "仓库结构完整"
} else {
    Write-Log "Fail" "缺少 $missing 个必需目录"
}

# 总结
Write-Host ""
Write-Host "=== 检查结果 ===" -ForegroundColor Cyan
Write-Host "错误: $Errors"
Write-Host "警告: $Warnings"
Write-Host ""

if ($Errors -gt 0) {
    Write-Host "检查失败，请修复以上错误" -ForegroundColor Red
    exit 1
} elseif ($Warnings -gt 0) {
    Write-Host "检查通过但有警告" -ForegroundColor Yellow
    exit 0
} else {
    Write-Host "检查通过" -ForegroundColor Green
    exit 0
}