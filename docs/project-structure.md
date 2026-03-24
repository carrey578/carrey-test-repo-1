# 项目结构说明

> 最后更新：2026-03-24

## 顶层目录

```
carrey-test-repo-1/
├── docs/                    # 项目文档
│   └── collab/
│       └── chatgpt-lingxi/  # AI 协作主目录
├── scripts/                 # 自动化脚本
├── shared-for-ai/          # AI 输出目录
├── tools/                  # 开发工具
├── README.dev.md           # 开发启动说明
├── README.local.md
└── README.ssh-check.md
```

## 目录详解

| 目录 | 作用 | AI 介入频率 |
|------|------|-------------|
| `docs/` | 项目文档 | 高 |
| `docs/collab/chatgpt-lingxi/` | AI 协作主目录 | 最高 |
| `scripts/` | 自动化脚本 | 中 |
| `tools/` | 开发工具脚本 | 中 |
| `shared-for-ai/` | AI 输出结果 | 低 |

## 关键文件

| 文件 | 说明 | 优先级 |
|------|------|--------|
| `README.dev.md` | 开发启动说明 | 高 |
| `docs/21-env-plan-2.0-brief.md` | 环境总览 | 高 |
| `docs/22-shared-docs-status-index.md` | 文档索引 | 高 |
| `docs/25-dev-roadmap-for-agent.md` | 开发路线图 | 中 |
| `scripts/check-dev-env-server.sh` | 服务器检查脚本 | 中 |
| `tools/check-dev-env-local.ps1` | 本地检查脚本 | 中 |

## 适合 AI 高频介入的区域

1. **docs/collab/chatgpt-lingxi/** - 文档协作
2. **scripts/** - 脚本生成
3. **tools/** - 工具脚本

## 建议新增/整理的区域

| 区域 | 建议 |
|------|------|
| `shared-for-ai/` | 可作为历史归档，减少使用 |
| 根目录 | 可考虑添加 .gitignore |
| docs/ | 可补充项目级说明文档 |

## 文件统计

- 总文件数：38
- 文档数：30+
- 脚本数：3
- 工具数：2
