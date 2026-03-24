# 脚本目录 (scripts/)

> 本目录包含服务器端 (Linux) 自动化脚本

---

## 脚本索引

| 脚本 | 用途 | 核心功能 |
|------|------|----------|
| `check-dev-env-server.sh` | 开发环境检查 | 检查仓库、分支、OpenClaw、内存、磁盘、Node、Git 状态 |
| `dev-entry.sh` | 统一任务入口 | 整合 check/status/docs/handoff/reports 命令 |
| `preflight-check.sh` | 预提交检查 | Git 仓库、分支、工作区、目录结构、脚本语法检查 |
| `generate-change-report.sh` | 变更报告生成 | 自动汇总最近 commit、改动文件、diff 统计 |
| `generate-handoff.sh` | Handoff 生成 | 生成标准交接文档模板 |

---

## 快速开始

```bash
# 进入仓库目录
cd /root/workspace/repos/carrey-test-repo-1

# 运行开发环境检查
bash scripts/check-dev-env-server.sh

# 运行预提交检查
bash scripts/preflight-check.sh

# 生成变更报告
bash scripts/generate-change-report.sh

# 生成 Handoff 文档
bash scripts/generate-handoff.sh TASK-001

# 使用统一入口
bash scripts/dev-entry.sh help
bash scripts/dev-entry.sh status
```

---

## 详细说明

各脚本详细用法请参考：
- `docs/preflight-check.md` - 预提交检查说明
- `docs/dev-entry-guide.md` - 统一入口使用指南
- `docs/change-report-guide.md` - 变更报告生成指南

---

## 依赖

- bash
- git
- 标准 Unix 工具 (grep, awk, sed, free, df, ps)

---

## 注意事项

- 所有脚本需要在仓库根目录执行
- 脚本仅做只读检查，无破坏性操作
- 建议在提交前运行 preflight-check.sh