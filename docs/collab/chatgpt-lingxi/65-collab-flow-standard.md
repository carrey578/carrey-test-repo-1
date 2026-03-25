# 协作流程标准说明

> 统一本地-服务器-共享目录联动说明
> 生成时间：2026-03-25 10:18 CST
> 分支：chore/cursor-bootstrap

---

## 一、角色与职责

| 角色 | 主要职责 |
|------|----------|
| 人工 | 任务拆解、开发、Review |
| 灵犀 | 执行任务、文档生成、脚本编写 |
| ChatGPT | 方案设计、文档整理 |
| Codex | 代码分析、只读任务 |

---

## 二、核心流程

### 日常开发

1. 人工本地开发 → push 到 GitHub
2. 灵犀 pull → 执行任务
3. 灵犀 commit → push 到 GitHub

### 验证流程

1. 灵犀执行 verify 脚本
2. 通过 → 准备 handoff
3. 失败 → 修复后重验证

### Handoff 流程

1. 灵犀生成 handoff → 放入共享目录
2. commit + push
3. 人工 review + 确认

---

## 三、推荐命令

```bash
# 同步最新代码
git pull origin chore/cursor-bootstrap

# 提交变更
git add . && git commit -m "描述" && git push origin-write chore/cursor-bootstrap
```

---

## 四、禁止事项

| 禁止 | 说明 |
|------|------|
| force push | 禁止 `git push -f` |
| 直接改 main | 只能在 chore/cursor-bootstrap |
| 未验证提交 | 需先运行 verify |

---

## 五、高授权执行场景

| 场景 | 说明 |
|------|------|
| 文档生成 | docs/ 目录下文档编写 |
| 脚本编写 | scripts/、tools/ 脚本 |
| 验证执行 | verify 脚本 |
| 状态报告 | 共享目录状态报告 |
| Handoff | 任务交接文档 |

---

*本文档为任务42输出*
