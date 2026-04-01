# 135-agent-harness-status

## 当前阶段
- 阶段：4.4 阶段4
- 状态：Harness 最小骨架落地中

## 当前作用

| 功能 | 状态 | 说明 |
|------|------|------|
| 任务模板 | ✅ 已支持 | 使用 136-agent-task-template-v2.md |
| 状态留痕 | ✅ 已支持 | 运行时状态文件记录 |
| 边界约束 | ✅ 已支持 | 授权机制 + 回退机制 |
| 路由矩阵 | ✅ 已支持 | 见 138-model-routing-matrix-v2.md |

## 当前不做

| 功能 | 状态 | 说明 |
|------|------|------|
| 数据库 | ❌ 暂不做 | 不需要持久化存储 |
| Web 控制台 | ❌ 暂不做 | 人工管理足够 |
| 复杂队列 | ❌ 暂不做 | 单任务串行足够 |
| 多租户 | ❌ 暂不做 | 单用户场景 |

## 核心约束

### 默认路由
- **默认**：Coding Plan（Tencent Cloud MiniMax M2.5）
- **外部模型**：需人工授权后才能使用

### 授权流程
1. 灵犀评估是否需要外部模型
2. 灵犀发送授权申请（模板见 132）
3. 你授权后，灵犀更新运行时配置
4. 任务完成后必须回退

### 回退机制
- 任务结束或失败后，自动/手动执行恢复脚本
- 恢复脚本位置：`/root/workspace/config/model-routing/restore-default-route.sh`
- 恢复后状态：`APPROVED=0`，路由回到 Coding Plan

## 相关文件索引

| 文件 | 用途 |
|------|------|
| 130-44-overall-status.md | 4.4 整体状态 |
| 131-coding-plan-default-route.md | 默认路由配置 |
| 132-external-model-authorization.md | 授权模板 |
| 133-external-model-session-log.md | 使用记录 |
| 134-token-budget-dashboard.md | 预算面板 |
| 136-agent-task-template-v2.md | 任务模板 |
| 137-model-switching-guide.md | 切换指南 |
| 138-model-routing-matrix-v2.md | 路由矩阵 |
| 139-claude-access-status.md | Claude 接入状态 |
| 140-project-routing-guide.md | 项目路由指南 |
