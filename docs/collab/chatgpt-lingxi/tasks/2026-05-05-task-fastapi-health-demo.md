# Task: 创建最小 FastAPI health demo

## 1. 任务名称
创建最小 FastAPI health demo

## 2. 背景
执行《多Agent配置-近期阶段指南2.0（基于开发环境5.0）》阶段六，用一个最小 FastAPI 后端服务验证 Codex 已经可以完成比 repo doctor 更接近真实应用的代码任务。

本任务卡为事后补齐，用于把已经完成的阶段六代码任务纳入 `docs/collab/chatgpt-lingxi/tasks/` 的标准任务链路。

## 3. 任务类型
- [ ] 文档
- [x] 代码
- [ ] 脚本
- [x] 测试
- [ ] 环境检查
- [ ] COS 归档
- [ ] 其他: __________

## 4. 推荐执行 Agent
- 默认 Agent：Codex
- 备用 Agent：Claude Code

## 5. 允许修改范围
- `app/`
- `tests/`
- `requirements.txt`
- `.gitignore`
- `docs/collab/chatgpt-lingxi/reports/`

## 6. 禁止修改范围
- main 分支
- .env / token / 私钥
- 生产数据库
- 云资源删除操作
- 系统重装
- 未说明的大规模重构
- 云服务器配置

## 7. Codex 自动化级别
- [ ] suggest
- [x] auto-edit
- [ ] full-auto

## 8. Claude 介入条件
- Codex 连续失败 2 轮
- 测试反复不过
- 涉及 5 个以上文件
- 需要第二意见 code review

## 9. 预期输出
1. `app/main.py`
2. `tests/test_health.py`
3. `requirements.txt`
4. `docs/collab/chatgpt-lingxi/reports/2026-05-05-fastapi-health-demo-change-summary.md`

## 10. 验收标准
1. 创建最小 FastAPI 应用。
2. 增加 `GET /health` endpoint。
3. `/health` 返回 `{"status": "ok", "env": "dev"}`。
4. 增加 pytest 测试。
5. `python -m pytest` 通过。
6. 写入 change-summary。
7. 不推 main。

## 11. Hermes 汇总要求
1. 确认任务卡已补齐。
2. 汇总 Codex 执行结果。
3. 引用 change-summary 和提交记录。
4. 将本任务视为阶段六 Codex 高自动化任务的完成证据。

## 12. Git 分支要求
- 工作分支：work/lingxi-codex-bootstrap
- 不允许直接 push 到 main

## 13. 完成状态
- [ ] pending
- [ ] running
- [x] done
- [ ] blocked

## 14. 完成记录
- 实现提交：`c0a1861 feat: add fastapi health demo`
- 验证结果：`1 passed`
- change-summary：`docs/collab/chatgpt-lingxi/reports/2026-05-05-fastapi-health-demo-change-summary.md`
