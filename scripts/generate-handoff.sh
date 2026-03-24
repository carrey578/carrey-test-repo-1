#!/bin/bash
# generate-handoff.sh - Handoff 文档生成脚本 (Linux/服务器端)
# 用法: bash generate-handoff.sh [task-id]

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# 默认输出目录
OUTPUT_DIR="docs/collab/chatgpt-lingxi"

# 生成时间
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
TASK_ID="${1:-TASK-$TIMESTAMP}"

# 输出文件
OUTPUT_FILE="$OUTPUT_DIR/handoff-$TASK_ID.md"

# 颜色定义
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# 获取最近 commit 信息
COMMIT_HASH=$(git log -1 --format="%h" 2>/dev/null || echo "N/A")
COMMIT_SUBJECT=$(git log -1 --format="%s" 2>/dev/null || echo "N/A")
BRANCH=$(git branch --show-current 2>/dev/null || echo "N/A")

# 获取改动文件
CHANGED_FILES=$(git diff --name-only HEAD~1 HEAD 2>/dev/null | head -10 || echo "无")

log_info "生成 Handoff 文档..."

cat > "$OUTPUT_FILE" << EOF
# Handoff 文档 - $TASK_ID

> 生成时间: $(date +"%Y-%m-%d %H:%M:%S")
> 分支: $BRANCH

---

## 一、任务信息

| 项目 | 值 |
|------|-----|
| 任务 ID | $TASK_ID |
| 生成时间 | $(date +"%Y-%m-%d %H:%M:%S") |
| 生成者 | 灵犀 (自动脚本) |
| 当前分支 | $BRANCH |

---

## 二、最近 Commit

| 项目 | 值 |
|------|-----|
| Commit | $COMMIT_HASH |
| 标题 | $COMMIT_SUBJECT |

---

## 三、改动文件

\`\`\`
$CHANGED_FILES
\`\`\`

---

## 四、工作摘要

> 请在此处填写本次任务的工作摘要

- [ ] 任务目标：???
- [ ] 完成情况：???
- [ ] 遗留问题：???
- [ ] 下一步建议：???

---

## 五、交接说明

### 已完成
-

### 待跟进
-

### 注意事项
-

---

## 六、Review 建议

| 检查项 | 状态 |
|--------|------|
| 代码语法 | ⬜ 待检查 |
| 文档完整性 | ⬜ 待检查 |
| 脚本可执行性 | ⬜ 待检查 |
| 符合任务目标 | ⬜ 待检查 |

---

## 七、验证命令

\`\`\`bash
# 服务器端验证
bash scripts/preflight-check.sh
bash scripts/check-dev-env-server.sh

# 本地端验证
.\tools\preflight-check.ps1
.\tools\check-dev-env-local.ps1
\`\`\`

---

## 八、联系方式

如有问题，请通过以下方式联系：

- Feishu: 孟安然
- GitHub Issue: (如适用)

---

*本 Handoff 由 generate-handoff.sh 自动生成*
EOF

log_info "Handoff 文档已生成: $OUTPUT_FILE"
echo ""
echo -e "${GREEN}=== 生成完成 ===${NC}"
echo "任务 ID: $TASK_ID"
echo "输出文件: $OUTPUT_FILE"
echo ""