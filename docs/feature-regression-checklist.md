# 回归检查清单 - 统一入口功能

> 生成时间：2026-03-25 03:17 CST
> 执行者：灵犀
> 分支： chore/cursor-bootstrap

---

## 一、概述

本文档定义统一入口功能（dev-entry.sh）在**改动后**需要进行的关键检查项。

---

## 二、回归检查项

### 2.1 功能完整性检查

| # | 检查项 | 验证命令 | 预期结果 |
|---|--------|----------|----------|
| 1.1 | help 命令 | `bash scripts/dev-entry.sh help` | 显示所有命令和参数 |
| 1.2 | check 命令 | `bash scripts/dev-entry.sh check` | 调用 check-dev-env-server.sh |
| 1.3 | status 命令 | `bash scripts/dev-entry.sh status` | 显示仓库状态 |
| 1.4 | docs 命令 | `bash scripts/dev-entry.sh docs` | 显示文档索引 |
| 1.5 | handoff 命令 | `bash scripts/dev-entry.sh handoff` | 显示 handoff 模板 |
| 1.6 | reports 命令 | `bash scripts/dev-entry.sh reports` | 显示报告目录 |
| 1.7 | all 命令 | `bash scripts/dev-entry.sh all` | 依次执行检查 |
| 1.8 | preflight 命令 | `bash scripts/dev-entry.sh preflight` | 调用 preflight-check.sh |
| 1.9 | report 命令 | `bash scripts/dev-entry.sh report` | 生成变更报告 |

### 2.2 参数支持检查

| # | 检查项 | 验证命令 | 预期结果 |
|---|--------|----------|----------|
| 2.1 | --verbose | `bash scripts/dev-entry.sh -v check` | 输出包含 ⚡ 前缀 |
| 2.2 | --quiet | `bash scripts/dev-entry.sh -q check` | 只输出关键结果 |
| 2.3 | --help | `bash scripts/dev-entry.sh --help` | 同 help 命令 |
| 2.4 | 组合使用 | `bash scripts/dev-entry.sh -vq check` | 参数顺序不影响结果 |

### 2.3 输出格式检查

| # | 检查项 | 验证方式 | 预期结果 |
|---|--------|----------|----------|
| 3.1 | 颜色输出 | 执行命令观察 | 颜色正常显示 |
| 3.2 | 格式化 | 执行命令观察 | 缩进对齐正常 |
| 3.3 | 编码 | 执行命令观察 | 中文正常显示 |

### 2.4 错误处理检查

| # | 检查项 | 验证命令 | 预期结果 |
|---|--------|----------|----------|
| 4.1 | 未知命令 | `bash scripts/dev-entry.sh unknown` | 显示错误信息 |
| 4.2 | 空参数 | `bash scripts/dev-entry.sh` | 默认显示 help |
| 4.3 | 无效参数 | `bash scripts/dev-entry.sh --invalid` | 显示错误信息 |

### 2.5 依赖检查

| # | 检查项 | 验证方式 | 预期结果 |
|---|--------|----------|----------|
| 5.1 | lib-common.sh | 执行命令观察 | 正常引入，无报错 |
| 5.2 | 子脚本存在 | 执行命令观察 | 子脚本正常调用 |
| 5.3 | Git 可用 | 执行 status 命令 | 正常显示分支信息 |

---

## 三、检查频率

| 场景 | 建议检查 |
|------|----------|
| 代码改动后 | 全部检查 |
| 参数改动后 | 重点检查 2.x 项 |
| 子脚本改动后 | 重点检查 5.x 项 |
| 每周常规 | 抽查 1.x 项 |

---

## 四、自动化检查

可通过脚本自动执行部分检查：

```bash
# 快速回归检查
for cmd in help check status docs handoff reports all preflight report; do
    bash scripts/dev-entry.sh $cmd > /dev/null && echo "✓ $cmd" || echo "✗ $cmd"
done
```

---

*本文档为回归检查清单 v1.0*