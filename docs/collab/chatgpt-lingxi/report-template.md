# Report Template

## 适用场景
当需要输出任务执行报告时使用。

## 必填项

| 字段 | 说明 | 示例 |
|------|------|------|
| `report_title` | 报告标题 | 全仓健康检查报告 |
| `task_name` | 关联任务名 | 全仓健康检查 |
| `executer` | 执行者 | 灵犀 |
| `timestamp` | 执行时间 | 2026-03-24 23:20 |
| `summary` | 执行摘要 | 检查完成，建议补充 tools/ |
| `files_changed` | 改动文件 | tools/README.md |

## 可选项

- `issues_found` - 发现的问题
- `next_steps` - 下一步建议
- `blockers` - 阻塞项

## 使用方式

1. 任务完成后生成
2. 放入 `docs/collab/chatgpt-lingxi/`
3. 提交并 push
