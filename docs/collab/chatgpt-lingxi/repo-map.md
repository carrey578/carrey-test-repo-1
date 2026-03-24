# 仓库地图

> 生成时间：2026-03-24
> 用途：帮助 AI 和人工快速理解仓库结构

---

## 顶层视图

```
carrey-test-repo-1/
├── 📁 docs/                 # 项目文档
│   └── 📁 collab/
│       └── 📁 chatgpt-lingxi/  ← AI 协作主目录
├── 📁 scripts/              # 自动化脚本
├── 📁 shared-for-ai/         # AI 输出（暂用）
├── 📁 tools/                 # 开发工具
├── 📄 README.dev.md          # 开发启动说明
├── 📄 README.local.md
└── 📄 README.ssh-check.md
```

---

## 目录功能矩阵

| 目录 | 功能 | 维护频率 | 建议 |
|------|------|----------|------|
| docs/collab/chatgpt-lingxi | AI 协作主目录 | 高 | 活跃使用 |
| scripts/ | 自动化脚本 | 中 | 持续补充 |
| tools/ | 开发工具 | 中 | 持续补充 |
| shared-for-ai/ | 旧 AI 输出 | 低 | 归档 |

---

## 关键文档索引

| 文档 | 用途 | 优先级 |
|------|------|--------|
| 21-env-plan-2.0-brief.md | 环境总览 | ⭐⭐⭐ |
| 22-shared-docs-status-index.md | 文档索引 | ⭐⭐⭐ |
| 25-dev-roadmap-for-agent.md | 开发路线图 | ⭐⭐ |
| 24-repo-health-check.md | 健康检查 | ⭐⭐ |
| README.dev.md | 快速开始 | ⭐⭐⭐ |

---

## AI 工作流

```
1. 任务 → docs/collab/chatgpt-lingxi/task-*.md
2. 执行 → scripts/ 或 tools/
3. 结果 → docs/collab/chatgpt-lingxi/report-*.md
4. 交接 → docs/collab/chatgpt-lingxi/handoff-*.md
```

---

## 当前活跃度

| 区域 | 状态 |
|------|------|
| docs/collab/chatgpt-lingxi/ | 🟢 活跃 |
| scripts/ | 🟢 活跃 |
| tools/ | 🟢 活跃 |
| shared-for-ai/ | 🟡 归档 |

---

## 快速导航

- 想了解环境 → 21-env-plan-2.0-brief.md
- 想查文档 → 22-shared-docs-status-index.md
- 想开发 → 25-dev-roadmap-for-agent.md
- 想自检本地 → tools/check-dev-env-local.ps1
- 想自检服务器 → scripts/check-dev-env-server.sh
