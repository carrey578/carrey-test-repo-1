# 本地-服务器-共享目录联动说明

> 生成时间：2026-03-25 01:31 CST
> 执行者：灵犀
> 分支：chore/cursor-bootstrap

---

## 一、当前架构概览

```
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│   本地开发环境   │      │   服务器环境    │      │   GitHub 仓库   │
│   (你的电脑)    │ ───► │  (腾讯云服务器)  │ ───► │  (远程存储)      │
└─────────────────┘      └─────────────────┘      └─────────────────┘
        │                        │                        │
        ▼                        ▼                        ▼
   tools/ (本地脚本)       scripts/ (服务器脚本)      共享目录
   .ps1 脚本              .sh 脚本                 docs/collab/
                                                  chatgpt-lingxi/
```

---

## 二、各端职责

### 1. 本地开发环境 (你的电脑)

**位置**：`D:\dev\carrey-test-repo-1\` (Windows)

**职责**：
| 动作 | 说明 |
|------|------|
| 本地编辑 | 使用 Cursor/VSCode 编辑代码、文档 |
| 本地测试 | 运行 tools/*.ps1 脚本检查本地环境 |
| Git 操作 | 提交、推送代码到 GitHub |
| 手动检查 | 人工 review AI 生成的改动 |

**常用脚本**：
- `tools/check-dev-env-local.ps1` - 本地环境检查
- `tools/dev-entry.ps1` - 统一任务入口
- `tools/preflight-check.ps1` - 预提交检查
- `tools/generate-change-report.ps1` - 变更报告生成

---

### 2. 服务器环境 (腾讯云)

**位置**：`/root/workspace/repos/carrey-test-repo-1/` (Linux)

**职责**：
| 动作 | 说明 |
|------|------|
| 自动化执行 | 运行脚本、执行检查、生成报告 |
| 环境巡检 | 服务器状态检查、OpenClaw 监控 |
| 文档生成 | 灵犀在服务器侧生成报告和文档 |
| 仓库同步 | 从 GitHub 拉取最新代码 |

**常用脚本**：
- `scripts/check-dev-env-server.sh` - 服务器环境检查
- `scripts/dev-entry.sh` - 统一任务入口
- `scripts/preflight-check.sh` - 预提交检查
- `scripts/generate-change-report.sh` - 变更报告生成

---

### 3. 共享目录 (GitHub)

**位置**：`docs/collab/chatgpt-lingxi/` (AI 协作区)

**职责**：
| 动作 | 说明 |
|------|------|
| 任务文档 | 存储任务计划、报告、摘要 |
| 协作记录 | 记录任务流转、handoff 信息 |
| 索引维护 | 维护文档索引、模板库 |
| 信息接力 | 本地与服务器之间的信息桥梁 |

**常用文档**：
- `24-repo-health-check.md` - 仓库体检报告
- `25-dev-roadmap-for-agent.md` - 开发路线图
- `32-code-change-baseline-map.md` - 代码改动基线
- `33-*-change-plan.md` - 改动方案
- `34-*-change-summary.md` - 改动摘要

---

## 三、协作流程

### 场景 1：灵犀执行任务

```
人类下达任务
      │
      ▼
┌─────────────────┐
│  服务器侧执行   │ ← 灵犀在这里工作
│  scripts/       │
│  docs/         │
└─────────────────┘
      │
      ▼ 生成报告
┌─────────────────┐
│  写入共享目录   │
│  docs/collab/  │
│  chatgpt-lingxi/│
└─────────────────┘
      │
      ▼ 推送
┌─────────────────┐
│  GitHub 仓库   │
│  origin-write  │
└─────────────────┘
      │
      ▼ 拉取
┌─────────────────┐
│  本地可查看    │
│  git pull      │
└─────────────────┘
```

### 场景 2：本地人工 review

```
灵犀完成改动
      │
      ▼ 推送
┌─────────────────┐
│  GitHub 仓库   │
└─────────────────┘
      │
      ▼ 拉取
┌─────────────────┐
│  本地开发环境   │
│  git pull      │
└─────────────────┘
      │
      ▼ review
┌─────────────────┐
│  人工检查代码   │
│  决定是否合并   │
└─────────────────┘
```

---

## 四、脚本联动矩阵

| 任务类型 | 本地执行 | 服务器执行 | 生成位置 |
|----------|----------|------------|----------|
| 环境检查 | `tools/check-dev-env-local.ps1` | `scripts/check-dev-env-server.sh` | 终端输出 |
| 预提交检查 | `tools/preflight-check.ps1` | `scripts/preflight-check.sh` | 终端输出 |
| 变更报告 | `tools/generate-change-report.ps1` | `scripts/generate-change-report.sh` | docs/collab/ |
| 统一入口 | `tools/dev-entry.ps1` | `scripts/dev-entry.sh` | 终端输出 |

---

## 五、常用命令

### 本地 (Windows)

```powershell
# 环境检查
.\tools\check-dev-env-local.ps1

# 预提交检查
.\tools\preflight-check.ps1

# 生成变更报告
.\tools\generate-change-report.ps1

# 统一入口
.\tools\dev-entry.ps1 status
```

### 服务器 (Linux)

```bash
# 环境检查
bash scripts/check-dev-env-server.sh

# 预提交检查
bash scripts/preflight-check.sh

# 生成变更报告
bash scripts/generate-change-report.sh

# 统一入口
bash scripts/dev-entry.sh status
```

### Git 操作

```bash
# 拉取最新
git pull origin chore/cursor-bootstrap

# 推送改动
git push origin-write chore/cursor-bootstrap
```

---

## 六、信息接力规则

| 信息类型 | 存放位置 | 生命周期 |
|----------|----------|----------|
| 任务计划 | docs/collab/chatgpt-lingxi/*-plan.md | 任务期间 |
| 执行报告 | docs/collab/chatgpt-lingxi/*-summary.md | 任务完成后保留 |
| Handoff | docs/collab/chatgpt-lingxi/handoff-*.md | 交接后保留 |
| 模板 | docs/collab/chatgpt-lingxi/*-template.md | 长期 |
| 基线图 | docs/collab/chatgpt-lingxi/32-*.md | 长期 |

---

## 七、异常处理

| 场景 | 处理方式 |
|------|----------|
| 本地脚本失败 | 检查 PowerShell 版本，尝试更新执行策略 |
| 服务器脚本失败 | 检查 bash 环境，确认脚本有执行权限 |
| Git 推送失败 | 检查 SSH Key 权限，确认 origin-write 可用 |
| 仓库不同步 | 先 git fetch，再 git merge 或 rebase |

---

*本文档为联动说明 v1.0*