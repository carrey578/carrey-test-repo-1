# 131-coding-plan-default-route

## 当前默认主路由
- Provider：Tencent Cloud Coding Plan
- Default Model：MiniMax M2.5

## 当前默认规则
- 新任务先默认走 Coding Plan
- Claude / ChatGPT API / Codex / 其它外部模型默认关闭
- Coding Plan 内其它模型如果要试用，先小范围试运行，不直接替代默认模型

## 当前适合默认走 Coding Plan 的任务
- 仓库巡检
- 共享目录文档生成
- change summary / handoff / report
- README / 说明文档草稿
- 一般脚本草案
- 低风险 docs / scripts / tools 修改

## 当前不做
- 不默认常开 Claude
- 不默认常开 OpenAI / Codex
- 不让灵犀未授权直接升级到外部模型

## 外部模型升级规则
以下情况可能需要升级到外部模型，但必须先申请授权：
- 大仓深度分析（跨文件复杂重构）
- 长上下文高复杂度推理
- 默认模型多次失败的高价值任务
- 需要第二意见 / 对拍的关键问题
- 明确目标、明确边界、明确结束条件的短时攻坚任务

## 升级流程
1. 灵犀先发出授权申请
2. 你明确授权后，灵犀才能启用外部模型
3. 任务完成后，灵犀必须恢复默认 Coding Plan 路由