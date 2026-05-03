# Task Template - Env5 Recent Stage

## 1. 任务名称
[任务名称]

## 2. 背景
[任务背景说明]

## 3. 任务类型
- [ ] 文档
- [ ] 代码
- [ ] 脚本
- [ ] 测试
- [ ] 环境检查
- [ ] COS 归档
- [ ] 其他: __________

## 4. 推荐执行 Agent
- 默认 Agent：Codex / Hermes
- 备用 Agent：Claude Code

## 5. 允许修改范围
- [具体允许修改的目录或文件]

## 6. 禁止修改范围
- main 分支
- .env / token / 私钥
- 生产数据库
- 云资源删除操作
- 系统重装
- 未说明的大规模重构

## 7. Codex 自动化级别
- [ ] suggest
- [ ] auto-edit
- [ ] full-auto

## 8. Claude 介入条件
- Codex 连续失败 2 轮
- 涉及 5 个以上文件
- diff 超过 300 行
- 测试错误复杂
- 需要跨模块重构
- 需要第二意见 code review

## 9. 预期输出
[预期输出文件或结果]

## 10. 验收标准
[验收标准]

## 11. Hermes 汇总要求
[Hermes 汇总要求]

## 12. Git 分支要求
- 工作分支：work/lingxi-codex-bootstrap
- 不允许直接 push 到 main

## 13. 完成状态
- [ ] pending
- [ ] running
- [ ] done
- [ ] blocked
