# 任务37 - 主功能最小回滚与恢复手册 - 执行报告

> 生成时间：2026-03-25 10:01 CST
> 执行者：灵犀
> 分支：chore/cursor-bootstrap

---

## 一、任务概述

为主功能（`dev-entry.sh` / `dev-entry.ps1`）建立最小可用的回滚与恢复手册。

---

## 二、完成内容

### 2.1 创建的文件

| 文件 | 说明 |
|------|------|
| `docs/main-feature-rollback-recovery-guide.md` | 最小回滚与恢复手册 |
| `docs/collab/chatgpt-lingxi/57-main-feature-rollback-recovery-guide.md` | 本报告 |

### 2.2 文档结构

| 章节 | 内容 |
|------|------|
| 快速回滚命令 | 单文件/多文件回滚 |
| 场景与处理 | 4个常见场景及处理方法 |
| 推荐 vs 不推荐 | 明确操作边界 |
| 分支协作原则 | 非 force push 原则 |
| 验证清单 | 回滚后必做检查 |

---

## 三、覆盖场景

| 场景 | 处理方法 |
|------|----------|
| 本轮改动需要撤回 | `git reset --soft HEAD~1` 或 `--hard` |
| verify 失败 | 回滚 + 重新验证 |
| 多文件改动后功能异常 | `git checkout HEAD -- scripts/ tools/` |
| 文档与实现不一致 | 验证后同步文档 |

---

## 四、核心原则

### 非 Force Push

- ✅ 正常推送: `git push origin-write chore/cursor-bootstrap`
- ❌ 禁止: `git push -f`
- ❌ 禁止: 强制重置远程历史

### 推荐操作

| 操作 | 推荐命令 |
|------|----------|
| 回滚单文件 | `git checkout HEAD -- file` |
| 撤销提交 | `git reset --soft HEAD~1` |
| 查看历史 | `git log --oneline -10` |

---

## 五、Commit 信息

见下方 commit 记录。

---

*本文档为任务37执行报告 v1.0*
