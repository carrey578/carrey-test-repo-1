# 137-model-switching-guide

## 目标
指导灵犀在任务执行过程中如何安全地切换模型，以及何时必须回退到默认路由。

## 默认路由
- Provider：Tencent Cloud Coding Plan
- Model：MiniMax M2.5
- 配置位置：`/root/workspace/config/model-routing/default-provider.env`

## 模型切换规则

### 升级到外部模型（需授权）
以下情况可申请升级：
- 任务需要大仓深度分析
- 任务需要跨文件复杂重构
- 任务需要长上下文高复杂度推理
- 默认模型多次失败的高价值任务
- 需要第二意见 / 对拍的关键问题

### 降级回默认路由（自动）
以下情况必须回退：
- 任务完成
- 外部模型调用失败
- 你明确要求回退

## 切换流程

### 升级流程
1. 灵犀评估是否需要升级
2. 灵犀向你发送授权申请（使用 132 模板）
3. 你授权后，灵犀更新运行时配置
4. 灵犀执行任务

### 回退流程
1. 任务结束或失败
2. 灵犀执行恢复脚本：`/root/workspace/config/model-routing/restore-default-route.sh`
3. 灵犀验证已恢复默认路由
4. 灵犀向你报告"已恢复默认 Coding Plan 路由"

## 运行时状态文件
- 授权状态：`/root/workspace/runtime/model-routing/external-model-approval.status`
- 当前 active provider：`/root/workspace/runtime/model-routing/active-provider.env`

## 禁止事项
- 未经授权，不得启用外部模型
- 不得在任务完成后继续使用外部模型
- 不得将外部模型设为默认路由