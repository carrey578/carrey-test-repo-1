# Handoff Template

## 适用场景
当任务需要交接给人工或其他 AI 时使用。

## 必填项

| 字段 | 说明 | 示例 |
|------|------|------|
| `handoff_from` | 交接方 | 灵犀 |
| `handoff_to` | 接收方 | 人工 |
| `task_name` | 任务名称 | 生成开发路线图 |
| `current_status` | 当前状态 | 已完成，待审核 |
| `what_done` | 已完成 | 25-dev-roadmap-for-agent.md |
| `what_pending` | 待完成 | 人工审核 |
| `key_notes` | 关键备注 | 建议先做任务1-3 |

## 可选项

- `blocking_issues` - 阻塞问题
- `decision_needed` - 需要决策的事项

## 使用方式

1. 任务完成或需要交接时生成
2. 明确当前状态和下一步
3. 放入 `docs/collab/chatgpt-lingxi/`
