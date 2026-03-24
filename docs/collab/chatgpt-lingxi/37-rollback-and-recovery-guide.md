# 回滚与恢复说明手册

> 生成时间：2026-03-25 01:37 CST
> 执行者：灵犀
> 分支：chore/cursor-bootstrap
> 适用：本地 + 服务器环境

---

## 一、基本原则

| 原则 | 说明 |
|------|------|
| **不强制推送** | 禁止 `git push --force` |
| **小步回滚** | 优先回滚单个文件，而非整次提交 |
| **先备份** | 重要操作前先确认有可恢复途径 |
| **人工确认** | 回滚操作需人类确认后执行 |

---

## 二、场景处理

### 场景 1：最新 commit 需要撤回

**场景**：刚刚提交了一个 commit，但发现有问题需要撤回

**推荐做法**：
```bash
# 查看最近提交
git log --oneline -3

# 撤销最新提交（保留更改在工作区）
git reset --soft HEAD~1

# 检查状态
git status
```

**说明**：
- `--soft`：撤销提交，但保留更改在暂存区
- 之后可重新修改后再次提交

**不推荐**：
```bash
git reset --hard HEAD~1  # 会丢失更改，不建议
```

---

### 场景 2：共享目录文档改坏

**场景**：`docs/collab/chatgpt-lingxi/` 下的文档被改坏了

**推荐做法**：
```bash
# 查看文件历史
git log --oneline docs/collab/chatgpt-lingxi/xxx.md

# 恢复到某个历史版本
git checkout <commit-hash> -- docs/collab/chatgpt-lingxi/xxx.md

# 或者直接从远端拉取最新
git checkout origin/chore/cursor-bootstrap -- docs/collab/chatgpt-lingxi/xxx.md
```

**说明**：
- 可精确恢复单个文件
- 不影响其他文件

---

### 场景 3：多文件改动后需要回退

**场景**：一次提交了多个文件，但只需要回退其中几个

**推荐做法**：
```bash
# 查看具体文件的历史
git log --oneline -- <filename>

# 恢复到某个版本
git checkout <commit-hash>^ -- <filename>

# 或者用 git restore (Git 2.23+)
git restore --source=<commit-hash>^ <filename>
```

**说明**：
- 使用 `^` 表示该 commit 的上一个版本
- 可精确到单个文件

---

### 场景 4：本地与远端分支出现偏差

**场景**：本地分支与远端分支不一致，推送失败

**推荐做法**：
```bash
# 先查看差异
git log --oneline origin/chore/cursor-bootstrap..HEAD

# 如果本地更领先，手动合并
git merge origin/chore/cursor-bootstrap

# 如果远端更领先，拉取更新
git pull origin chore/cursor-bootstrap

# 解决冲突后，正常提交推送
```

**禁止做法**：
```bash
git push --force  # 禁止强制推送
git push --force-with-lease  # 也不推荐
```

---

### 场景 5：需要完全回到某个历史状态

**场景**：想回到之前的某个提交点

**推荐做法**：
```bash
# 创建一个新分支回到历史点（推荐）
git checkout -b chore/rollback-to-<date> <commit-hash>

# 或者重置当前分支（谨慎使用）
git reset --hard <commit-hash>
# 然后 git push origin-write chore/cursor-bootstrap (需确认无 force)
```

**重要**：
- `--hard` 会丢失之后的所有更改
- 确保没有未提交的更改

---

## 三、命令速查表

| 场景 | 推荐命令 | 说明 |
|------|----------|------|
| 撤销最新提交 | `git reset --soft HEAD~1` | 保留更改 |
| 恢复单个文件 | `git checkout <hash> -- <file>` | 从历史恢复 |
| 查看文件历史 | `git log --oneline -- <file>` | 查看修改记录 |
| 查看分支差异 | `git log --oneline origin/chore/cursor-bootstrap..HEAD` | 本地 vs 远端 |
| 拉取远端更新 | `git pull origin chore/cursor-bootstrap` | 同步最新 |
| 放弃本地更改 | `git checkout -- .` | 恢复工作区 |

---

## 四、禁止操作

| 命令 | 原因 |
|------|------|
| `git push --force` | 可能覆盖他人工作 |
| `git push --force-with-lease` | 仍有风险，不推荐 |
| `git reset --hard` 未确认 | 会丢失未提交的更改 |
| 删除远端分支 | 除非有明确原因 |

---

## 五、恢复流程（灵犀用）

当需要回滚时，灵犀应：

1. **先评估**：告诉人类具体情况
2. **提供方案**：给出推荐的具体命令
3. **等确认**：等待人类确认后再执行
4. **后验证**：执行后检查状态是否正确

---

## 六、注意事项

1. **任何回滚前**：先 `git status` 确认当前状态
2. **重要操作前**：可先 `git branch backup-<date>` 创建备份分支
3. **推送到远端**：确认远端没有其他人正在该分支工作
4. **合并冲突**：如遇冲突，先解决再继续

---

## 七、联系与支持

如不确定如何操作，请先告知人类，等待指导后再执行。

---

*本手册为回滚与恢复说明 v1.0*