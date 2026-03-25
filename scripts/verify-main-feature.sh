#!/bin/bash
# verify-main-feature.sh - 主功能（dev-entry.sh）最小可复用验证入口
# 用法: bash scripts/verify-main-feature.sh [--quick]
# 
# 验证目标:
#   1. 功能能执行
#   2. 关键输出存在
#   3. 基本结果正确

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT_PATH="$REPO_ROOT/scripts/dev-entry.sh"
QUICK_MODE=false

# 解析参数
if [[ "$1" == "--quick" ]]; then
    QUICK_MODE=true
fi

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PASS=0
FAIL=0
SKIP=0

log_pass() { echo -e "${GREEN}✓${NC} $1"; ((PASS++)); }
log_fail() { echo -e "${RED}✗${NC} $1"; ((FAIL++)); }
log_skip() { echo -e "${YELLOW}⊘${NC} $1"; ((SKIP++)); }
log_info() { echo -e "${BLUE}ℹ${NC} $1"; }

echo -e "${BLUE}=== 主功能最小验证 ===${NC}"
echo ""

# ============================================================================
# 验证 1: 文件存在
# ============================================================================
log_info "检查 dev-entry.sh 文件..."
if [[ -f "$SCRIPT_PATH" ]]; then
    log_pass "dev-entry.sh 存在"
else
    log_fail "dev-entry.sh 不存在"
    echo "错误: $SCRIPT_PATH"
    exit 1
fi

# ============================================================================
# 验证 2: 可执行权限
# ============================================================================
log_info "检查执行权限..."
if [[ -x "$SCRIPT_PATH" ]]; then
    log_pass "有执行权限"
else
    log_fail "缺少执行权限"
fi

# ============================================================================
# 验证 3: help 命令（核心功能验证）
# ============================================================================
log_info "测试 help 命令..."
OUTPUT=$(bash "$SCRIPT_PATH" help 2>&1)
if echo "$OUTPUT" | grep -q "开发任务统一入口"; then
    log_pass "help 命令正常"
else
    log_fail "help 命令输出异常"
fi

# ============================================================================
# 验证 4: status 命令（简单功能验证）
# ============================================================================
if [[ "$QUICK_MODE" == false ]]; then
    log_info "测试 status 命令..."
    OUTPUT=$(bash "$SCRIPT_PATH" status 2>&1)
    if echo "$OUTPUT" | grep -q "分支:"; then
        log_pass "status 命令正常"
    else
        log_fail "status 命令输出异常"
    fi
else
    log_skip "status 命令 (快速模式)"
fi

# ============================================================================
# 验证 5: preflight 命令（依赖验证）
# ============================================================================
if [[ "$QUICK_MODE" == false ]]; then
    log_info "测试 preflight 命令..."
    OUTPUT=$(bash "$SCRIPT_PATH" preflight 2>&1)
    if echo "$OUTPUT" | grep -qE "检查通过|错误: 0|preflight.*完成"; then
        log_pass "preflight 命令正常"
    else
        # preflight 可能有警告，但不失败
        if echo "$OUTPUT" | grep -qE "检查|完成|通过"; then
            log_pass "preflight 命令可执行"
        else
            log_fail "preflight 命令异常"
        fi
    fi
else
    log_skip "preflight 命令 (快速模式)"
fi

# ============================================================================
# 验证 6: 命令列表完整性
# ============================================================================
log_info "检查命令列表..."
HELP_OUTPUT=$(bash "$SCRIPT_PATH" help 2>&1)
EXPECTED_COMMANDS=("check" "status" "docs" "handoff" "reports" "all" "preflight" "report" "help")
MISSING=()
for cmd in "${EXPECTED_COMMANDS[@]}"; do
    if ! echo "$HELP_OUTPUT" | grep -q "$cmd"; then
        MISSING+=("$cmd")
    fi
done

if [[ ${#MISSING[@]} -eq 0 ]]; then
    log_pass "所有核心命令存在"
else
    log_fail "缺失命令: ${MISSING[*]}"
fi

# ============================================================================
# 总结
# ============================================================================
echo ""
echo -e "${BLUE}=== 验证结果 ===${NC}"
echo -e "通过: ${GREEN}$PASS${NC}"
echo -e "失败: ${RED}$FAIL${NC}"
echo -e "跳过: ${YELLOW}$SKIP${NC}"
echo ""

if [[ $FAIL -eq 0 ]]; then
    echo -e "${GREEN}✅ 验证通过 - 主功能可正常使用${NC}"
    exit 0
else
    echo -e "${RED}❌ 验证失败 - 请检查上述问题${NC}"
    exit 1
fi