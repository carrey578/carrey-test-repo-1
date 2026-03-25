# 主功能开发维护说明

> 面向开发者和维护者的技术指南

## 概述

**主功能**: 统一任务入口脚本  
**文件**: `scripts/dev-entry.sh` (Linux), `tools/dev-entry.ps1` (Windows)  
**依赖**: `scripts/lib-common.sh`

---

## 架构设计

### 文件结构

```
scripts/
├── dev-entry.sh          # 主入口（Linux）
├── lib-common.sh         # 公共函数库
├── check-dev-env-server.sh
├── preflight-check.sh
└── generate-change-report.sh

tools/
├── dev-entry.ps1         # 主入口（Windows）
└── ...
```

### 命令注册机制

```bash
# 定义命令列表
COMMANDS=(
    "check:运行开发环境检查"
    "status:显示仓库状态摘要"
    "docs:查看文档索引"
    "all:运行所有检查"
    "preflight:运行预提交检查"
    "report:生成变更报告"
    "help:显示帮助"
)

# 命令路由
case "$COMMAND" in
    check) cmd_check ;;
    status) cmd_status ;;
    docs) cmd_docs ;;
    ...
esac
```

---

## 添加新命令

### 步骤 1: 在 COMMANDS 数组添加条目

```bash
# 编辑 scripts/dev-entry.sh
COMMANDS=(
    ...
    "newcommand:新命令说明"
)
```

### 步骤 2: 添加命令处理函数

```bash
# 在文件末尾添加
cmd_newcommand() {
    echo "执行新命令逻辑"
}
```

### 步骤 3: 在 case 语句中添加路由

```bash
case "$COMMAND" in
    ...
    newcommand) cmd_newcommand ;;
esac
```

### 步骤 4: 更新文档

- `docs/main-feature-usage-guide.md`
- `docs/main-feature-verify-guide.md`
- `docs/main-feature-test-checklist.md`

---

## 修改现有命令

### 修改前检查

1. 查看当前实现: `grep -n "cmd_status" scripts/dev-entry.sh`
2. 了解调用链: `bash -x scripts/dev-entry.sh status 2>&1 | head -30`
3. 备份: `git diff scripts/dev-entry.sh > backup.patch`

### 修改后验证

```bash
# 必须通过
bash scripts/dev-entry.sh help           # 帮助正常
bash scripts/dev-entry.sh <command>       # 命令正常

# 建议通过
bash scripts/verify-main-feature.sh       # 完整验证
```

---

## 版本管理

### 提交规范

```
<type>: <description>

[optional body]
```

类型 (type):
- `feat`: 新功能
- `fix`: 修复
- `docs`: 文档
- `refactor`: 重构
- `test`: 测试

示例:
```bash
git commit -m "feat: 添加 newcommand 命令"
```

### 分支策略

- 开发分支: `chore/cursor-bootstrap`
- 提交后推送到 `origin-write`
- **禁止 force push**

---

## 测试与验证

### 本地验证

```bash
# 快速验证
bash scripts/verify-main-feature.sh --quick

# 完整验证
bash scripts/verify-main-feature.sh

# 回归检查
# 参考 docs/main-feature-regression-checklist.md
```

### 测试清单

- [ ] help 命令显示新命令
- [ ] 新命令执行正常
- [ ] 错误处理正常
- [ ] 文档已更新

---

## 常见维护任务

### 1. 添加依赖检查

```bash
# 在 cmd_check 中添加
check_dependency() {
    command -v git >/dev/null 2>&1 || {
        echo "错误: git 未安装"
        return 1
    }
}
```

### 2. 添加新输出格式

```bash
# 在 lib-common.sh 添加新函数
output_json() {
    echo '{"status":"ok"}'
}
```

### 3. 修改输出颜色

```bash
# 在 lib-common.sh 修改颜色定义
RED='\033[0;35m'  # 改为紫色
```

---

## 扩展方向

### 短期可扩展

| 方向 | 说明 |
|------|------|
| 增加命令 | 如 `git log`, `diff` 等 |
| 增强输出 | JSON/YAML 格式输出 |
| 参数增强 | 支持配置文件 |

### 长期可扩展

| 方向 | 说明 |
|------|------|
| 插件系统 | 支持自定义命令插件 |
| 多语言 | 支持 i18n |
| Web UI | 添加 web 管理界面 |

---

## 相关文件

| 文件 | 说明 |
|------|------|
| `scripts/dev-entry.sh` | 主入口 |
| `scripts/lib-common.sh` | 公共库 |
| `docs/main-feature-usage-guide.md` | 使用说明 |
| `docs/main-feature-verify-guide.md` | 验证指南 |

---

*本文档由灵犀自动生成*
