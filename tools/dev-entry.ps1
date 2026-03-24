# dev-entry.ps1 - 统一任务入口脚本（Windows 端）
# 用法: .\dev-entry.ps1 [command]

$ErrorActionPreference = "Continue"

# 获取脚本所在目录
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir

# 颜色函数
function Write-Color($color, $message) {
    switch ($color) {
        "Red"    { Write-Host $message -ForegroundColor Red }
        "Green"  { Write-Host $message -ForegroundColor Green }
        "Yellow" { Write-Host $message -ForegroundColor Yellow }
        "Blue"   { Write-Host $message -ForegroundColor Cyan }
        default  { Write-Host $message }
    }
}

function Show-Help {
    Write-Color "Blue" "=== 开发任务统一入口 ==="
    Write-Host ""
    Write-Color "Green" "可用命令:"
    Write-Host "  check    - 运行开发环境检查"
    Write-Host "  status   - 显示仓库状态摘要"
    Write-Host "  docs     - 查看文档索引"
    Write-Host "  handoff  - 生成 handoff 入口"
    Write-Host "  reports  - 检查报告目录"
    Write-Host "  help     - 显示帮助"
    Write-Host ""
    Write-Color "Yellow" "示例:"
    Write-Host "  .\dev-entry.ps1 check    # 运行开发环境检查"
    Write-Host "  .\dev-entry.ps1 status   # 查看仓库状态"
    Write-Host "  .\dev-entry.ps1 docs    # 查看文档索引"
}

function Cmd-Check {
    Write-Color "Blue" "=== 运行开发环境检查 ==="
    & "$ScriptDir\check-dev-env-local.ps1"
}

function Cmd-Status {
    Write-Color "Blue" "=== 仓库状态摘要 ==="
    Write-Host ""
    
    # Git 分支
    $branch = git branch --show-current 2>$null
    Write-Host "分支: $branch"
    
    # 远程
    $remote = git remote get-url origin 2>$null
    Write-Host "远程: $remote"
    
    # 最近提交
    $commit = git log -1 --oneline 2>$null
    Write-Host "提交: $commit"
    
    Write-Host ""
    Write-Host "文件统计:"
    
    $docCount = (Get-ChildItem -Path "$RepoRoot\docs" -Recurse -Filter "*.md" -ErrorAction SilentlyContinue).Count
    $scriptCount = (Get-ChildItem -Path "$RepoRoot\scripts" -Recurse -Filter "*.sh" -ErrorAction SilentlyContinue).Count
    $toolCount = (Get-ChildItem -Path "$RepoRoot\tools" -Recurse -Filter "*.ps1" -ErrorAction SilentlyContinue).Count
    
    Write-Host "  文档: $docCount 个"
    Write-Host "  脚本: $scriptCount 个"
    Write-Host "  工具: $toolCount 个"
    
    $status = git status --porcelain 2>$null
    $uncommitted = if ($status) { ($status -split "`n").Count } else { 0 }
    Write-Host "  未提交更改: $uncommitted"
}

function Cmd-Docs {
    Write-Color "Blue" "=== 文档索引 ==="
    Write-Host ""
    Write-Host "主要目录结构:"
    Write-Host "  docs/                      - 文档主目录"
    Write-Host "  docs/collab/chatgpt-lingxi/ - AI协作文档区"
    Write-Host ""
    
    $sharedDir = "$RepoRoot\docs\collab\chatgpt-lingxi"
    if (Test-Path $sharedDir) {
        Write-Host "最新文档:"
        Get-ChildItem -Path $sharedDir -Filter "*.md" -ErrorAction SilentlyContinue | 
            Sort-Object LastWriteTime -Descending | 
            Select-Object -First 10 | 
            ForEach-Object { Write-Host "  - $($_.Name)" }
    }
    
    Write-Host ""
    Write-Host "模板文件:"
    Write-Host "  - docs/collab/chatgpt-lingxi/task-template.md"
    Write-Host "  - docs/collab/chatgpt-lingxi/report-template.md"
    Write-Host "  - docs/collab/chatgpt-lingxi/handoff-template.md"
}

function Cmd-Handoff {
    Write-Color "Blue" "=== Handoff 生成入口 ==="
    Write-Host ""
    Write-Host "当前可用 handoff 模板:"
    
    $handoffFiles = Get-ChildItem -Path "$RepoRoot\docs\collab\chatgpt-lingxi" -Filter "*handoff*.md" -ErrorAction SilentlyContinue
    if ($handoffFiles) {
        $handoffFiles | ForEach-Object { Write-Host "  - $($_.Name)" }
    } else {
        Write-Host "  (无)"
    }
    
    Write-Host ""
    Write-Host "建议使用 handoff-template-v1.md 作为模板"
    Write-Host "复制命令示例:"
    Write-Host "  Copy-Item -Path 'docs\collab\chatgpt-lingxi\handoff-template-v1.md' -Destination 'docs\collab\chatgpt-lingxi\handoff-20260325.md'"
}

function Cmd-Reports {
    Write-Color "Blue" "=== 报告目录检查 ==="
    Write-Host ""
    Write-Host "报告目录结构:"
    
    $dirs = @(
        "docs=collab\chatgpt-lingxi",
        "shared-for-ai\outputs"
    )
    
    foreach ($dir in $dirs) {
        $path = "$RepoRoot\$dir"
        if (Test-Path $path) {
            $count = (Get-ChildItem -Path $path -Filter "*.md" -ErrorAction SilentlyContinue).Count
            Write-Host "  $dir`: $count 个文档"
        } else {
            Write-Host "  $dir`: (不存在)"
        }
    }
    
    Write-Host ""
    Write-Host "最近报告 (7天内):"
    Get-ChildItem -Path "$RepoRoot\docs\collab\chatgpt-lingxi" -Filter "*.md" -ErrorAction SilentlyContinue | 
        Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-7) } | 
        Select-Object -First 5 | 
        ForEach-Object { Write-Host "  - $($_.Name)" }
}

# 主逻辑
$cmd = $args[0]
switch ($cmd) {
    "check"    { Cmd-Check }
    "status"   { Cmd-Status }
    "docs"     { Cmd-Docs }
    "handoff"  { Cmd-Handoff }
    "reports"  { Cmd-Reports }
    "help"     { Show-Help }
    "?"        { Show-Help }
    default    { Show-Help }
}