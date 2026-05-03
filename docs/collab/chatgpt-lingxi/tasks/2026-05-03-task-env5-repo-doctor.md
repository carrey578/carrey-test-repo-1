# Task: 创建 env5_repo_doctor.py 脚本

## 1. 任务名称
创建 env5_repo_doctor.py 脚本

## 2. 背景
验证近期阶段 Codex 代码施工能力，创建第一个真实任务脚本

## 3. 任务类型
- [x] 脚本
- [ ] 文档
- [ ] 代码
- [ ] 测试
- [ ] 环境检查
- [ ] COS 归档
- [ ] 其他

## 4. 推荐执行 Agent
- 默认 Agent：Codex
- 备用 Agent：Claude Code

## 5. 允许修改范围
- scripts/env5_repo_doctor.py
- docs/collab/chatgpt-lingxi/reports/

## 6. 禁止修改范围
- main 分支
- .env / token / 私钥
- 生产数据库
- 云资源删除操作
- 系统重装
- 未说明的大规模重构

## 7. Codex 自动化级别
- [ ] suggest
- [x] auto-edit
- [ ] full-auto

## 8. Claude 介入条件
- Codex 连续失败 2 轮
- 脚本涉及复杂跨平台问题

## 9. 预期输出
1. scripts/env5_repo_doctor.py
2. docs/collab/chatgpt-lingxi/reports/YYYY-MM-DD-repo-doctor-report.md
3. docs/collab/chatgpt-lingxi/reports/YYYY-MM-DD-repo-doctor-change-summary.md

## 10. 验收标准
1. 脚本能检查 repo 当前路径
2. 脚本能检查当前分支
3. 脚本能检查 git status
4. 脚本能检查关键目录是否存在
5. 输出 markdown 格式报告
6. 报告保存到正确路径

## 11. Hermes 汇总要求
1. 确认任务卡已创建
2. 等待 Codex 执行结果
3. 汇总执行报告

## 12. Git 分支要求
- 工作分支：work/lingxi-codex-bootstrap
- 不允许直接 push 到 main

## 13. 完成状态
- [x] pending
- [ ] running
- [ ] done
- [ ] blocked
