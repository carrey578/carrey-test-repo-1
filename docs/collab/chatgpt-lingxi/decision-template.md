# Decision Template

## 适用场景
当需要记录或申请决策时使用。

## 必填项

| 字段 | 说明 | 示例 |
|------|------|------|
| `decision_title` | 决策标题 | 是否进入轻量代码改动阶段 |
| `proposer` | 提出方 | 灵犀 |
| `context` | 背景 | 已完成文档类任务 |
| `options` | 选项 | A.继续文档 / B.尝试代码 |
| `recommendation` | 建议 | 建议选 B |
| `rationale` | 理由 | 验证 AI 代码能力 |

## 可选项

- `risks` - 风险
- `approver` - 审批人
- `deadline` - 决策截止时间

## 使用方式

1. 决策前生成
2. 人工给出最终决策
3. 记录决策结果
