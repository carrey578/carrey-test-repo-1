# 阶段级状态面板 v2

> 基于前几批的状态文档、自动报告、handoff、change summary、regression summary
> 版本: v2.0
> 更新时间：2026-03-25

---

## 一、当前关键入口汇总

### 1.1 当前有效状态文档

| 文档 | 说明 | 路径 |
|------|------|------|
| 本面板 | 阶段级状态面板 v2 | 本文档 |
| 协作流程 | 统一协作流程说明 | `docs/local-server-shared-collab-flow.md` |
| 自治边界 | 第6批自治边界说明 | `docs/collab/chatgpt-lingxi/74-phase6-autonomy-boundary.md` |
| 多 Agent 规则 | 多 Agent 协作规则 | `docs/collab/chatgpt-lingxi/69-multi-agent-collab-rules.md` |
| 长期工作 | 灵犀长期工作清单 | `docs/collab/chatgpt-lingxi/70-lingxi-long-term-working-list.md` |
| 就绪评估 | 第6批就绪评估 | `docs/collab/chatgpt-lingxi/73-phase6-readiness-assessment.md` |

### 1.2 自动化报告（最近）

| 报告 | 说明 | 路径 |
|------|------|------|
| 状态报告 | 自动状态汇总 | `docs/collab/chatgpt-lingxi/auto-status-report.md` |
| Handoff | 最近任务交接 | `docs/collab/chatgpt-lingxi/handoff-20260325-*.md` |
| Change Summary | 最近变更摘要 | `docs/collab/chatgpt-lingxi/change-summary-20260325-*.md` |
| Regression Summary | 回归汇总 | `docs/collab/chatgpt-lingxi/regression-summary-20260325-*.md` |

### 1.3 示例文件

| 示例 | 说明 | 路径 |
|------|------|------|
| 状态报告示例 | 66- | `docs/collab/chatgpt-lingxi/66-status-report-example.md` |
| Handoff 示例 | 67- | `docs/collab/chatgpt-lingxi/67-handoff-auto-example.md` |
| Change Summary 示例 | 68- | `docs/collab/chatgpt-lingxi/68-change-summary-auto-example.md` |
| Regression 示例 | 79- | `docs/collab/chatgpt-lingxi/79-regression-summary-example.md` |

### 1.4 模板文件

| 模板 | 说明 | 路径 |
|------|------|------|
| Handoff 模板 | 59- | `docs/collab/chatgpt-lingxi/59-feature-handoff-template.md` |
| Change Summary 模板 | 60- | `docs/collab/chatgpt-lingxi/60-feature-change-summary-template.md` |

### 1.5 脚本文件

| 类别 | 脚本 |
|------|------|
| 统一入口 | `dev-entry.sh`, `dev-entry-v2.sh` |
| 验证 | `verify-main-feature.sh`, `verify-dev-entry.sh` |
| 状态报告 | `generate-status-report.sh` |
| Handoff | `generate-handoff-v2.sh` |
| Change Summary | `generate-change-summary-v2.sh` |
| Regression | `generate-regression-summary.sh` |
| Demo | `demo-entry.sh` |

---

## 二、文件分类

### 2.1 当前有效

| 类型 | 数量 | 说明 |
|------|------|------|
| 状态文档 | 6 | 当前有效的流程/规则文档 |
| 自动化脚本 | 14 | 可执行的脚本 |

### 2.2 示例

| 类型 | 数量 | 说明 |
|------|------|------|
| 报告示例 | 4 | 实际生成的报告示例 |
| Demo | 1 | Demo 入口 |

### 2.3 模板

| 类型 | 数量 | 说明 |
|------|------|------|
| Handoff | 2 | Handoff 模板 |
| Change Summary | 1 | Change Summary 模板 |

---

## 三、推荐阅读顺序

### 3.1 新手入门

```
1. 本面板 v2
2. 74-phase6-autonomy-boundary.md (自治边界)
3. 69-multi-agent-collab-rules.md (协作规则)
4. 70-lingxi-long-term-working-list.md (长期工作)
```

### 3.2 日常使用

```
1. dev-entry-v2.sh 帮助
2. 运行 demo-entry.sh 了解能力
3. 按需调用各脚本
```

### 3.3 任务交接

```
1. generate-status-report.sh
2. generate-handoff-v2.sh
3. generate-change-summary-v2.sh
4. generate-regression-summary.sh
```

### 3.4 问题排查

```
1. 回归汇总: generate-regression-summary.sh
2. 验证: verify-main-feature.sh
3. 状态: dev-entry-v2.sh status
```

---

## 四、快速命令索引

| 场景 | 命令 |
|------|------|
| 查看帮助 | `bash scripts/dev-entry-v2.sh help` |
| 状态检查 | `bash scripts/dev-entry-v2.sh status` |
| 功能验证 | `bash scripts/verify-main-feature.sh` |
| 状态报告 | `bash scripts/generate-status-report.sh` |
| Handoff | `bash scripts/generate-handoff-v2.sh -t "任务X"` |
| 变更摘要 | `bash scripts/generate-change-summary-v2.sh` |
| 回归汇总 | `bash scripts/generate-regression-summary.sh` |
| Demo | `bash scripts/demo-entry.sh` |
| 完整流程 | `bash scripts/dev-entry-v2.sh full` |

---

## 五、阶段演进

| 阶段 | 状态 | 关键产出 |
|------|------|----------|
| 第1-3批 | ✅ 完成 | 环境搭建 |
| 第4批 | ✅ 完成 | 主功能文档体系 |
| 第5批 | ✅ 完成 | 自动化机制 |
| 第6批 | 🔄 进行中 | Demo/回归/面板v2 |

---

## 六、相关文档链接

### 第6批

| 文档 | 说明 |
|------|------|
| 73-phase6-readiness-assessment.md | 就绪评估 |
| 74-phase6-autonomy-boundary.md | 自治边界 |
| 75-deeper-modularization-plan.md | 模块化计划 |
| 76-deeper-modularization-summary.md | 模块化总结 |
| 77-change-summary-example.md | Change Summary 示例 |
| 78-demo-summary.md | Demo 总结 |
| 79-regression-summary-example.md | Regression 示例 |

### 第5批

| 文档 | 说明 |
|------|------|
| 69-multi-agent-collab-rules.md | 多 Agent 规则 |
| 70-lingxi-long-term-working-list.md | 长期工作清单 |
| 71-phase5-index-and-dashboard.md | 第5批面板 |

### 历史

| 文档 | 说明 |
|------|------|
| 72-phase5-completion-report.md | 第5批完成报告 |

---

*本文档为阶段级状态面板 v2*
