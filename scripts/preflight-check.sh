#!/bin/bash
# preflight-check.sh - 预提交检查脚本 (Linux/服务器端)
# 用法: bash preflight-check.sh [--strict]

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

ERRORS=0
WARNINGS=0

log_pass() {
    echo -e "${GREEN}✓${NC} $1"
}

log_fail() {
    echo -e "${RED}✗${NC} $1"
    ((ERRORS++))
}

log_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((WARNINGS++))
}

log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

echo -e "${BLUE}=== 预提交检查 ===${NC}"
echo ""

# 1. 检查 Git 仓库
log_info "1. 检查 Git 仓库..."
if git rev-parse --git-dir > /dev/null 2>&1; then
    log_pass "Git 仓库正常"
else
    log_fail "不是 Git 仓库"
fi

# 2. 检查分支
log_info "2. 检查当前分支..."
current_branch=$(git branch --show-current 2>/dev/null || echo "")
if [[ "$current_branch" == "chore/cursor-bootstrap" ]]; then
    log_pass "当前分支: $current_branch"
elif [[ "$current_branch" == "main" ]]; then
    if [[ "$1" == "--strict" ]]; then
        log_fail "不应直接提交到 main"
    else
        log_warn "当前在 main 分支，建议在 feature 分支开发"
    fi
else
    log_warn "当前分支: $current_branch"
fi

# 3. 检查工作区状态
log_info "3. 检查工作区状态..."
if git diff --quiet 2>/dev/null; then
    if git status --porcelain | grep -q .; then
        log_pass "有未暂存的更改"
    else
        log_info "工作区干净"
    fi
else
    log_info "有未提交的更改"
fi

# 4. 检查关键目录存在
log_info "4. 检查关键目录..."
for dir in docs scripts tools; do
    if [ -d "$dir" ]; then
        log_pass "$dir/ 存在"
    else
        log_fail "$dir/ 目录缺失"
    fi
done

# 5. 检查 README 文件
log_info "5. 检查 README 文件..."
readme_count=$(find . -maxdepth 1 -name "README*" -type f | wc -l)
if [ "$readme_count" -gt 0 ]; then
    log_pass "找到 $readme_count 个 README 文件"
else
    log_warn "未找到 README 文件"
fi

# 6. Markdown 基本检查
log_info "6. Markdown 检查..."
md_files=$(find . -name "*.md" -not -path "./.git/*")
empty_md=0
for f in $md_files; do
    if [ ! -s "$f" ]; then
        ((empty_md++))
    fi
done
if [ "$empty_md" -eq 0 ]; then
    log_pass "所有 Markdown 文件非空"
else
    log_warn "$empty_md 个空 Markdown 文件"
fi

# 7. 脚本语法检查
log_info "7. 脚本语法检查..."
sh_files=$(find scripts -name "*.sh" -type f 2>/dev/null)
if [ -n "$sh_files" ]; then
    syntax_ok=true
    for f in $sh_files; do
        if ! bash -n "$f" 2>/dev/null; then
            log_fail "脚本语法错误: $f"
            syntax_ok=false
        fi
    done
    if $syntax_ok; then
        log_pass "所有 Bash 脚本语法正常"
    fi
else
    log_info "无 Bash 脚本"
fi

# 8. 仓库结构完整性
log_info "8. 仓库结构检查..."
required_dirs=("docs" "scripts" "tools")
missing=0
for d in "${required_dirs[@]}"; do
    if [ ! -d "$d" ]; then
        ((missing++))
    fi
done
if [ "$missing" -eq 0 ]; then
    log_pass "仓库结构完整"
else
    log_fail "缺少 $missing 个必需目录"
fi

# 总结
echo ""
echo -e "${BLUE}=== 检查结果 ===${NC}"
echo -e "错误: $ERRORS"
echo -e "警告: $WARNINGS"
echo ""

if [ "$ERRORS" -gt 0 ]; then
    echo -e "${RED}检查失败，请修复以上错误${NC}"
    exit 1
elif [ "$WARNINGS" -gt 0 ]; then
    echo -e "${YELLOW}检查通过但有警告${NC}"
    exit 0
else
    echo -e "${GREEN}检查通过${NC}"
    exit 0
fi