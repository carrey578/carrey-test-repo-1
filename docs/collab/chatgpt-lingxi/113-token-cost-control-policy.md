# 113-token-cost-control-policy

## 当前阶段
开发环境配置方案 4.2 启动

## 当前默认原则
1. 默认只使用 Coding Plan
2. 当前默认模型为 MiniMax M2.5
3. Claude / OpenAI / Codex 等外部模型，不得默认常开
4. 灵犀如需调用外部模型，必须先向我申请授权
5. 一次授权，只对应一个具体任务
6. 任务完成后，必须尽快停用外部模型，并恢复默认 Coding Plan 路由

## 当前允许
- 默认使用 Coding Plan 内模型处理常规开发任务
- 生成 docs / report / change summary / handoff
- 低风险 scripts / tools / docs 修改
- 常规小功能第一轮尝试

## 当前不允许
- 灵犀未授权直接调用 Claude / OpenAI / Codex
- 外部高价模型长期开启
- 把高价模型用于普通重复性 Markdown 生成
- 在任务无明确结束条件时启用外部模型

## 当前例外规则
若任务明显超出 Coding Plan 默认模型能力，灵犀可以发起授权申请；
但未获得明确授权前，不得实际启用外部模型。

## 当前默认回退要求
外部模型任务完成后：
- 记录任务日志
- 停用外部模型
- 恢复默认 Coding Plan 路由
- 回报“已恢复默认低成本路由”