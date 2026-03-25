#!/bin/bash
# generate-regression-summary.sh - 自动化回归汇总脚本
# 用法: bash scripts/generate-regression-summary.sh [options]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

# 解析参数
COUNT=5
OUTPUT_FILE=""
VERBOSE=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -n|--count)
            COUNT="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# 默认值
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BRANCH=$(git branch --show-current 2>/dev/null || echo "N/A")
COMMIT=$(git rev-parse --short HEAD 2>/dev/null || echo "N/A")

if [ -z "$OUTPUT_FILE" ]; then
    OUTPUT_FILE="docs/collab/chatgpt-lingxi/regression-summary-$TIMESTAMP.md"
fi
OUTPUT_FILE="$REPO_ROOT/$OUTPUT_FILE"

# 确保目录存在
mkdir -p "$(dirname "$OUTPUT_FILE")"

log_info() { echo -e "${BLUE}ℹ${NC} $1"; }

log_info "开始生成回归汇总..."

# 运行 verify
VERIFY_RESULT="未运行"
VERIFY_OUTPUT=""
if [ -f "$SCRIPT_DIR/verify-main-feature.sh" ]; then
    log_info "运行 verify..."
    VERIFY_OUTPUT=$(bash "$SCRIPT_DIR/verify-main-feature.sh" --quick 2>&1 || true)
    if echo "$VERIFY_OUTPUT" | grep -q "验证通过"; then
        VERIFY_RESULT="✅ 通过"
    elif echo "$VERIFY_OUTPUT" | grep -q "验证失败"; then
        VERIFY_RESULT="❌ 失败"
    else
        VERIFY_RESULT="⚠️ 部分通过"
    fi
fi

# 获取最近改动
RECENT_CHANGES=$(git diff --name-status HEAD~$COUNT..HEAD 2>/dev/null || echo "无")

# 识别风险文件
RISK_FILES=""
for file in $(git diff --name-only HEAD~$COUNT..HEAD 2>/dev/null); do
    case "$file" in
        *.sh|*.ps1)
            RISK_FILES="$RISK_FILES\n  - $file (脚本，可能影响功能)" ;;
        lib-common.sh)
            RISK_FILES="$RISK_FILES\n  - $file (公共库，影响范围大)" ;;
        *.md)
            RISK_FILES="$RISK_FILES\n  - $file (文档，风险较低)" ;;
    esac
done

# 评估是否建议继续
SUGGESTION="✅ 建议继续"
if echo "$VERIFY_RESULT" | grep -q "失败"; then
    SUGGESTION="❌ 不建议继续，需先修复 verify 失败项"
elif echo "$VERIFY_RESULT" | grep -q "部分"; then
    SUGGESTION="⚠️ 建议检查失败项后再继续"
fi

# 生成汇总
cat > "$OUTPUT_FILE" << EOF
# 回归汇总报告

> 生成时间: $(date "+%Y-%m-%d %H:%M:%S")
> 分支: $BRANCH
> 提交: $COMMIT

---

## 一、执行摘要

| 项目 | 状态 |
|------|------|
| Verify 结果 | $VERIFY_RESULT |
| 最近改动 | $COUNT 个提交 |
| 建议 | $SUGGESTION |

---

## 二、Verify 结果

\`\`\`
$VERIFY_OUTPUT
\`\`\`

---

## 三、最近改动 ($COUNT 个提交)

$RECENT_CHANGES

---

## 四、风险点识别

$RISK_FILES

---

## 五、建议

### 5.1 是否继续下一轮改动

$SUGGESTION

### 5.2 注意事项

- [ ] 检查新增/修改的脚本是否正常工作
- [ ] 验证公共库改动是否影响其他脚本
- [ ] 确认文档更新是否完整

---

## 六、验证命令

\`\`\`bash
# 快速验证
bash scripts/verify-main-feature.sh --quick

# 完整验证
bash scripts/verify-main-feature.sh

# 变更摘要
bash scripts/generate-change-summary-v2.sh -n $COUNT
\`\`\`

---

*本报告由 generate-regression-summary.sh 自动生成*
EOF

log_info "回归汇总已生成: $OUTPUT_FILE"

echo ""
echo "=== 回归汇总生成完成 ==="
echo "分支: $BRANCH"
echo "提交: $COMMIT"
echo "Verify: $VERIFY_RESULT"
echo "建议: $SUGGESTION"
echo "输出: $OUTPUT_FILE"
