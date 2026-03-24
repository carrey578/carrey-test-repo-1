# scripts/lib-common.sh - 公共函数库
# 提供颜色定义、消息函数等公共功能
# 用法: source scripts/lib-common.sh

# 颜色定义
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export BLUE='\033[0;34m'
export NC='\033[0m' # No Color

# 消息函数
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

# 获取仓库根目录
get_repo_root() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    echo "$(cd "$script_dir/.." && pwd)"
}

# 检查 Git 仓库
check_git_repo() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# 获取当前分支
get_current_branch() {
    git branch --show-current 2>/dev/null
}

# 获取最近 commit
get_latest_commit() {
    git log -1 --oneline 2>/dev/null
}