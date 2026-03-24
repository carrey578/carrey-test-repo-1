# Dev Bootstrap

## 设备

- **本地机器**: Surface Laptop 4 / Windows 11
- **编辑器**: Cursor
- **传输协议**: SSH

## 仓库

- **本地路径**: D:\dev\carrey-test-repo-1
- **服务器路径**: /root/workspace/repos/carrey-test-repo-1
- **协作分支**: chore/cursor-bootstrap
- **共享目录**: docs/collab/chatgpt-lingxi/

## 目录结构

```
carrey-test-repo-1/
├── docs/                    # 项目文档
│   └── collab/chatgpt-lingxi/  # AI 协作目录
├── scripts/                 # 自动化脚本
│   └── check-dev-env-server.sh
├── shared-for-ai/          # AI 输出目录
├── tools/                  # 开发工具
│   └── check-dev-env-local.ps1
├── README.dev.md           # 本文件
├── README.local.md
└── README.ssh-check.md
```

## 开发工具

| 工具 | 用途 |
|------|------|
| Cursor | 主编辑器 |
| ChatGPT | 方案、文档 |
| Codex CLI | 代码分析 |
| 灵犀 (OpenClaw) | 服务器执行 |
| GitHub | 代码托管 |

## 当前状态

- 最后验证: 2026-03-24
- 状态: AI-first 开发模式运行中

## 快速开始

1. 克隆仓库
2. 切换到 `chore/cursor-bootstrap` 分支
3. 运行本地检查脚本: `.\tools\check-dev-env-local.ps1`
4. 开始开发

## 参考文档

- 完整环境说明: docs/collab/chatgpt-lingxi/21-env-plan-2.0-brief.md
- 开发路线图: docs/collab/chatgpt-lingxi/25-dev-roadmap-for-agent.md
