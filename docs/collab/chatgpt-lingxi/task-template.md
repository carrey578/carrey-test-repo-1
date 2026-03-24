# Task Template

## 适用场景
当需要发起一个新任务时使用。

## 必填项

| 字段 | 说明 | 示例 |
|------|------|------|
| `task_name` | 任务名称 | 全仓健康检查 |
| `target_repo` | 目标仓库 | carrey-test-repo-1 |
| `description` | 任务描述 | 对仓库做一次健康检查 |
| `boundary` | 执行边界 | 仅读仓，不改 main |
| `expected_output` | 预期输出 | markdown 报告 |
| `approver` | 审核人（可选） | 人工确认 |

## 使用方式

1. 复制本模板
2. 填写必填项
3. 交给灵犀执行
4. 人工审核结果

## 输出格式

任务完成后，输出应包含：
- 执行摘要
- 改动文件列表
- commit id（如有）
- 下一步建议
