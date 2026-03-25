# 灵犀长期工作清单与维护节奏

> 建立灵犀长期主动职责清单
> 生成时间：2026-03-25 10:35 CST
> 分支：chore/cursor-bootstrap

---

## 一、长期工作清单

### 1.1 仓库巡检

| 项目 | 说明 |
|------|------|
| **触发时机** | 每次开始新任务前 |
| **具体操作** | |
| | 1. 检查 git 状态 |
| | 2. 检查分支是否正确 |
| | 3. 检查是否有未提交的更改 |
| | 4. 检查最近提交 |
| **输出** | 状态信息 |
| **自动化** | ✅ 可自动执行 |

### 1.2 共享目录维护

| 项目 | 说明 |
|------|------|
| **触发时机** | 每周/每次任务完成后 |
| **具体操作** | |
| | 1. 检查共享目录文档数量 |
| | 2. 清理过期报告文件 |
| | 3. 更新文档索引 |
| **输出** | 维护报告 |
| **自动化** | ⚠️ 部分自动 |

### 1.3 状态报告生成

| 项目 | 说明 |
|------|------|
| **触发时机** | 任务切换时 |
| **具体操作** | |
| | 1. 运行 generate-status-report.sh |
| | 2. 输出状态报告到共享目录 |
| **输出** | docs/collab/chatgpt-lingxi/auto-status-report.md |
| **自动化** | ✅ 完全自动 |

### 1.4 Handoff 生成

| 项目 | 说明 |
|------|------|
| **触发时机** | 任务完成后 |
| **具体操作** | |
| | 1. 运行 generate-handoff-v2.sh |
| | 2. 补充人工填写区 |
| | 3. commit + push |
| **输出** | docs/collab/chatgpt-lingxi/handoff-*.md |
| **自动化** | ⚠️ 半自动 |

### 1.5 Change Summary 生成

| 项目 | 说明 |
|------|------|
| **触发时机** | 定期/任务完成后 |
| **具体操作** | |
| | 1. 运行 generate-change-summary-v2.sh |
| | 2. 输出变更摘要 |
| **输出** | docs/collab/chatgpt-lingxi/change-summary-*.md |
| **自动化** | ✅ 完全自动 |

### 1.6 Verify / Regression 辅助

| 项目 | 说明 |
|------|------|
| **触发时机** | 任务执行后/提交前 |
| **具体操作** | |
| | 1. 运行 verify-main-feature.sh |
| | 2. 运行 regression 检查 |
| | 3. 报告验证结果 |
| **输出** | 验证报告 |
| **自动化** | ✅ 完全自动 |

### 1.7 多文件小改动

| 项目 | 说明 |
|------|------|
| **触发时机** | 人工分配任务 |
| **具体操作** | |
| | 1. 理解任务目标 |
| | 2. 执行小范围改动 |
| | 3. 自检 verify |
| | 4. 生成 handoff |
| **输出** | 改动文件 + handoff |
| **自动化** | ❌ 人工驱动 |

---

## 二、维护节奏

### 2.1 每次任务前

```
1. 仓库巡检
   bash scripts/dev-entry-v2.sh status
2. 拉取最新
   git pull origin chore/cursor-bootstrap
3. 检查待办
   查看人工分配的任务
```

### 2.2 每次任务执行中

```
1. 执行任务
2. 自检验证
   bash scripts/verify-main-feature.sh
3. 修复问题 (如需要)
4. 继续验证直到通过
```

### 2.3 每次任务完成后

```
1. 生成状态报告
   bash scripts/generate-status-report.sh
2. 生成 handoff
   bash scripts/generate-handoff-v2.sh -t "任务XX-完成"
3. 生成 change summary
   bash scripts/generate-change-summary-v2.sh
4. commit + push
5. 等待人工 review
```

### 2.4 每周定期

```
1. 仓库健康检查
   bash scripts/dev-entry-v2.sh full
2. 共享目录整理
   - 检查过期文件
   - 更新索引
3. 状态汇总
   生成周报
```

### 2.5 每阶段（每批任务后）

```
1. 阶段 handoff
   bash scripts/generate-handoff-v2.sh -t "第X批阶段Handoff"
2. 变更汇总
   bash scripts/generate-change-summary-v2.sh -n 20
3. 生成验收报告
   (如任务要求)
4. 准备下一批任务
```

---

## 三、自动化程度分级

| 级别 | 任务 | 说明 |
|------|------|------|
| **L5 完全自动** | 状态报告、Change Summary、Verify | 一键执行，无需人工 |
| **L4 高自动** | Handoff 生成 | 自动生成 + 人工补充 |
| **L3 半自动** | 仓库巡检 | 自动检查 + 人工确认 |
| **L2 受控自动** | 回归检查 | 需要人工授权 |
| **L1 人工驱动** | 代码开发 | 完全人工控制 |

---

## 四、推荐自动化命令

### 4.1 快速巡检

```bash
# 一键状态检查
bash scripts/dev-entry-v2.sh status
```

### 4.2 完整检查

```bash
# 完整检查 + 验证 + 报告
bash scripts/dev-entry-v2.sh full
```

### 4.3 任务收尾

```bash
# 1. 验证
bash scripts/verify-main-feature.sh

# 2. 状态报告
bash scripts/generate-status-report.sh

# 3. Handoff
bash scripts/generate-handoff-v2.sh -t "任务XX-完成"

# 4. 变更摘要
bash scripts/generate-change-summary-v2.sh
```

---

## 五、禁止事项提醒

| 禁止 | 说明 |
|------|------|
| 未经授权执行代码改动 | 只在受控范围内 |
| force push | 禁止使用 |
| 改 main 分支 | 只在 chore/cursor-bootstrap |
| 未经确认删除文件 | 删除前先确认 |

---

## 六、相关文档

| 文档 | 说明 |
|------|------|
| `docs/dev-entry-v2-guide.md` | 统一入口使用指南 |
| `docs/status-report-guide.md` | 状态报告指南 |
| `docs/handoff-generation-guide.md` | Handoff 生成指南 |
| `docs/change-summary-v2-guide.md` | Change Summary 指南 |
| `docs/collab/chatgpt-lingxi/69-multi-agent-collab-rules.md` | 多 Agent 协作规则 |

---

## 七、工作清单速查表

| 场景 | 命令 |
|------|------|
| 开始任务前巡检 | `bash scripts/dev-entry-v2.sh status` |
| 执行任务验证 | `bash scripts/verify-main-feature.sh` |
| 任务完成后状态 | `bash scripts/generate-status-report.sh` |
| 任务完成后交接 | `bash scripts/generate-handoff-v2.sh -t "任务X-完成"` |
| 变更摘要 | `bash scripts/generate-change-summary-v2.sh` |
| 完整流程 | `bash scripts/dev-entry-v2.sh full` |

---

*本文档为任务48输出*
