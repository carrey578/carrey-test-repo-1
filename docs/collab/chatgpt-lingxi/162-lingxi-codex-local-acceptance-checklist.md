# 灵犀 Codex 本地验收清单

> **阶段：** 阶段5 - 固定本地验收动作
> **分支：** work/lingxi-codex-bootstrap
> **验收位置：** /root/workspace/worktrees/lingxi-codex-bootstrap
> **本轮性质：** 文档固化轮，**不调用 Codex**

---

## 验收命令标准顺序

每轮修复或调整后，按以下顺序执行本地验收：

### 1. 版本与状态检查

```powershell
# 切换到试点目录
cd /root/workspace/worktrees/lingxi-codex-bootstrap

# 查看当前分支（应为 work/lingxi-codex-bootstrap）
git branch --show-current

# 获取最新远程变更
git fetch origin

# 查看提交历史（最近5条）
git log --oneline -5

# 查看工作区状态
git status
```

### 2. 开发入口脚本验证

```powershell
# 查看 dev-entry.ps1 帮助信息
.\tools\dev-entry.ps1 help

# 或在 Linux 环境下
./tools/dev-entry.ps1 help
```

### 3. 开发环境入口验证

```powershell
# 执行 verify-dev-entry.ps1
.\tools\verify-dev-entry.ps1

# 或在 Linux 环境下
./tools/verify-dev-entry.ps1
```

### 4. 仓库健康检查

```powershell
# 执行 repo-health-check.ps1
.\tools\repo-health-check.ps1

# 或在 Linux 环境下
./tools/repo-health-check.ps1
```

---

## 验收标准

| 检查项 | 预期结果 |
|--------|----------|
| 分支正确性 | 当前分支为 `work/lingxi-codex-bootstrap` |
| 工作区清洁度 | `git status` 显示 working tree clean 或仅有预期文件变更 |
| dev-entry.ps1 help | 正常输出帮助信息，无报错 |
| verify-dev-entry.ps1 | 验证通过，输出验证成功消息 |
| repo-health-check.ps1 | 健康检查通过，无关键错误 |

---

## 验收失败处理

如遇验收失败，按以下顺序排查：

1. **分支错误** → 切换到正确分支：`git checkout work/lingxi-codex-bootstrap`
2. **有未提交更改** → 检查变更内容，决定是否提交或撤销
3. **脚本执行失败** → 检查脚本语法和依赖
4. **健康检查失败** → 查看错误信息，定位问题文件

---

## 注意事项

- **本轮不调用 Codex**：阶段5为纯文档固化轮，所有验收动作在本地执行
- **优先使用 PowerShell 语法**：文档命令以 Windows PowerShell 为主
- **验证后再 push**：本地验收通过后再执行 `git push`
- **保持工作区隔离**：仅在 `/root/workspace/worktrees/lingxi-codex-bootstrap` 中操作

---

## 快速验收单行命令

```powershell
cd /root/workspace/worktrees/lingxi-codex-bootstrap; git branch --show-current; git fetch origin; git status; .\tools\dev-entry.ps1 help; .\tools\verify-dev-entry.ps1; .\tools\repo-health-check.ps1
```
