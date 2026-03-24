#!/bin/bash
# verify-dev-entry.sh - dev-entry.sh 功能验证脚本 (Linux/服务器端)
# 用法: bash verify-dev-entry.sh

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

PASS=0
FAIL=0

log_pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASS++))
}

log_fail() {
    echo -e "${RED}✗${NC} $1"
    ((FAIL++))
}

echo -e "${BLUE}=== dev-entry.sh 功能验证 ===${NC}"
echo ""

# 测试 1: help 命令显示新命令
echo "测试 1: help 命令包含新命令..."
if bash scripts/dev-entry.sh help 2>/dev/null | grep -q "all.*运行所有检查"; then
    log_pass "help 命令显示 'all' 命令"
else
    log_fail "help 命令未显示 'all' 命令"
fi

# 测试 2: preflight 命令
echo "测试 2: preflight 命令..."
if bash scripts/dev-entry.sh preflight 2>/dev/null | grep -q "检查通过\|错误: 0"; then
    log_pass "preflight 命令执行成功"
else
    log_fail "preflight 命令执行失败"
fi

# 测试 3: report 命令
echo "测试 3: report 命令..."
if bash scripts/dev-entry.sh report 2>/dev/null | grep -q "报告已生成"; then
    log_pass "report 命令执行成功"
    # 清理生成的报告
    rm -f docs/collab/chatgpt-lingxi/auto-change-report.md
else
    log_fail "report 命令执行失败"
fi

# 测试 4: all 命令（简短测试）
echo "测试 4: all 命令..."
if timeout 30 bash scripts/dev-entry.sh all 2>/dev/null | grep -q "检查\|完成"; then
    log_pass "all 命令执行成功"
else
    log_fail "all 命令执行失败或超时"
fi

# 测试 5: 旧命令兼容性
echo "测试 5: 旧命令兼容性..."
if bash scripts/dev-entry.sh status 2>/dev/null | grep -q "分支:"; then
    log_pass "status 命令仍正常工作"
else
    log_fail "status 命令异常"
fi

# 总结
echo ""
echo -e "${BLUE}=== 验证结果 ===${NC}"
echo -e "通过: ${GREEN}$PASS${NC}"
echo -e "失败: ${RED}$FAIL${NC}"
echo ""

if [ "$FAIL" -eq 0 ]; then
    echo -e "${GREEN}验证全部通过${NC}"
    exit 0
else
    echo -e "${RED}验证有失败项${NC}"
    exit 1
fi