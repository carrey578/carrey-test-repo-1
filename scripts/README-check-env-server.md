# 服务器开发环境检查脚本

## 脚本位置
`scripts/check-dev-env-server.sh`

## 适用环境
- Linux 服务器
- Bash Shell

## 使用方法

### 方法 1：直接运行

```bash
cd /root/workspace/repos/carrey-test-repo-1
bash scripts/check-dev-env-server.sh
```

### 方法 2：绝对路径

```bash
bash /root/workspace/repos/carrey-test-repo-1/scripts/check-dev-env-server.sh
```

## 检查项

| # | 检查项 | 说明 |
|---|--------|------|
| 1 | 仓库路径 | /root/workspace/repos/carrey-test-repo-1 |
| 2 | Git 分支 | 确认在 chore/cursor-bootstrap |
| 3 | 共享目录 | docs/collab/chatgpt-lingxi |
| 4 | OpenClaw 目录 | /root/.openclaw |
| 5 | OpenClaw workspace | /root/.openclaw/workspace |
| 6 | OpenClaw 进程 | 检查 Gateway 是否运行 |

## 输出示例

```
=== 服务器开发环境检查 ===

[1] 检查仓库路径...
  ✓ 仓库路径存在: /root/workspace/repos/carrey-test-repo-1
[2] 检查 Git 分支...
  ✓ 当前分支: chore/cursor-bootstrap
[3] 检查共享目录...
  ✓ 共享目录存在
[4] 检查 OpenClaw 工作目录...
  ✓ OpenClaw 目录存在
[5] 检查 OpenClaw workspace...
  ✓ workspace 目录存在
[6] 检查 OpenClaw 进程...
  ✓ OpenClaw Gateway 运行中

=== 检查完成 ===
```

## 注意事项

- 脚本只读，不修改任何文件
- 无需 root 权限
- 无外部依赖
