# 26-task-flow-templates-index

## 文档目的
说明 docs/collab/chatgpt-lingxi/ 下任务流模板的定位和使用方式。

---

## 一、模板清单

| 模板文件 | 用途 | 关键字段 |
|----------|------|----------|
| `task-template.md` | 发起新任务 | task_name, description, boundary |
| `report-template.md` | 任务执行报告 | summary, files_changed |
| `handoff-template.md` | 任务交接 | current_status, what_done |
| `decision-template.md` | 决策记录 | options, recommendation |

---

## 二、使用场景

### 典型任务流程

```
task-template.md → [执行任务] → report-template.md → [如需交接] → handoff-template.md
                                                   ↓
                              如需决策 → decision-template.md
```

---

## 三、使用建议

| 场景 | 用哪个模板 |
|------|------------|
| 人工给灵犀派任务 | `task-template.md` |
| 灵犀完成任务后输出报告 | `report-template.md` |
| 任务需要交接给人工 | `handoff-template.md` |
| 需要做决策并记录 | `decision-template.md` |

---

## 四、命名规则

- 任务模板文件直接用 `*-template.md`
- 具体任务用 `task-序号-名称.md`
- 具体报告用 `report-序号-名称.md`
- 具体交接用 `handoff-序号-名称.md`
- 具体决策用 `decision-序号-名称.md`

---

## 五、示例

- `task-01-repo-health-check.md`
- `report-01-repo-health-check.md`
- `handoff-01-repo-health-check.md`
- `decision-01-whether-code-change.md`
