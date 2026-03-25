# scripts/lib-common.sh - 公共函数库 v2
# 提供颜色定义、消息函数、Git 操作等公共功能
# 用法: source scripts/lib-common.sh
# 版本: v2 - 扩展版

# ============================================================================
# 颜色定义
# ============================================================================
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export BLUE='\033[0;34m'
export CYAN='\033[0;36m'
export NC='\033[0m' # No Color

# ============================================================================
# 消息函数
# ============================================================================
log_pass() {
    echo -e "${GREEN}✓${NC} $1"
}

log_fail() {
    echo -e "${RED}✗${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1" >&2
}

# ============================================================================
# 目录操作
# ============================================================================

# 获取仓库根目录
get_repo_root() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    echo "$(cd "$script_dir/.." && pwd)"
}

# 确保目录存在
ensure_dir() {
    local dir="$1"
    if [ -n "$dir" ]; then
        mkdir -p "$dir" 2>/dev/null
    fi
}

# ============================================================================
# Git 操作
# ============================================================================

# 检查是否为 Git 仓库
check_git_repo() {
    git rev-parse --git-dir > /dev/null 2>&1
}

# 获取当前分支
get_current_branch() {
    git branch --show-current 2>/dev/null || echo "N/A"
}

# 获取当前 Commit
get_current_commit() {
    git rev-parse --short HEAD 2>/dev/null || echo "N/A"
}

# 获取完整 Commit ID
get_full_commit() {
    git rev-parse HEAD 2>/dev/null || echo "N/A"
}

# 获取最近 N 条提交
get_recent_commits() {
    local count="${1:-5}"
    git log --oneline -"$count" 2>/dev/null || echo "无"
}

# 获取最近提交（单条）
get_latest_commit() {
    git log -1 --oneline 2>/dev/null || echo "无"
}

# 获取改动文件列表
get_changed_files() {
    local range="${1:-HEAD~1}"
    git diff --name-status "$range" 2>/dev/null || echo "无"
}

# 获取仓库状态信息
get_git_status() {
    local branch="$(get_current_branch)"
    local commit="$(get_current_commit)"
    local changes="$(git status --porcelain 2>/dev/null | wc -l)"
    
    echo "分支: $branch | 提交: $commit | 更改: $changes"
}

# 获取仓库基本信息（适合脚本使用）
get_repo_info() {
    echo "分支=$(get_current_branch)"
    echo "提交=$(get_current_commit)"
    echo "完整ID=$(get_full_commit)"
}

# ============================================================================
# 文件操作
# ============================================================================

# 获取时间戳
get_timestamp() {
    date +"%Y%m%d-%H%M%S"
}

# 获取日期时间
get_datetime() {
    date +"%Y-%m-%d %H:%M:%S"
}

# ============================================================================
# 输出格式化
# ============================================================================

# 输出表格行
print_table_row() {
    local col1="$1"
    local col2="$2"
    printf "%-20s %s\n" "$col1" "$col2"
}

# 输出分隔线
print_separator() {
    echo "---"
}

# 输出标题
print_title() {
    echo -e "${BLUE}=== $1 ===${NC}"
}
