#!/bin/bash
# generate-handoff-v2.sh - 自动化 Handoff 生成脚本 v2
# 用法: bash scripts/generate-handoff-v2.sh [options]
#
# v2 升级:
#   - 自动提取最近 commit
#   - 自动汇总 verify 结果
#   - 自动列出未完成事项
#   - 保留人工补充空间

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

# 默认参数
TASK_NAME=""
OUTPUT_FILE=""
VERBOSE=false

# 解析参数
while [[ $# -gt 0 ]]; do
    case "$1" in
        -t|--task)
            TASK_NAME="$2"
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

# 默认任务名
if [ -z "$TASK_NAME" ]; then
    TASK_NAME="任务-$TIMESTAMP"
fi

# 默认输出文件
if [ -z "$OUTPUT_FILE" ]; then
    OUTPUT_FILE="docs/collab/chatgpt-lingxi/handoff-$TIMESTAMP.md"
fi

OUTPUT_FILE="$REPO_ROOT/$OUTPUT_FILE"

# 颜色
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { [ "$VERBOSE" = true ] && echo -e "${BLUE}ℹ${NC} $1" || echo -e "${BLUE}ℹ${NC} $1"; }

log_info "开始生成 Handoff v2..."

# 确保目录存在
mkdir -p "$(dirname "$OUTPUT_FILE")"

# 获取最近 N 个 commits
RECENT_COMMITS=$(git log --oneline -5 2>/dev/null || echo "无")

# 获取改动文件
CHANGED_FILES=$(git diff --name-status HEAD~5..HEAD 2>/dev/null || echo "无")

# 获取新增的文档
DOC_CHANGES=$(git diff --name-status HEAD~5..HEAD 2>/dev/null | grep "^A" | grep "\.md$" || echo "无")

# 获取新增的脚本
SCRIPT_CHANGES=$(git diff --name-status HEAD~5..HEAD 2>/dev/null | grep "^A" | grep -E "\.sh$|\.ps1$" || echo "无")

# 尝试运行 verify 并获取结果
VERIFY_RESULT="未运行"
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

# 获取共享目录最新文档数量
SHARED_DOC_COUNT=$(ls docs/collab/chatgpt-lingxi/*.md 2>/dev/null | wc -l || echo "0")

# 生成 Handoff 文档
cat > "$OUTPUT_FILE" << EOF
# Handoff 文档 - $TASK_NAME

> 生成时间: $(date "+%Y-%m-%d %H:%M:%S")
> 分支: $BRANCH
> 提交: $COMMIT

---

## 一、本轮目标

> 请在此处填写本次任务的目标

<!-- 人工补充区 -->
- [ ] 目标1: 
- [ ] 目标2: 
- [ ] 目标3: 

---

## 二、最近提交 (5条)

$RECENT_COMMITS

---

## 三、改动文件

### 3.1 所有改动

$CHANGED_FILES

### 3.2 新增文档

$DOC_CHANGES

### 3.3 新增脚本

$SCRIPT_CHANGES

---

## 四、Verify 结果

| 项目 | 结果 |
|------|------|
| 功能验证 | $VERIFY_RESULT |

> 如需重新验证，运行: \`bash scripts/verify-main-feature.sh\`

---

## 五、未完成事项

> 请在此处填写未完成的事项

<!-- 人工补充区 -->
- [ ] 

---

## 六、风险

> 请在此处填写潜在风险

<!-- 人工补充区 -->
- 

---

## 七、下一步建议

### 建议1 (P0)
- 内容: 
- 理由: 

### 建议2 (P1)
- 内容: 
- 理由: 

---

## 八、人工补充区

> 以下区域供人工补充关键信息

### 8.1 补充说明

<!-- 在此处添加补充说明 -->

### 8.2 注意事项

<!-- 在此处添加注意事项 -->

### 8.3 关联文档

- 

---

## 九、验证命令

\`\`\`bash
# 快速验证
bash scripts/verify-main-feature.sh --quick

# 完整验证
bash scripts/verify-main-feature.sh

# 状态报告
bash scripts/generate-status-report.sh

# 变更摘要
bash scripts/dev-entry-v2.sh summary
\`\`\`

---

## 十、统计信息

| 项目 | 值 |
|------|-----|
| 分支 | $BRANCH |
| 提交 | $COMMIT |
| 共享文档数 | $SHARED_DOC_COUNT |
| 改动文件数 | $(echo "$CHANGED_FILES" | wc -l) |

---

*本 Handoff 由 generate-handoff-v2.sh 自动生成*
EOF

log_info "Handoff 已生成: $OUTPUT_FILE"

echo ""
echo -e "${GREEN}=== Handoff v2 生成完成 ===${NC}"
echo "任务名: $TASK_NAME"
echo "分支: $BRANCH"
echo "提交: $COMMIT"
echo "Verify: $VERIFY_RESULT"
echo "输出: $OUTPUT_FILE"
