# 功能使用说明 - 脚本联动调用

> 生成时间：2026-03-25 01:57 CST
> 执行者：灵犀
> 分支： chore/cursor-bootstrap

---

## 一、功能概述

**功能名称**：脚本联动调用（统一入口增强）

**解决问题**：
- 此前需要分别调用多个脚本，步骤繁琐
- 用户不知道先运行哪个、后运行哪个
- 现在只需一个命令，自动按顺序调用多个脚本

---

## 二、功能入口

| 平台 | 入口脚本 |
|------|----------|
| Linux/服务器 | `scripts/dev-entry.sh` |
| Windows/本地 | `tools/dev-entry.ps1` |

---

## 三、如何使用

### 3.1 基本命令

```bash
# Linux/服务器端
bash scripts/dev-entry.sh <command>

# Windows/本地端
.\tools\dev-entry.ps1 <command>
```

### 3.2 可用命令

| 命令 | 功能 | 适用场景 |
|------|------|----------|
| `check` | 运行开发环境检查 | 日常检查 |
| `status` | 显示仓库状态摘要 | 快速查看状态 |
| `docs` | 查看文档索引 | 找文档时 |
| `handoff` | 生成 handoff 入口 | 交接工作时 |
| `reports` | 检查报告目录 | 检查报告时 |
| `all` | 运行所有检查 | 提交前全面检查 |
| `preflight` | 运行预提交检查 | 提交前快速检查 |
| `report` | 生成变更报告 | 完成后生成报告 |
| `help` | 显示帮助 | 忘记命令时 |

### 3.3 使用示例

**场景 1：提交前全面检查**
```bash
# Linux
bash scripts/dev-entry.sh all
```
输出：依次执行 check → preflight → status

**场景 2：生成变更报告**
```bash
# Linux
bash scripts/dev-entry.sh report
```
输出：在 `docs/collab/chatgpt-lingxi/auto-change-report.md` 生成报告

**场景 3：快速了解仓库状态**
```bash
# Linux
bash scripts/dev-entry.sh status
```
输出：分支、远程、提交、文件统计

---

## 四、输入输出

### 输入

| 输入 | 说明 | 默认值 |
|------|------|--------|
| 命令参数 | 如 `all`, `report` 等 | `help` |

### 输出

| 命令 | 输出位置 |
|------|----------|
| 大部分命令 | 终端输出 |
| `report` | `docs/collab/chatgpt-lingxi/auto-change-report.md` |

---

## 五、常见失败情况

### 5.1 权限问题

**问题**：脚本无执行权限
```
bash: scripts/dev-entry.sh: Permission denied
```

**解决**：
```bash
chmod +x scripts/dev-entry.sh
```

### 5.2 路径问题

**问题**：不在仓库根目录执行
```
fatal: not a git repository
```

**解决**：
```bash
cd /root/workspace/repos/carrey-test-repo-1
# 或
cd D:\dev\carrey-test-repo-1
```

### 5.3 子脚本缺失

**问题**：调用的子脚本不存在
```
bash: scripts/preflight-check.sh: No such file or directory
```

**解决**：确认仓库结构完整，必要时重新 clone

### 5.4 PowerShell 执行策略（Windows）

**问题**：
```
cannot be loaded because running scripts is disabled
```

**解决**：
```powershell
Set-ExecutionPolicy -RemoteSigned -Scope Process
```

---

## 六、后续可扩展点

1. **增加更多联动命令**：如 `sync` 自动拉取最新
2. **增加日志输出**：同时写入日志文件
3. **增加错误处理**：更友好的错误信息
4. **增加配置文件**：通过 JSON 配置默认行为

---

## 七、相关文档

| 文档 | 说明 |
|------|------|
| `docs/feature-dev-notes.md` | 开发者说明 |
| `docs/feature-verify-guide.md` | 验证说明 |
| `docs/collab/chatgpt-lingxi/41-feature-mvp-summary.md` | MVP 实现摘要 |
| `docs/collab/chatgpt-lingxi/42-feature-verification-report.md` | 验证报告 |

---

*本文档为功能使用说明 v1.0*