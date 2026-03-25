#!/bin/bash
# demo-entry.sh - 最小 Demo 入口脚本
# 用法: bash scripts/demo-entry.sh [demo-name]
#
# 本 Demo 展示当前仓库的自动化能力

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

# 引入公共库
source "$SCRIPT_DIR/lib-common.sh"

# Demo 列表
DEMOS=(
    "1:自动化报告:展示自动生成报告的能力"
    "2:功能验证:展示功能验证的能力"
    "3:变更摘要:展示变更摘要的能力"
    "4:完整流程:展示从验证到报告的完整流程"
    "5:全部运行:运行所有Demo"
)

# 显示 Demo 菜单
show_menu() {
    print_title "最小 Demo 入口"
    echo ""
    echo "当前仓库自动化能力演示"
    echo ""
    for demo in "${DEMOS[@]}"; do
        IFS=':' read -r id name desc <<< "$demo"
        echo "  $id. $name"
        echo "     $desc"
        echo ""
    done
    echo "  0. 退出"
    echo ""
}

# Demo 1: 自动化报告
demo_report() {
    print_title "Demo 1: 自动化报告"
    echo ""
    log_info "生成状态报告..."
    bash "$SCRIPT_DIR/generate-status-report.sh" > /dev/null 2>&1
    log_success "报告已生成"
    echo ""
    echo "报告位置: docs/collab/chatgpt-lingxi/auto-status-report.md"
    echo ""
}

# Demo 2: 功能验证
demo_verify() {
    print_title "Demo 2: 功能验证"
    echo ""
    log_info "运行快速验证..."
    bash "$SCRIPT_DIR/verify-main-feature.sh" --quick
    echo ""
}

# Demo 3: 变更摘要
demo_summary() {
    print_title "Demo 3: 变更摘要"
    echo ""
    log_info "生成变更摘要..."
    bash "$SCRIPT_DIR/generate-change-summary-v2.sh" -n 3 > /dev/null 2>&1
    log_success "变更摘要已生成"
    echo ""
    echo "摘要位置: docs/collab/chatgpt-lingxi/change-summary-*.md"
    echo ""
}

# Demo 4: 完整流程
demo_full() {
    print_title "Demo 4: 完整流程"
    echo ""
    echo "执行: 验证 -> 状态报告 -> 变更摘要"
    echo ""
    
    log_info "1. 运行验证..."
    bash "$SCRIPT_DIR/verify-main-feature.sh" --quick
    echo ""
    
    log_info "2. 生成状态报告..."
    bash "$SCRIPT_DIR/generate-status-report.sh" > /dev/null 2>&1
    log_success "报告已生成"
    echo ""
    
    log_info "3. 生成变更摘要..."
    bash "$SCRIPT_DIR/generate-change-summary-v2.sh" -n 3 > /dev/null 2>&1
    log_success "摘要已生成"
    echo ""
    
    log_success "完整流程执行完成！"
    echo ""
}

# Demo 5: 全部运行
demo_all() {
    print_title "Demo 5: 全部运行"
    echo ""
    demo_verify
    demo_report
    demo_summary
    echo ""
    log_success "所有 Demo 执行完成！"
}

# 主逻辑
if [[ $# -eq 0 ]]; then
    show_menu
    read -p "请选择 Demo (0-5): " choice
else
    choice="$1"
fi

case "$choice" in
    1) demo_report ;;
    2) demo_verify ;;
    3) demo_summary ;;
    4) demo_full ;;
    5) demo_all ;;
    0) exit 0 ;;
    *)
        log_error "无效选择: $choice"
        exit 1
        ;;
esac
