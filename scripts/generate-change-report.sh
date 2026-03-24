#!/bin/bash
# generate-change-report.sh - 变更报告自动生成脚本 (Linux/服务器端)
# 用法: bash generate-change-report.sh [--output FILE]

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# 默认输出文件
OUTPUT_FILE="${1:-docs/collab/chatgpt-lingxi/auto-change-report.md}"

# 颜色定义
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

echo -e "${BLUE}=== 变更报告生成 ===${NC}"
echo ""

# 1. 获取最近一次 commit 信息
log_info "获取最近 commit 信息..."
COMMIT_HASH=$(git log -1 --format="%H")
COMMIT_SHORT=$(git log -1 --format="%h")
COMMIT_SUBJECT=$(git log -1 --format="%s")
COMMIT_AUTHOR=$(git log -1 --format="%an")
COMMIT_EMAIL=$(git log -1 --format="%ae")
COMMIT_DATE=$(git log -1 --format="%ci")
BRANCH=$(git branch --show-current)

# 2. 获取改动文件列表
log_info "获取改动文件..."
CHANGED_FILES=$(git diff --name-only HEAD~1 HEAD 2>/dev/null || git diff --name-only HEAD^ HEAD 2>/dev/null || echo "")
if [ -z "$CHANGED_FILES" ]; then
    # 如果没有上一 commit，则获取未 commit 的更改
    CHANGED_FILES=$(git diff --name-only)
    DIFF_TYPE="未提交更改"
else
    DIFF_TYPE="最近一次提交"
fi

# 3. 统计改动类型
ADDED_FILES=$(echo "$CHANGED_FILES" | grep "^A " || true)
MODIFIED_FILES=$(echo "$CHANGED_FILES" | grep "^M " || true)
DELETED_FILES=$(echo "$CHANGED_FILES" | grep "^D " || true)

# 4. 生成报告
log_info "生成报告..."

cat > "$OUTPUT_FILE" << EOF
# 变更报告 - $(date +%Y-%m-%d)

> 自动生成时间: $(date +"%Y-%m-%d %H:%M:%S")
> 仓库: carrey-test-repo-1
> 分支: $BRANCH

---

## 一、最近 Commit 信息

| 项目 | 值 |
|------|-----|
| Commit Hash | \`$COMMIT_SHORT\` (\`$COMMIT_HASH\`) |
| 提交标题 | $COMMIT_SUBJECT |
| 作者 | $COMMIT_AUTHOR |
| 邮箱 | $COMMIT_EMAIL |
| 提交时间 | $COMMIT_DATE |
| 所在分支 | $BRANCH |

---

## 二、改动文件列表

$DIFF_TYPE

\`\`\`
$CHANGED_FILES
\`\`\`

---

## 三、改动类型统计

| 类型 | 数量 |
|------|------|
| 新增 (Added) | $(echo "$CHANGED_FILES" | grep -c "^A " || echo 0) |
| 修改 (Modified) | $(echo "$CHANGED_FILES" | grep -c "^M " || echo 0) |
| 删除 (Deleted) | $(echo "$CHANGED_FILES" | grep -c "^D " || echo 0) |
| 总计 | $(echo "$CHANGED_FILES" | wc -l) |

---

## 四、建议 Review 点

基于改动内容，建议关注：

1. **脚本改动**：检查语法正确性
2. **文档改动**：检查内容完整性
3. **配置改动**：确认符合预期

---

## 五、Diff 摘要

\`\`\`bash
$(git diff --stat HEAD~1 HEAD 2>/dev/null || git diff --stat HEAD^ HEAD 2>/dev/null || echo "无历史 diff")
\`\`\`

---

## 六、验证建议

### 本地验证
\`\`\`bash
# 运行预提交检查
bash scripts/preflight-check.sh
\`\`\`

### 服务器验证
\`\`\`bash
# 运行开发环境检查
bash scripts/check-dev-env-server.sh
\`\`\`

---

## 七、Handoff 信息

| 项目 | 值 |
|------|-----|
| 生成时间 | $(date +"%Y-%m-%d %H:%M:%S") |
| 生成者 | 自动脚本 |
| 报告文件 | $OUTPUT_FILE |
| 下一步 | 人工 review 后可合并或继续开发 |

---

*本报告由 generate-change-report.sh 自动生成*
EOF

echo ""
log_info "报告已生成: $OUTPUT_FILE"
echo ""

# 显示报告内容摘要
echo -e "${GREEN}=== 报告摘要 ===${NC}"
echo "Commit: $COMMIT_SHORT - $COMMIT_SUBJECT"
echo "分支: $BRANCH"
echo "改动文件: $(echo "$CHANGED_FILES" | wc -l) 个"
echo "输出: $OUTPUT_FILE"
echo ""