# Runtime Notes - 运行时注意事项

> 最后更新：2026-03-24

---

## 当前环境概述

| 项目 | 值 |
|------|-----|
| 测试仓 | carrey-test-repo-1 |
| 当前分支 | chore/cursor-bootstrap |
| OpenClaw | 运行中 (PID 1446943) |
| 服务器 | 腾讯云 Lighthouse |

---

## OpenClaw 运行信息

| 项目 | 路径/值 |
|------|---------|
| 工作目录 | `/root/.openclaw/` |
| Workspace | `/root/.openclaw/workspace/` |
| Gateway | `systemd: openclaw-gateway` |
| 进程 PID | 1446943 |

---

## Git 配置

### 当前用户

```bash
git config --global user.name "灵犀"
git config --global user.email "lingxi@local"
```

### SSH 密钥

| 用途 | 路径 |
|------|------|
| 只读拉仓 | `~/.ssh/id_ed25519_carrey_test_repo` |
| 写权限 | `~/.ssh/id_ed25519_carrey_test_repo_write` |

### SSH Host 别名

| 别名 | 用途 |
|------|------|
| `github-carrey-test` | 只读 remote |
| `github-carrey-test-write` | 写权限 remote |

---

## 共享目录

| 目录 | 用途 |
|------|------|
| `docs/collab/chatgpt-lingxi/` | AI 协作主目录 |
| `xfer/incoming/` | 文件上传入口 |
| `xfer/outgoing/` | 文件下载出口 |

---

## 开发工作流

### 标准流程

1. **任务开始**
   - 先同步：`git fetch && git pull`
   - 可选：运行巡检脚本

2. **执行任务**
   - 按边界执行
   - 产出文档/脚本

3. **提交**
   - `git add .`
   - `git commit -m "feat: xxx"`
   - `git push origin-write HEAD:chore/cursor-bootstrap`

4. **产出报告**
   - 写 report 到 docs/collab/chatgpt-lingxi/

---

## 关键命令速查

| 操作 | 命令 |
|------|------|
| 同步远端 | `git fetch origin && git pull --ff-only origin chore/cursor-bootstrap` |
| 推送 | `git push origin-write HEAD:chore/cursor-bootstrap` |
| 检查 OpenClaw | `ps aux \| grep openclaw` |
| 检查环境 | `bash scripts/check-dev-env-server.sh` |

---

## 注意事项

1. **不要 force push** - 保持协作历史
2. **先同步再开发** - 避免冲突
3. **边界内操作** - 不越界
4. **报告产出** - 每次任务有记录

---

## 联系信息

| 角色 | 联系方式 |
|------|----------|
| 人工 | 孟安然 |
| 灵犀 | OpenClaw Agent |

