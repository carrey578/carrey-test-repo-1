#!/bin/bash
# dev-entry-v2.sh - 统一开发入口脚本 v2
# 用法: bash scripts/dev-entry-v2.sh [options] <command>
#
# v2 新增:
#   - 集成 verify 功能
#   - 集成 status report
#   - 集成 change summary

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

# 引入公共库
source "$SCRIPT_DIR/lib-common.sh"

# 默认参数
VERBOSE=false
QUIET=false

# 命令列表 v2
COMMANDS=(
    # 开发检查类
    "check:运行开发环境检查"
    "preflight:运行预提交检查"
    "env:检查本地/服务器环境"
    
    # 验证类
    "verify:运行功能验证"
    "verify-all:运行完整验证"
    
    # 状态报告类
    "status:显示仓库状态"
    "report:生成状态报告"
    "summary:生成变更摘要"
    
    # 文档类
    "docs:查看文档索引"
    "handoff:生成handoff"
    
    # 批量类
    "all:运行所有检查"
    "full:完整检查+验证+报告"
    
    # 帮助
    "help:显示帮助"
)

# 显示帮助
show_help() {
    echo -e "${BLUE}=== 开发任务统一入口 v2 ===${NC}"
    echo ""
    echo "用法: bash dev-entry-v2.sh [options] <command>"
    echo ""
    echo -e "${GREEN}全局选项:${NC}"
    echo "  -v, --verbose   详细输出模式"
    echo "  -q, --quiet     安静模式（只输出关键信息）"
    echo "  -h, --help      显示帮助"
    echo ""
    echo -e "${GREEN}开发检查:${NC}"
    echo "  check      - 运行开发环境检查"
    echo "  preflight  - 运行预提交检查"
    echo "  env        - 检查环境状态"
    echo ""
    echo -e "${GREEN}验证:${NC}"
    echo "  verify     - 运行功能验证"
    echo "  verify-all - 运行完整验证"
    echo ""
    echo -e "${GREEN}状态报告:${NC}"
    echo "  status     - 显示仓库状态"
    echo "  report     - 生成状态报告"
    echo "  summary    - 生成变更摘要"
    echo ""
    echo -e "${GREEN}文档:${NC}"
    echo "  docs       - 查看文档索引"
    echo "  handoff    - 生成 handoff"
    echo ""
    echo -e "${GREEN}批量:${NC}"
    echo "  all        - 运行所有检查"
    echo "  full       - 完整检查+验证+报告"
    echo ""
    echo -e "${YELLOW}示例:${NC}"
    echo "  bash dev-entry-v2.sh check           # 开发环境检查"
    echo "  bash dev-entry-v2.sh verify          # 功能验证"
    echo "  bash dev-entry-v2.sh status          # 查看状态"
    echo "  bash dev-entry-v2.sh full           # 完整检查"
    echo "  bash dev-entry-v2.sh -v all         # 详细模式"
}

# 消息函数
log_info() { [ "$QUIET" = false ] && echo -e "${BLUE}ℹ${NC} $1"; }
log_success() { [ "$QUIET" = false ] && echo -e "${GREEN}✓${NC} $1"; }
log_error() { echo -e "${RED}✗${NC} $1" >&2; }

# 命令: check
cmd_check() {
    log_info "运行开发环境检查..."
    if [ -f "$SCRIPT_DIR/check-dev-env-server.sh" ]; then
        bash "$SCRIPT_DIR/check-dev-env-server.sh"
    else
        log_error "check-dev-env-server.sh 不存在"
        return 1
    fi
}

# 命令: preflight
cmd_preflight() {
    log_info "运行预提交检查..."
    if [ -f "$SCRIPT_DIR/preflight-check.sh" ]; then
        bash "$SCRIPT_DIR/preflight-check.sh"
    else
        log_error "preflight-check.sh 不存在"
        return 1
    fi
}

# 命令: env
cmd_env() {
    log_info "检查环境..."
    echo "=== 环境信息 ==="
    echo "用户: $(whoami)"
    echo "主机: $(hostname)"
    echo "目录: $(pwd)"
    echo "Git分支: $(git branch --show-current 2>/dev/null || echo 'N/A')"
    echo "Git提交: $(git rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
}

