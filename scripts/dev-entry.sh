#!/bin/bash
# dev-entry.sh - 统一任务入口脚本（Linux/服务器端）
# 用法: bash dev-entry.sh [command]

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 命令列表
COMMANDS=(
    "check:运行开发环境检查"
    "status:显示仓库状态摘要"
    "docs:查看文档索引"
    "handoff:生成handoff入口"
    "reports:检查报告目录"
    "all:运行所有检查（check+preflight+status）"
    "preflight:运行预提交检查"
    "report:生成变更报告"
    "help:显示帮助"
)

show_help() {
    echo -e "${BLUE}=== 开发任务统一入口 ===${NC}"
    echo ""
    echo "用法: bash dev-entry.sh <command>"
    echo ""
    echo -e "${GREEN}可用命令:${NC}"
    for cmd in "${COMMANDS[@]}"; do
        IFS=':' read -r name desc <<< "$cmd"
        echo "  $name  - $desc"
    done
    echo ""
    echo -e "${YELLOW}示例:${NC}"
    echo "  bash dev-entry.sh check      # 运行开发环境检查"
    echo "  bash dev-entry.sh status     # 查看仓库状态"
    echo "  bash dev-entry.sh docs       # 查看文档索引"
    echo "  bash dev-entry.sh handoff   # 生成 handoff"
    echo "  bash dev-entry.sh reports    # 检查报告目录"
    echo "  bash dev-entry.sh all        # 运行所有检查"
    echo "  bash dev-entry.sh preflight  # 运行预提交检查"
    echo "  bash dev-entry.sh report     # 生成变更报告"
}

cmd_check() {
    echo -e "${BLUE}=== 运行开发环境检查 ===${NC}"
    bash scripts/check-dev-env-server.sh
}

cmd_status() {
    echo -e "${BLUE}=== 仓库状态摘要 ===${NC}"
    echo ""
    echo "分支: $(git branch --show-current)"
    echo "远程: $(git remote get-url origin 2>/dev/null || echo 'N/A')"
    echo "提交: $(git log -1 --oneline)"
    echo ""
    echo "文件统计:"
    echo "  文档: $(find docs -name '*.md' 2>/dev/null | wc -l) 个"
    echo "  脚本: $(find scripts -name '*.sh' 2>/dev/null | wc -l) 个"
    echo "  工具: $(find tools -name '*.ps1' -o -name '*.sh' 2>/dev/null | wc -l) 个"
    echo ""
    echo "未提交更改: $(git status --porcelain | wc -l)"
}

cmd_docs() {
    echo -e "${BLUE}=== 文档索引 ===${NC}"
    echo ""
    echo "主要目录结构:"
    echo "  docs/                      - 文档主目录"
    echo "  docs/collab/chatgpt-lingxi/ - AI协作文档区"
    echo ""
    echo "最新文档 (按修改时间):"
    ls -1t docs/*.md collab/chatgpt-lingxi/*.md 2>/dev/null | head -10 | while read f; do
        echo "  - $f"
    done
    echo ""
    echo "模板文件:"
    echo "  - docs/collab/chatgpt-lingxi/task-template.md"
    echo "  - docs/collab/chatgpt-lingxi/report-template.md"
    echo "  - docs/collab/chatgpt-lingxi/handoff-template.md"
}

cmd_handoff() {
    echo -e "${BLUE}=== Handoff 生成入口 ===${NC}"
    echo ""
    echo "当前可用 handoff 模板:"
    ls -1 docs/collab/chatgpt-lingxi/*handoff*.md 2>/dev/null || echo "  (无)"
    echo ""
    echo "建议使用 handoff-template-v1.md 作为模板"
    echo "复制命令:"
    echo "  cp docs/collab/chatgpt-lingxi/handoff-template-v1.md docs/collab/chatgpt-lingxi/handoff-$(date +%Y%m%d).md"
}

cmd_reports() {
    echo -e "${BLUE}=== 报告目录检查 ===${NC}"
    echo ""
    echo "报告目录结构:"
    for dir in docs/collab/chatgpt-lingxi shared-for-ai/outputs; do
        if [ -d "$dir" ]; then
            count=$(find "$dir" -name '*.md' 2>/dev/null | wc -l)
            echo "  $dir: $count 个文档"
        else
            echo "  $dir: (不存在)"
        fi
    done
    echo ""
    echo "最近报告:"
    find docs/collab/chatgpt-lingxi -name '*.md' -mtime -7 2>/dev/null | head -5 | while read f; do
        echo "  - $(basename $f)"
    done
}

cmd_all() {
    echo -e "${BLUE}=== 运行所有检查 ===${NC}"
    echo ""
    echo "步骤 1/3: 开发环境检查"
    bash scripts/check-dev-env-server.sh
    echo ""
    echo "步骤 2/3: 预提交检查"
    bash scripts/preflight-check.sh
    echo ""
    echo "步骤 3/3: 仓库状态"
    bash scripts/dev-entry.sh status
    echo ""
    echo -e "${GREEN}=== 所有检查完成 ===${NC}"
}

cmd_preflight() {
    echo -e "${BLUE}=== 运行预提交检查 ===${NC}"
    bash scripts/preflight-check.sh
}

cmd_report() {
    echo -e "${BLUE}=== 生成变更报告 ===${NC}"
    bash scripts/generate-change-report.sh
}

# 主逻辑
case "${1:-help}" in
    check)     cmd_check ;;
    status)    cmd_status ;;
    docs)      cmd_docs ;;
    handoff)   cmd_handoff ;;
    reports)   cmd_reports ;;
    all)       cmd_all ;;
    preflight) cmd_preflight ;;
    report)    cmd_report ;;
    help|--help|-h) show_help ;;
    *)         echo -e "${RED}未知命令: $1${NC}"; show_help; exit 1 ;;
esac