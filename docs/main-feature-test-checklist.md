# 主功能最小测试清单

> 用于人工和 AI 助手复查主功能（dev-entry）的正确性

## 概述

**主功能**: `dev-entry.sh` (Linux) / `dev-entry.ps1` (Windows)  
**用途**: 统一任务入口脚本

---

## 测试清单

### 类别 A: 正常路径测试

| 序号 | 测试项 | 输入 | 操作 | 预期结果 |
|------|--------|------|------|----------|
| A1 | help 命令 | 无 | `bash scripts/dev-entry.sh help` | 显示帮助信息，包含所有命令列表 |
| A2 | status 命令 | 无 | `bash scripts/dev-entry.sh status` | 显示分支名、提交状态等信息 |
| A3 | check 命令 | 无 | `bash scripts/dev-entry.sh check` | 显示开发环境检查结果 |
| A4 | docs 命令 | 无 | `bash scripts/dev-entry.sh docs` | 显示文档索引或导航信息 |
| A5 | all 命令 | 无 | `bash scripts/dev-entry.sh all` | 依次执行 check/preflight/status |
| A6 | preflight 命令 | 无 | `bash scripts/dev-entry.sh preflight` | 显示预提交检查结果 |
| A7 | report 命令 | 无 | `bash scripts/dev-entry.sh report` | 生成变更报告文件 |
| A8 | handoff 命令 | 无 | `bash scripts/dev-entry.sh handoff` | 生成或显示 handoff 信息 |
| A9 | reports 命令 | 无 | `bash scripts/dev-entry.sh reports` | 显示报告目录或列表 |
| A10 | verbose 模式 | `--verbose` | `bash scripts/dev-entry.sh -v status` | 输出包含详细调试信息 |

---

### 类别 B: 常见失败路径测试

| 序号 | 测试项 | 输入 | 操作 | 预期结果 |
|------|--------|------|------|----------|
| B1 | 未知命令 | `unknown` | `bash scripts/dev-entry.sh unknown` | 显示错误信息，提示可用命令 |
| B2 | 错误参数 | `--invalid` | `bash scripts/dev-entry.sh --invalid` | 显示错误信息或帮助 |
| B3 | 损坏的公共库 | 模拟 lib-common.sh 缺失 | 删除 lib-common.sh 后执行 | 显示依赖错误信息 |

---

### 类别 C: 空输入与异常输入测试

| 序号 | 测试项 | 输入 | 操作 | 预期结果 |
|------|--------|------|------|----------|
| C1 | 空命令 | 空字符串 | `bash scripts/dev-entry.sh ""` | 显示帮助信息或默认行为 |
| C2 | 纯空格参数 | 空格 | `bash scripts/dev-entry.sh " "` | 显示帮助或忽略 |
| C3 | 特殊字符 | `$PATH` | `bash scripts/dev-entry.sh $PATH` | 安全处理，不泄露敏感信息 |
| C4 | 路径注入 | `../etc/passwd` | `bash scripts/dev-entry.sh ../docs` | 正确限制在工作区内 |

---

### 类别 D: 输出结果存在性测试

| 序号 | 测试项 | 输入 | 操作 | 预期结果 |
|------|--------|------|------|----------|
| D1 | report 生成 | report | `bash scripts/dev-entry.sh report` 后检查 | `docs/collab/chatgpt-lingxi/` 下生成报告文件 |
| D2 | 日志输出 | 任意命令 | 执行命令 | 输出包含必要信息（分支、状态等） |
| D3 | 错误输出 | 错误命令 | `bash scripts/dev-entry.sh invalid` | 错误信息输出到 stderr |

---

### 类别 E: 兼容性测试

| 序号 | 测试项 | 输入 | 操作 | 预期结果 |
|------|--------|------|------|----------|
| E1 | 快捷参数 -h | `-h` | `bash scripts/dev-entry.sh -h` | 同 help 命令 |
| E2 | 快捷参数 -v | `-v` | `bash scripts/dev-entry.sh -v` | verbose 模式 |
| E3 | 快捷参数 -q | `-q` | `bash scripts/dev-entry.sh -q status` | 安静模式输出 |
| E4 | 长参数 --help | `--help` | `bash scripts/dev-entry.sh --help` | 同 help 命令 |

---

## 快速执行脚本

### 自动执行清单 (Linux)

```bash
#!/bin/bash
# run-test-checklist.sh - 自动执行测试清单

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

PASS=0
FAIL=0

test_cmd() {
    local name="$1"
    local cmd="$2"
    local expect="$3"
    
    if eval "$cmd" 2>/dev/null | grep -q "$expect"; then
        echo -e "${GREEN}✓${NC} $name"
        ((PASS++))
    else
        echo -e "${RED}✗${NC} $name"
        ((FAIL++))
    fi
}

echo "=== 执行主功能测试清单 ==="
echo ""

# A类 - 正常路径
test_cmd "A1 help" "bash scripts/dev-entry.sh help" "开发任务统一入口"
test_cmd "A2 status" "bash scripts/dev-entry.sh status" "分支:"
test_cmd "A3 check" "bash scripts/dev-entry.sh check" "检查"
test_cmd "A4 docs" "bash scripts/dev-entry.sh docs" "文档"
test_cmd "A6 preflight" "bash scripts/dev-entry.sh preflight" "检查"
test_cmd "A9 reports" "bash scripts/devploy.sh reports" "报告"

# B类 - 失败路径
test_cmd "B1 未知命令" "bash scripts/dev-entry.sh unknown 2>&1" "未知\|错误"

# E类 - 兼容性
test_cmd "E1 -h 参数" "bash scripts/dev-entry.sh -h" "开发任务统一入口"
test_cmd "E2 -v 参数" "bash scripts/dev-entry.sh -v status" "分支:"

echo ""
echo "=== 结果: 通过 $PASS, 失败 $FAIL ==="
```

---

## 测试通过标准

- **A 类测试**: 必须全部通过 (10/10)
- **B 类测试**: 至少通过 2/3
- **C 类测试**: 至少通过 2/4
- **D 类测试**: 必须全部通过 (3/3)
- **E 类测试**: 必须全部通过 (4/4)

**总体**: 至少 17/21 项通过

---

## 相关文件

| 文件 | 说明 |
|------|------|
| `scripts/dev-entry.sh` | Linux 主入口 |
| `tools/dev-entry.ps1` | Windows 主入口 |
| `scripts/lib-common.sh` | 公共函数库 |
| `docs/main-feature-verify-guide.md` | 验证指南 |

---

*本文档由灵犀自动生成*
