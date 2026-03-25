# 主功能最小回归检查清单

> 每次改动后必须执行的快速复查清单

## 概述

**主功能**: `dev-entry.sh` / `dev-entry.ps1`  
**用途**: 统一任务入口脚本  
**适用场景**: 代码修改、配置调整、环境变更后的快速复查

---

## 关键点确认

| 关键点 | 说明 | 优先级 |
|--------|------|--------|
| 入口脚本可执行 | `dev-entry.sh` 有执行权限 | P0 |
| help 命令正常 | 显示所有命令列表 | P0 |
| 核心命令可用 | status/check/docs/all/preflight | P0 |
| 依赖库存在 | `lib-common.sh` 存在且可加载 | P0 |
| 文档同步 | 文档描述与实际命令一致 | P1 |

---

## 回归检查清单

### P0 - 必须通过（阻塞级）

| 序号 | 检查项 | 验证方法 | 预期结果 |
|------|--------|----------|----------|
| P0-1 | 入口脚本可执行 | `bash scripts/dev-entry.sh -h` | 显示帮助，无权限错误 |
| P0-2 | help 命令 | `bash scripts/dev-entry.sh help` | 显示"开发任务统一入口" |
| P0-3 | status 命令 | `bash scripts/dev-entry.sh status` | 显示分支名 |
| P0-4 | check 命令 | `bash scripts/dev-entry.sh check` | 显示检查结果 |
| P0-5 | docs 命令 | `bash scripts/dev-entry.sh docs` | 显示文档索引 |
| P0-6 | all 命令 | `bash scripts/dev-entry.sh all` | 执行多个检查 |
| P0-7 | preflight 命令 | `bash scripts/dev-entry.sh preflight` | 显示预检结果 |
| P0-8 | 依赖库可加载 | `source scripts/lib-common.sh` | 无错误输出 |

### P1 - 建议通过（重要级）

| 序号 | 检查项 | 验证方法 | 预期结果 |
|------|--------|----------|----------|
| P1-1 | report 命令 | `bash scripts/dev-entry.sh report` | 生成报告文件 |
| P1-2 | handoff 命令 | `bash scripts/dev-entry.sh handoff` | 显示 handoff 信息 |
| P1-3 | reports 命令 | `bash scripts/dev-entry.sh reports` | 显示报告目录 |
| P1-4 | verbose 模式 | `bash scripts/dev-entry.sh -v status` | 输出包含详细调试信息 |
| P1-1 | 安静模式 | `bash scripts/dev-entry.sh -q status` | 输出精简 |
| P1-6 | 错误处理 | `bash scripts/dev-entry.sh unknown` | 显示错误提示 |

### P2 - 可选通过（增强级）

| 序号 | 检查项 | 验证方法 | 预期结果 |
|------|--------|----------|----------|
| P2-1 | 快捷参数 -h | `bash scripts/dev-entry.sh -h` | 同 help |
| P2-2 | 快捷参数 -v | `bash scripts/dev-entry.sh -v` | verbose |
| P2-3 | 长参数 --help | `bash scripts/dev-entry.sh --help` | 同 help |

---

## 快速回归脚本

### 自动执行（P0 + P1）

```bash
#!/bin/bash
# quick-regression-check.sh - 快速回归检查

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASS=0
FAIL=0

check() {
    local name="$1"
    local cmd="$2"
    local expect="$3"
    
    if eval "$cmd" 2>&1 | grep -q "$expect"; then
        echo -e "${GREEN}✓${NC} $name"
        ((PASS++))
    else
        echo -e "${RED}✗${NC} $name"
        ((FAIL++))
    fi
}

echo "=== 主功能回归检查 ==="
echo ""

# P0 必须检查
echo "--- P0 阻塞级 ---"
check "P0-1 help" "bash scripts/dev-entry.sh help" "开发任务统一入口"
check "P0-2 status" "bash scripts/dev-entry.sh status" "分支:"
check "P0-3 check" "bash scripts/dev-entry.sh check" "检查"
check "P0-4 docs" "bash scripts/dev-entry.sh docs" "文档"
check "P0-5 preflight" "bash scripts/dev-entry.sh preflight" "检查"
check "P0-6 依赖库" "source scripts/lib-common.sh && echo OK" "OK"

# P1 重要检查
echo ""
echo "--- P1 重要级 ---"
check "P1-1 error handling" "bash scripts/dev-entry.sh unknown 2>&1" "未知\|错误\|help"

echo ""
echo "=== 结果: 通过 $PASS, 失败 $FAIL ==="

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}✅ 回归检查通过${NC}"
    exit 0
else
    echo -e "${RED}❌ 回归检查失败${NC}"
    exit 1
fi
```

### 使用方法

```bash
# 保存到 scripts/quick-regression-check.sh
# 添加执行权限
chmod +x scripts/quick-regression-check.sh

# 执行快速回归
bash scripts/quick-regression-check.sh
```

---

## 文档同步检查

每次修改命令后，必须检查以下文档是否同步更新：

| 文档 | 检查点 |
|------|--------|
| `docs/main-feature-verify-guide.md` | 命令列表是否完整 |
| `docs/main-feature-test-checklist.md` | 测试项是否覆盖新命令 |
| `scripts/dev-entry.sh` 的 help | 描述是否准确 |

---

## 回归检查流程

```
改动代码
    ↓
执行 quick-regression-check.sh
    ↓
┌─────────────────────────────────────┐
│  全部通过？                          │
│    ├─ 是 → 继续测试/提交            │
│    └─ 否 → 修复问题后重新检查        │
└─────────────────────────────────────┘
```

---

## 相关文件

| 文件 | 说明 |
|------|------|
| `scripts/dev-entry.sh` | 主入口脚本 |
| `scripts/lib-common.sh` | 公共函数库 |
| `docs/main-feature-verify-guide.md` | 验证指南 |
| `docs/main-feature-test-checklist.md` | 测试清单 |

---

*本文档由灵犀自动生成*
