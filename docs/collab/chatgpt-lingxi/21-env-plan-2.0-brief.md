# 21-env-plan-2.0-brief

## 文档定位
本文件用于记录“本地 Surface + 云上 OpenClaw”当前实际开发环境的精简状态，作为后续维护、开发、排障和继续扩展时的快速参考。

## 当前阶段
- 第1优先级：已完成
- 第2优先级：已完成
- 第3优先级：已完成
- 第3.5步：已完成
- 第4优先级：已完成第一阶段基础接入与验收
- 第5优先级：已完成第一轮基础接入验证

## 当前一句话
当前环境已形成：本地可控、云端可执行、GitHub 可共享、Codex CLI 双端可用、OpenClaw Agent 已进入受控任务模式的稳定基线。

## 本地
- 设备：Surface Laptop 4 / Windows 11
- 活跃仓：`D:\dev\carrey-test-repo-1`
- xfer upload：`D:\dev\_xfer_lingxi\upload`
- xfer download：`D:\dev\_xfer_lingxi\download`

## 服务器
- 开发仓：`/root/workspace/repos/carrey-test-repo-1`
- OpenClaw 运行区：`/root/.openclaw/`
- OpenClaw workspace：`/root/.openclaw/workspace/`
- 第5步 skill：`/root/.openclaw/workspace/skills/carrey-phase5-bootstrap/`
- xfer incoming：`/home/ubuntu/xfer/incoming`
- xfer outgoing：`/home/ubuntu/xfer/outgoing`

## GitHub
- 仓库：`carrey578/carrey-test-repo-1`
- 协作分支：`chore/cursor-bootstrap`
- 共享目录：`docs/collab/chatgpt-lingxi/`

## 当前工具链
- Cursor：主编辑器
- ChatGPT：方案、文档、状态整理
- Codex CLI：本地/服务器只读分析与轻量文档任务
- OpenClaw：云端 Gateway / 渠道运行
- OpenClaw Agent：受控文档任务与项目化 Agent 入口
- 灵犀：服务器执行端

## 当前已验证通过
- 本地真实 repo 工作流
- ChatGPT Project 持续上下文
- 腾讯云服务器独立开发工作区
- GitHub 共享目录协作
- 服务器侧 markdown 文档受控写回
- Codex CLI 本地与服务器双端可用
- OpenClaw Agent 第一轮基础接入验证通过
- OpenClaw 运行未受影响

## 当前边界
- 允许：
  - 只读分析
  - markdown 文档生成
  - 共享目录内受控写入
  - 仅在 `chore/cursor-bootstrap` 分支操作
- 不允许：
  - 推送到 `main`
  - systemd 调整
  - OpenClaw 升级
  - OpenClaw 配置大改
  - 大范围代码自动改造
  - 敏感配置写入 GitHub

## 当前维护规则
- 共享文档优先放 `docs/collab/chatgpt-lingxi/`
- 本地开始改共享文档前先同步远端
- 已 commit 且远端也更新时，优先 `fetch + rebase + push`
- 不使用 force push
- xfer 目录只做中转，不做长期存储

## 当前建议
- 继续以文档类任务为主做小步扩展
- 保持 OpenClaw / Codex / 灵犀 的边界清晰
- 进入更深层自动化前，优先补齐状态文档和操作记录
