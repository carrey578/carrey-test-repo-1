# 服务器 GitHub 写回配置说明

## 当前用途

本文档用于记录当前云服务器在试点 worktree 中向 GitHub 写回代码/文档的配置方式。

当前适用范围：
- 仓库：`carrey578/carrey-test-repo-1`
- 分支：`work/lingxi-codex-bootstrap`
- 服务器试点工作位：`/root/workspace/worktrees/lingxi-codex-bootstrap`

---

## 当前写回方式

服务器 root 用户当前已具备 GitHub 写权限。

当前写权限 key：
- `/root/.ssh/id_ed25519_github_write`

当前 SSH alias：
- `github-carrey-test`
- `github-carrey-test-write`

当前建议用法：
- fetch / pull：`origin`
- push：`origin`（push URL 已指向 write alias）

---

## 当前 remote 约定

当前 worktree 中 remote 建议状态：

- `origin` fetch 使用：
  - `git@github-carrey-test:carrey578/carrey-test-repo-1.git`
- `origin` push 使用：
  - `git@github-carrey-test-write:carrey578/carrey-test-repo-1.git`

这样做的意义：
1. 读写路径分开
2. 灵犀后续执行 `git push origin work/lingxi-codex-bootstrap` 时，可直接走写通道
3. 本地 Windows 侧无需改动 remote

---

## 当前 SSH config 关键项

服务器 root 用户 `/root/.ssh/config` 中至少应包含：

```sshconfig
Host github-carrey-test
  HostName github.com
  User git
  IdentityFile /root/.ssh/id_ed25519_github_write
  IdentitiesOnly yes

Host github-carrey-test-write
  HostName github.com
  User git
  IdentityFile /root/.ssh/id_ed25519_github_write
  IdentitiesOnly yes