# 命令: verify
cmd_verify() {
    log_info "运行功能验证..."
    if [ -f "$SCRIPT_DIR/verify-main-feature.sh" ]; then
        bash "$SCRIPT_DIR/verify-main-feature.sh" --quick
    else
        log_error "verify-main-feature.sh 不存在"
        return 1
    fi
}

# 命令: verify-all
cmd_verify_all() {
    log_info "运行完整验证..."
    if [ -f "$SCRIPT_DIR/verify-main-feature.sh" ]; then
        bash "$SCRIPT_DIR/verify-main-feature.sh"
    else
        log_error "verify-main-feature.sh 不存在"
        return 1
    fi
}

# 命令: status
cmd_status() {
    log_info "显示仓库状态..."
    echo "=== 仓库状态 ==="
    echo "分支: $(git branch --show-current 2>/dev/null)"
    echo "提交: $(git rev-parse --short HEAD 2>/dev/null)"
    echo "状态: $(git status --porcelain 2>/dev/null | wc -l) 个更改"
    echo "最近提交:"
    git log --oneline -5 2>/dev/null || echo "无"
}

# 命令: report
cmd_report() {
    log_info "生成状态报告..."
    if [ -f "$SCRIPT_DIR/generate-change-report.sh" ]; then
        bash "$SCRIPT_DIR/generate-change-report.sh"
    else
        # 手动生成简单报告
        REPORT_FILE="docs/collab/chatgpt-lingxi/auto-status-report-$(date +%Y%m%d-%H%M%S).md"
        mkdir -p docs/collab/chatgpt-lingxi
        cat > "$REPORT_FILE" << EOF
# 自动状态报告

生成时间: $(date)

## 仓库状态

- 分支: $(git branch --show-current 2>/dev/null)
- 提交: $(git rev-parse --short HEAD 2>/dev/null)

## 最近提交

$(git log --oneline -5 2>/dev/null)

## 改动文件

$(git diff --name-status HEAD~5..HEAD 2>/dev/null || echo "无")
EOF
        log_success "报告已生成: $REPORT_FILE"
    fi
}

# 命令: summary
cmd_summary() {
    log_info "生成变更摘要..."
    echo "=== 变更摘要 ==="
    echo "最近5个提交:"
    git log --oneline -5 2>/dev/null
    echo ""
    echo "改动文件:"
    git diff --name-status HEAD~3..HEAD 2>/dev/null || echo "无"
}

# 命令: docs
cmd_docs() {
    log_info "查看文档索引..."
    echo "=== 文档目录 ==="
    ls -1 docs/*.md 2>/dev/null | head -10
    echo ""
    echo "协作文档:"
    ls -1 docs/collab/chatgpt-lingxi/*.md 2>/dev/null | tail -10
}

# 命令: handoff
cmd_handoff() {
    log_info "生成 handoff..."
    if [ -f "$SCRIPT_DIR/generate-handoff.sh" ]; then
        bash "$SCRIPT_DIR/generate-handoff.sh"
    else
        log_error "generate-handoff.sh 不存在"
        return 1
    fi
}

# 命令: all
cmd_all() {
    log_info "运行所有检查..."
    cmd_check
    cmd_preflight
    cmd_status
    log_success "所有检查完成"
}

# 命令: full
cmd_full() {
    log_info "运行完整检查..."
    cmd_check
    cmd_preflight
    cmd_verify
    cmd_status
    cmd_report
    log_success "完整检查完成"
}

# 解析参数
COMMAND=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -q|--quiet)
            QUIET=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -*)
            log_error "未知选项: $1"
            show_help
            exit 1
            ;;
        *)
            COMMAND="$1"
            shift
            ;;
    esac
done

# 执行命令
if [ -z "$COMMAND" ]; then
    show_help
    exit 0
fi

case "$COMMAND" in
    check) cmd_check ;;
    preflight) cmd_preflight ;;
    env) cmd_env ;;
    verify) cmd_verify ;;
    verify-all) cmd_verify_all ;;
    status) cmd_status ;;
    report) cmd_report ;;
    summary) cmd_summary ;;
    docs) cmd_docs ;;
    handoff) cmd_handoff ;;
    all) cmd_all ;;
    full) cmd_full ;;
    help) show_help ;;
    *)
        log_error "未知命令: $COMMAND"
        show_help
        exit 1
        ;;
esac
