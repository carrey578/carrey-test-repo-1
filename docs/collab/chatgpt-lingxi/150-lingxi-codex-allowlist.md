# 灵犀调用 Codex 白名单

## 当前允许
- 只读读仓分析
- 轻量 review
- PR 文案 / change summary / verify 建议辅助
- docs/、tools/、scripts/ 下 1~3 个文件的小改动
- 共享目录 markdown 生成与整理

## 当前禁止
- 改 main
- 大范围重构
- 删除大量文件
- 改 systemd
- 改 OpenClaw 核心配置
- 改 token / 密钥 / .env
- 无明确文件范围的跨目录大改

## 当前服务器试点工作位
- /root/workspace/worktrees/lingxi-codex-bootstrap

## 当前说明
- 旧服务器活跃 repo 不作为本次试点执行位
- Codex 调用仅限本次试点 worktree