# 本地-服务器-共享目录联动说明

> 统一协作流程文档
> 生成时间：2026-03-25 10:18 CST
> 分支：chore/cursor-bootstrap

---

## 一、角色职责定义

### 1.1 各角色职责

| 角色 | 位置 | 主要职责 |
|------|------|----------|
| **人工 (孟安然)** | 本地 Windows | 任务拆解、开发、Codex/ChatGPT、Review |
| **灵犀** | 腾讯云服务器 | 执行任务、文档生成、脚本编写 |
| **ChatGPT** | 云端 | 方案设计、文档整理 |
| **Codex CLI** | 本地/服务器 | 代码分析、只读任务 |

### 1.2 推荐职责边界

| 任务类型 | 推荐执行者 | 说明 |
|----------|------------|------|
| 任务拆解 | 人工 | 只有人理解业务目标 |
| 代码开发 | 人工 + Codex | 受控范围内 |
| 文档编写 | 灵犀 | 轻量快速 |
| 脚本编写 | 灵犀 | 自动化任务 |
| 状态汇总 | 灵犀 | 自动化报告 |
| Handoff | 灵犀 | 自动生成 + 人工补充 |
| Review | 人工 | 质量把关 |

---

## 二、协作场景与流程

### 2.1 日常开发流程

```
1. 人工在本地 Windows 开始开发
        ↓
2. 人工通过 Cursor 编辑代码
        ↓
3. 人工 commit 并 push 到 GitHub (chore/cursor-bootstrap)
        ↓
4. 灵犀 pull 最新代码
        ↓
5. 灵犀执行任务（如文档生成、脚本编写）
        ↓
6. 灵犀 commit 并 push 到 GitHub
        ↓
7. 人工 pull 最新变更
```

### 2.2 验证流程

```
1. 灵犀完成任务后执行验证
        ↓
2. 灵犀运行 verify 脚本
        ↓
3. 验证通过 → 准备 handoff
        ↓
4. 验证失败 → 修复后重新验证
```

### 2.3 Handoff 流程

```
1. 任务完成后，灵犀生成 handoff
        ↓
2. 放入共享目录 docs/collab/chatgpt-lingxi/
        ↓
3. 灵犀 commit 并 push
        ↓
4. 人工 pull 并 review
        ↓
5. 人工确认或提出修改
```

### 2.4 状态同步流程

```
1. 每次任务切换时
        ↓
2. 灵犀生成状态报告
        ↓
3. 放入共享目录
        ↓
4. 人工了解最新状态
```

---

## 三、推荐流程

### 3.1 推荐：正常开发流程

```bash
# 人工侧（本地）
git checkout chore/cursor-bootstrap
git pull origin chore/cursor-bootstrap
# 开发、编辑、测试
git add .
git commit -m "描述"
git push origin chore/cursor-bootstrap

# 灵犀侧（服务器）
git pull origin chore/cursor-bootstrap
# 执行任务
git add .
git commit -m "任务描述"
git push origin-write chore/cursor-bootstrap
```

### 3.2 推荐：任务交接流程

```
1. 人工提供任务说明（消息/文档）
2. 灵犀确认理解任务目标
3. 灵犀执行任务
4. 灵犀自测验证
5. 灵犀生成 handoff
6. 灵犀 commit + push
7. 人工 review + 确认
```

### 3.3 推荐：紧急回滚流程

```bash
# 回滚单个文件
git checkout HEAD -- scripts/dev-entry.sh

# 回滚多个文件
git checkout HEAD -- docs/ scripts/ tools/

# 验证
bash scripts/verify-main-feature.sh
```

---

## 四、不推荐流程

### 4.1 禁止：Force Push

```bash
# ❌ 禁止
git push -f origin-write chore/cursor-bootstrap

# ✅ 推荐
git push origin-write chore/cursor-bootstrap
```

### 4.2 禁止：直接改 main

```bash
# ❌ 禁止
git checkout main
# 修改

# ✅ 推荐
git checkout chore/cursor-bootstrap
# 修改
```

### 4.3 禁止：未验证就提交

```bash
# ❌ 禁止
# 直接 commit + push 无验证

# ✅ 推荐
bash scripts/verify-main-feature.sh
# 确认通过后再 commit
```

### 4.4 禁止：xfer 目录长期存储

```bash
# ❌ 禁止
# 把 xfer 当作长期文件仓库

# ✅ 推荐
# xfer 仅做临时中转，及时清理
```

---

## 五、高授权执行场景

在当前测试仓中，以下场景适合灵犀高授权直接执行：

| 场景 | 说明 |
|------|------|
| 文档生成 | 生成/更新文档到 docs/ |
| 脚本编写 | 编写/修改脚本到 scripts/、tools/ |
| 验证执行 | 运行 verify 脚本验证功能 |
| 状态报告 | 生成状态报告到共享目录 |
| Handoff | 生成任务交接文档 |

---

## 六、关键路径汇总

| 路径 | 说明 |
|------|------|
| 本地仓库 | `D:\dev\carrey-test-repo-1` |
| 服务器仓库 | `/root/workspace/repos/carrey-test-repo-1` |
| 共享目录 | `docs/collab/chatgpt-lingxi/` |
| 协作分支 | `chore/cursor-bootstrap` |
| 远程地址 | `git@github-carrey-test-write:carrey578/carrey-test-repo-1.git` |

---

## 七、相关文档

| 文档 | 说明 |
|------|------|
| `README.dev.md` | 开发环境说明 |
| `docs/main-feature-usage-guide.md` | 主功能使用说明 |
| `docs/main-feature-regression-checklist.md` | 回归检查清单 |
| `docs/main-feature-rollback-recovery-guide.md` | 回滚恢复手册 |

---

*本文档为协作流程标准说明 v1.0*
