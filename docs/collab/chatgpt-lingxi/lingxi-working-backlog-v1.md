# 灵犀可持续工作清单 V1

> 适用阶段：AI-first 高授权开发期
> 最后更新：2026-03-24

---

## 概述

本清单定义了适合长期交给灵犀持续承担的工作内容，按类别组织。

---

## 1. 仓库巡检

| 项目 | 内容 |
|------|------|
| **具体能做什么** | 检查分支状态、工作区是否干净、关键目录是否存在 |
| **适合什么时候做** | 每次任务开始前 |
| **输出到哪里** | docs/collab/chatgpt-lingxi/xx-repo-health-check.md |
| **自动化建议** | 中（可复用 check-dev-env-server.sh） |

**典型命令**：
```bash
bash scripts/check-dev-env-server.sh
```

---

## 2. docs 维护

| 项目 | 内容 |
|------|------|
| **具体能做什么** | 更新状态文档、补充会议记录、维护索引文档 |
| **适合什么时候做** | 有新进展、新决策时 |
| **输出到哪里** | docs/collab/chatgpt-lingxi/ |
| **自动化建议** | 低（需人工判断内容） |

**常见任务**：
- 更新 21-env-plan-2.0-brief.md
- 更新 22-shared-docs-status-index.md
- 补充新的状态/决策文档

---

## 3. tools/scripts 补齐

| 项目 | 内容 |
|------|------|
| **具体能做什么** | 编写新的检查脚本、自动化脚本、辅助工具 |
| **适合什么时候做** | 发现重复性人工操作时 |
| **输出到哪里** | tools/ 或 scripts/ |
| **自动化建议** | 高（本身就是自动化） |

**常见任务**：
- 新建本地/服务器检查脚本
- 补充 README
- 创建辅助脚本

---

## 4. 轻量改动

| 项目 | 内容 |
|------|------|
| **具体能做什么** | 修改 README、补充文档、调整目录结构、小范围代码调整 |
| **适合什么时候做** | 人工确认后 |
| **输出到哪里** | 相应目录 + docs/collab/chatgpt-lingxi/change-*.md |
| **自动化建议** | 低（需人工确认） |

**边界**：
- 不改 main
- 不改 systemd
- 不升级 OpenClaw
- 仅在 chore/cursor-bootstrap 分支

---

## 5. diff 摘要

| 项目 | 内容 |
|------|------|
| **具体能做什么** | 读取 git diff，生成人类可读的改动摘要 |
| **适合什么时候做** | 每次 commit 后 |
| **输出到哪里** | docs/collab/chatgpt-lingxi/xx-diff-summary.md |
| **自动化建议** | 中（可开发脚本自动提取） |

**典型命令**：
```bash
git diff --stat
git diff HEAD~1
```

---

## 6. handoff 写作

| 项目 | 内容 |
|------|------|
| **具体能做什么** | 生成任务交接文档，说明本轮完成、下一步建议、待确认事项 |
| **适合什么时候做** | 任务需要交接或暂停时 |
| **输出到哪里** | docs/collab/chatgpt-lingxi/handoff-*.md |
| **自动化建议** | 中（基于模板生成） |

**使用模板**：
- handoff-template-v1.md

---

## 7. 执行报告

| 项目 | 内容 |
|------|------|
| **具体能做什么** | 生成任务执行报告，包含执行摘要、产出文件、commit id |
| **适合什么时候做** | 每个任务完成后 |
| **输出到哪里** | docs/collab/chatgpt-lingxi/report-*.md |
| **自动化建议** | 高（模板固定） |

**使用模板**：
- report-template.md

---

## 8. 开发辅助自动化

| 项目 | 内容 |
|------|------|
| **具体能做什么** | 根据人工需求，开发新的自动化脚本、辅助工具 |
| **适合什么时候做** | 人工提出需求时 |
| **输出到哪里** | tools/ 或 scripts/ |
| **自动化建议** | 高（本身就是自动化目标） |

**常见任务**：
- 自动生成文档索引
- 自动检查文档格式
- 自动同步远端

---

## 工作优先级建议

| 优先级 | 类别 | 频率 |
|--------|------|------|
| 1 | 仓库巡检 | 每次任务前 |
| 2 | 执行报告 | 每次任务后 |
| 3 | handoff 写作 | 需要交接时 |
| 4 | docs 维护 | 有新内容时 |
| 5 | diff 摘要 | 每次 commit 后 |
| 6 | tools/scripts 补齐 | 发现需求时 |
| 7 | 开发辅助自动化 | 人工提出时 |
| 8 | 轻量改动 | 人工确认后 |

---

## 快速启动命令

```bash
# 1. 巡检
bash scripts/check-dev-env-server.sh

# 2. 同步远端
git fetch origin && git checkout chore/cursor-bootstrap && git pull --ff-only origin chore/cursor-bootstrap

# 3. 执行任务...
# 4. 生成报告...
# 5. commit && push
git add . && git commit -m "feat: xxx" && git push origin-write HEAD:chore/cursor-bootstrap
```
