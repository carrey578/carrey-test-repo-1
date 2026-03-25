#!/bin/bash
# generate-status-report.sh - 自动化状态报告生成脚本
# 用法: bash scripts/generate-status-report.sh [--output <file>]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

# 默认输出文件
OUTPUT_FILE="${1:-docs/collab/chatgpt-lingxi/auto-status-report.md}"
OUTPUT_FILE="$REPO_ROOT/$OUTPUT_FILE"

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}ℹ${NC} $1"; }

log_info "开始生成状态报告..."

# 确保目录存在
mkdir -p "$(dirname "$OUTPUT_FILE")"

# 获取基本信息
BRANCH=$(git branch --show-current 2>/dev/null || echo "N/A")
COMMIT=$(git rev-parse --short HEAD 2>/dev/null || echo "N/A")
COMMIT_FULL=$(git rev-parse HEAD 2>/dev/null || echo "N/A")
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# 获取最近提交 (10条)
RECENT_COMMITS=$(git log --oneline -10 2>/dev/null || echo "无提交记录")

# 获取最近改动文件 (10个)
RECENT_CHANGES=$(git diff --name-status HEAD~10..HEAD 2>/dev/null || echo "无改动")

# 获取新增/修改的文档
DOC_CHANGES=$(git diff --name-status HEAD~10..HEAD 2>/dev/null | grep -E "^A|^M" | grep "\.md$" || echo "无")

# 获取脚本变动
SCRIPT_CHANGES=$(git diff --name-status HEAD~10..HEAD 2>/dev/null | grep -E "^A|^M" | grep -E "\.sh$|\.ps1$" || echo "无")

# 获取共享目录最新文档
SHARED_DOCS=$(ls -t docs/collab/chatgpt-lingxi/*.md 2>/dev/null | head -10 || echo "无")

# 生成报告
cat > "$OUTPUT_FILE" << EOF
# 自动状态报告

> 生成时间: $DATE
> 分支: $BRANCH
> 提交: $COMMIT

---

## 一、仓库状态

| 项目 | 值 |
|------|-----|
| 分支 | $BRANCH |
| 当前提交 | $COMMIT |
| 完整 Commit ID | $COMMIT_FULL |

---

## 二、最近提交 (10条)

$RECENT_COMMITS

---

## 三、最近改动文件 (10个)

$RECENT_CHANGES

---

## 四、文档变动

$DOC_CHANGES

---

## 五、脚本变动

$SCRIPT_CHANGES

---

## 六、共享目录最新文档

$(echo "$SHARED_DOCS" | while read f; do echo "- $f"; done)

---

## 七、相关脚本

| 脚本 | 说明 |
|------|------|
| \`scripts/generate-status-report.sh\` | 本报告生成脚本 |
| \`scripts/dev-entry-v2.sh\` | 统一开发入口 |
| \`scripts/verify-main-feature.sh\` | 功能验证脚本 |

---

## 八、建议操作

- [ ] Review 最近提交
- [ ] 检查新增/修改的文档
- [ ] 运行 verify 验证功能
- [ ] 准备 handoff（如需要）

---

*本报告由 generate-status-report.sh 自动生成*
EOF

log_info "报告已生成: $OUTPUT_FILE"

echo ""
echo "=== 报告摘要 ==="
echo "分支: $BRANCH"
echo "提交: $COMMIT"
echo "输出: $OUTPUT_FILE"
