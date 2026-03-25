#!/bin/bash
# generate-change-summary-v2.sh - 自动化 Change Summary 生成脚本 v2
# 用法: bash scripts/generate-change-summary-v2.sh [options]
#
# v2 升级:
#   - 自动提取最近 commit
#   - 自动分类改动文件
#   - 自动识别改动类型
#   - 生成适合 review 的摘要

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

# 默认参数
COUNT=5
OUTPUT_FILE=""
VERBOSE=false

# 解析参数
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

# 默认输出文件
if [ -z "$OUTPUT_FILE" ]; then
    OUTPUT_FILE="docs/collab/chatgpt-lingxi/change-summary-$TIMESTAMP.md"
fi

OUTPUT_FILE="$REPO_ROOT/$OUTPUT_FILE"

# 颜色
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

log_info() { echo -e "${BLUE}ℹ${NC} $1"; }

log_info "开始生成 Change Summary v2..."

# 确保目录存在
mkdir -p "$(dirname "$OUTPUT_FILE")"

# 获取最近 N 个 commits 详细信息
COMMITS_DETAIL=$(git log --oneline -$COUNT 2>/dev/null || echo "无")

# 获取改动文件及状态
CHANGES=$(git diff --name-status HEAD~$COUNT..HEAD 2>/dev/null || echo "无")

# 分类改动文件
ADDED_FILES=$(echo "$CHANGES" | grep "^A" | awk '{print "  - " $2}' || echo "  无")
MODIFIED_FILES=$(echo "$CHANGES" | grep "^M" | awk '{print "  - " $2}' || echo "  无")
DELETED_FILES=$(echo "$CHANGES" | grep "^D" | awk '{print "  - " $2}' || echo "  无")

# 统计各类文件
DOC_COUNT=$(echo "$CHANGES" | grep -E "\.md$" | wc -l)
SCRIPT_COUNT=$(echo "$CHANGES" | grep -E "\.(sh|ps1)$" | wc -l)
CONFIG_COUNT=$(echo "$CHANGES" | grep -E "\.(json|yaml|yml|toml)$" | wc -l)

# 获取每个 commit 的改动行数
COMMIT_STATS=$(git log --format="%h %s" -$COUNT 2>/dev/null | while read hash msg; do
    lines=$(git diff --stat $hash^..$hash 2>/dev/null | tail -1)
    echo "  - $hash: $lines"
done)

# 生成 Change Summary
cat > "$OUTPUT_FILE" << EOF
# Change Summary - 变更摘要

> 生成时间: $(date "+%Y-%m-%d %H:%M:%S")
> 分支: $BRANCH
> 范围: 最近 $COUNT 个提交

---

## 一、变更概览

| 项目 | 数量 |
|------|------|
| 提交数 | $COUNT |
| 新增文件 | $(echo "$CHANGES" | grep "^A" | wc -l) |
| 修改文件 | $(echo "$CHANGES" | grep "^M" | wc -l) |
| 删除文件 | $(echo "$CHANGES" | grep "^D" | wc -l) |
| 文档变动 | $DOC_COUNT |
| 脚本变动 | $SCRIPT_COUNT |
| 配置变动 | $CONFIG_COUNT |

---

## 二、最近提交

$COMMITS_DETAIL

---

## 三、改动详情

### 3.1 新增文件

$ADDED_FILES

### 3.2 修改文件

$MODIFIED_FILES

### 3.3 删除文件

$DELETED_FILES

---

## 四、按类型统计

| 类型 | 数量 |
|------|------|
| 文档 (.md) | $DOC_COUNT |
| 脚本 (.sh/.ps1) | $SCRIPT_COUNT |
| 配置 (.json/.yaml) | $CONFIG_COUNT |

---

## 五、Review 建议

> 请 review 以下重点

- [ ] 检查新增文档内容是否完整
- [ ] 检查新增脚本是否有执行权限
- [ ] 检查配置变更是否影响现有功能
- [ ] 验证脚本可正常执行

---

## 六、验证命令

\`\`\`bash
# 快速验证
bash scripts/verify-main-feature.sh --quick

# 状态报告
bash scripts/generate-status-report.sh

# Handoff
bash scripts/generate-handoff-v2.sh
\`\`\`

---

*本 Change Summary 由 generate-change-summary-v2.sh 自动生成*
EOF

log_info "Change Summary 已生成: $OUTPUT_FILE"

echo ""
echo -e "${GREEN}=== Change Summary v2 生成完成 ===${NC}"
echo "分支: $BRANCH"
echo "提交数: $COUNT"
echo "新增: $(echo "$CHANGES" | grep "^A" | wc -l) 个"
echo "修改: $(echo "$CHANGES" | grep "^M" | wc -l) 个"
echo "输出: $OUTPUT_FILE"
