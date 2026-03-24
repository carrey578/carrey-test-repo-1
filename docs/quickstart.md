# Quickstart - 开发环境快速启动

> 最后更新：2026-03-24

## 当前仓定位

- **用途**：AI-first 高授权开发测试仓
- **仓库**：carrey578/carrey-test-repo-1
- **分支策略**：仅使用 `chore/cursor-bootstrap`

---

## 路径信息

| 环境 | 路径 |
|------|------|
| 本地 Windows | `D:\dev\carrey-test-repo-1` |
| 服务器 Linux | `/root/workspace/repos/carrey-test-repo-1` |
| GitHub | `github.com/carrey578/carrey-test-repo-1` |

---

## 本地启动（Windows）

### 1. 克隆仓库

```powershell
git clone git@github.com:carrey578/carrey-test-repo-1.git D:\dev\carrey-test-repo-1
```

### 2. 切换分支

```powershell
cd D:\dev\carrey-test-repo-1
git checkout chore/cursor-bootstrap
```

### 3. 运行本地检查

```powershell
.\tools\check-dev-env-local.ps1
```

### 4. 开始开发

- 用 Cursor 编辑代码
- 用 ChatGPT 做方案
- 用 Codex CLI 做分析

---

## 服务器启动（Linux）

### 1. 检查服务器环境

```bash
cd /root/workspace/repos/carrey-test-repo-1
bash scripts/check-dev-env-server.sh
```

### 2. 同步远端

```bash
git fetch origin
git checkout chore/cursor-bootstrap
git pull --ff-only origin chore/cursor-bootstrap
```

### 3. 执行任务

```bash
# 灵犀可执行的任务
# - 文档生成
# - 脚本编写
# - 轻量改动
# - 报告生成
```

### 4. 提交并推送

```bash
git add .
git commit -m "feat: xxx"
git push origin-write HEAD:chore/cursor-bootstrap
```

---

## 当前角色分工

| 角色 | 负责 |
|------|------|
| **人工** | 定目标、设边界、审核结果 |
| **灵犀** | 服务器执行、文档生成、脚本编写 |
| **Cursor** | 本地代码编辑 |
| **ChatGPT** | 方案、文档、状态整理 |
| **Codex CLI** | 代码分析、轻量任务 |

---

## 当前边界

### 允许

- 读整个仓库
- 修改 docs/tools/scripts/
- 在 chore/cursor-bootstrap 分支 commit/push
- 新建文档、脚本、辅助文件

### 不允许

- 推送到 main
- 修改 systemd
- 升级 OpenClaw
- 大范围代码重构

---

## 快速参考

| 内容 | 位置 |
|------|------|
| 环境总览 | docs/21-env-plan-2.0-brief.md |
| 文档索引 | docs/22-shared-docs-status-index.md |
| 开发路线图 | docs/25-dev-roadmap-for-agent.md |
| 灵犀工作清单 | docs/lingxi-working-backlog-v1.md |
