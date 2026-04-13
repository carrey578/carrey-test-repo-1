# 灵犀 Codex 本地验收清单

> **阶段：** 阶段5 - 固定本地验收动作
> **分支：** work/lingxi-codex-bootstrap
> **验收位置：** /root/workspace/worktrees/lingxi-codex-bootstrap
> **本轮性质：** 文档固化收口轮，**不调用 Codex**

---

## 验收命令标准顺序

每轮修复或调整后，按以下顺序执行本地验收：

### 1. 同步远程最新代码

```powershell
# 切换到试点目录
cd /root/workspace/worktrees/lingxi-codex-bootstrap

# 获取最新远程变更
git fetch origin

# 拉取最新代码（仅快进合并）
git pull --ff-only origin work/lingxi-codex-bootstrap
```

### 2. 查看分支与状态

```powershell
# 查看当前分支（应为 work/lingxi-codex-bootstrap）
git branch --show-current

# 查看工作区状态
git status
```

### 3. 查看提交历史

```powershell
# 查看最近8条提交
git log --oneline -8
```

### 4. 开发入口脚本验证

```powershell
# 查看 dev-entry.ps1 帮助信息
.\tools\dev-entry.ps1 help
```

### 5. 开发环境入口验证

```powershell
# 执行 verify-dev-entry.ps1
.\tools\verify-dev-entry.ps1
```

### 6. 仓库健康检查

```powershell
# 执行 repo-health-check.ps1
.\tools\repo-health-check.ps1
```

### 7. 查看本轮变更内容

```powershell
# 查看本轮与上轮的差异
git diff HEAD~1 HEAD
```

---

## 完整验收命令序列

```powershell
# 完整本地验收（按顺序执行）
cd /root/workspace/worktrees/lingxi-codex-bootstrap
git fetch origin
git pull --ff-only origin work/lingxi-codex-bootstrap
git branch --show-current
git status
git log --oneline -8
.\tools\dev-entry.ps1 help
.\tools\verify-dev-entry.ps1
.\tools\repo-health-check.ps1
git diff HEAD~1 HEAD
```

---

## 验收标准

| 检查项 | 预期结果 | 判定 |
|--------|----------|------|
| 分支正确性 | 当前分支为 `work/lingxi-codex-bootstrap` | ✅ |
| 远程同步 | `git pull --ff-only` 成功，无冲突 | ✅ |
| 工作区清洁度 | `git status` 显示 working tree clean | ✅ |
| 提交历史 | 有本轮 commit 记录 | ✅ |
| dev-entry.ps1 help | 正常输出帮助信息，无报错 | ✅ |
| verify-dev-entry.ps1 | 验证通过，输出验证成功消息 | ✅ |
| repo-health-check.ps1 | 健康检查通过，无关键错误 | ✅ |
| 变更差异 | `git diff HEAD~1 HEAD` 显示预期变更 | ✅ |

**通过标准：全部8项检查均为 ✅**

---

## 验收失败处理

如遇验收失败，按以下顺序排查：

1. **分支错误** → 切换到正确分支：`git checkout work/lingxi-codex-bootstrap`
2. **拉取失败** → 先手动合并或重置：`git reset --hard origin/work/lingxi-codex-bootstrap`
3. **有未提交更改** → 检查变更内容，决定是否提交或撤销
4. **脚本执行失败** → 检查脚本语法和依赖
5. **健康检查失败** → 查看错误信息，定位问题文件

---

## 注意事项

- **本轮不调用 Codex**：阶段5为纯文档固化轮，所有验收动作在本地执行
- **优先使用 PowerShell 语法**：文档命令以 Windows PowerShell 为主
- **验证后再 push**：本地验收通过后再执行 `git push`
- **保持工作区隔离**：仅在 `/root/workspace/worktrees/lingxi-codex-bootstrap` 中操作
- **必须执行 git pull --ff-only**：确保本地与远程同步，避免意外合并

---

## 当前工具状态（已验证可运行）

| 脚本 | 状态 |
|------|------|
| repo-health-check.ps1 | ✅ 已可运行 |
| preflight-check.ps1 | ✅ 已可运行 |
| verify-dev-entry.ps1 | ✅ 已可运行 |
| dev-entry.ps1 | ✅ 已可运行 |
