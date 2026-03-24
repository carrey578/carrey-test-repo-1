# 功能测试清单

> 生成时间：2026-03-25 02:11 CST
> 执行者：灵犀
> 分支： chore/cursor-bootstrap

---

## 一、功能概览

| 功能 | 脚本 | 测试状态 |
|------|------|----------|
| 开发环境检查 | check-dev-env-server.sh / check-dev-env-local.ps1 | 已验证 |
| 统一任务入口 | dev-entry.sh / dev-entry.ps1 | 已验证 |
| 预提交检查 | preflight-check.sh / preflight-check.ps1 | 已验证 |
| 变更报告生成 | generate-change-report.sh / generate-change-report.ps1 | 已验证 |
| Handoff 生成 | generate-handoff.sh / generate-handoff.ps1 | 已验证 |
| 脚本验证 | verify-dev-entry.sh / verify-dev-entry.ps1 | 已验证 |

---

## 二、测试清单

### 2.1 开发环境检查 (check-dev-env-server.sh)

| # | 测试项 | 类型 | 验证方法 | 预期结果 |
|---|--------|------|----------|----------|
| 1.1 | 仓库路径检查 | 正常路径 | 执行脚本 | 输出 "✓ 仓库路径存在" |
| 1.2 | 分支检查 | 正常路径 | 执行脚本 | 输出 "✓ 当前分支: chore/cursor-bootstrap" |
| 1.3 | 共享目录检查 | 正常路径 | 执行脚本 | 输出 "✓ 共享目录存在" |
| 1.4 | OpenClaw 目录 | 正常路径 | 执行脚本 | 输出 "✓ OpenClaw 目录存在" |
| 1.5 | OpenClaw 进程 | 正常路径 | 执行脚本 | 输出 "✓ OpenClaw Gateway 运行中" |
| 1.6 | 内存检查 | 正常路径 | 执行脚本 | 输出内存使用情况 |
| 1.7 | 磁盘检查 | 正常路径 | 执行脚本 | 输出磁盘使用情况 |
| 1.8 | Node 版本检查 | 正常路径 | 执行脚本 | 输出 "✓ Node: vXX" |
| 1.9 | Git 状态检查 | 正常路径 | 执行脚本 | 输出 "✓ 工作区干净" 或 "⚠ 有未提交的更改" |
| 1.10 | 不存在目录 | 失败路径 | 模拟缺失 docs/ | 输出 "✗ 共享目录不存在" |

### 2.2 统一任务入口 (dev-entry.sh)

| # | 测试项 | 类型 | 验证方法 | 预期结果 |
|---|--------|------|----------|----------|
| 2.1 | help 命令 | 正常路径 | `bash dev-entry.sh help` | 显示帮助信息，包含所有命令 |
| 2.2 | check 命令 | 正常路径 | `bash dev-entry.sh check` | 调用 check-dev-env-server.sh |
| 2.3 | status 命令 | 正常路径 | `bash dev-entry.sh status` | 显示分支、远程、提交、文件统计 |
| 2.4 | docs 命令 | 正常路径 | `bash dev-entry.sh docs` | 显示文档索引 |
| 2.5 | handoff 命令 | 正常路径 | `bash dev-entry.sh handoff` | 显示 handoff 模板建议 |
| 2.6 | reports 命令 | 正常路径 | `bash dev-entry.sh reports` | 显示报告目录状态 |
| 2.7 | all 命令 | 正常路径 | `bash dev-entry.sh all` | 依次执行 check + preflight + status |
| 2.8 | preflight 命令 | 正常路径 | `bash dev-entry.sh preflight` | 调用 preflight-check.sh |
| 2.9 | report 命令 | 正常路径 | `bash dev-entry.sh report` | 生成变更报告文件 |
| 2.10 | --verbose 参数 | 正常路径 | `bash dev-entry.sh -v check` | 输出包含 ⚡ 前缀的详细信息 |
| 2.11 | --quiet 参数 | 正常路径 | `bash dev-entry.sh -q check` | 只输出关键结果，无额外信息 |
| 2.12 | --help 参数 | 正常路径 | `bash dev-entry.sh --help` | 同 help 命令 |
| 2.13 | 未知命令 | 失败路径 | `bash dev-entry.sh unknown` | 输出错误信息并显示帮助 |
| 2.14 | 空参数 | 边界 | `bash dev-entry.sh` | 默认显示 help |

### 2.3 预提交检查 (preflight-check.sh)

| # | 测试项 | 类型 | 验证方法 | 预期结果 |
|---|--------|------|----------|----------|
| 3.1 | Git 仓库检查 | 正常路径 | 执行脚本 | 输出 "✓ Git 仓库正常" |
| 3.2 | 分支检查 | 正常路径 | 执行脚本 | 输出 "✓ 当前分支: chore/cursor-bootstrap" |
| 3.3 | 工作区状态 | 正常路径 | 执行脚本 | 显示未提交更改数量 |
| 3.4 | 关键目录检查 | 正常路径 | 执行脚本 | 输出 docs/scripts/tools 都存在 |
| 3.5 | README 检查 | 正常路径 | 执行脚本 | 输出找到 N 个 README 文件 |
| 3.6 | Markdown 检查 | 正常路径 | 执行脚本 | 输出所有 Markdown 文件非空 |
| 3.7 | 脚本语法检查 | 正常路径 | 执行脚本 | 输出 "✓ 所有 Bash 脚本语法正常" |
| 3.8 | 仓库结构检查 | 正常路径 | 执行脚本 | 输出 "✓ 仓库结构完整" |
| 3.9 | --strict 模式 | 边界 | `bash preflight-check.sh --strict` | main 分支报错 |

### 2.4 变更报告生成 (generate-change-report.sh)

| # | 测试项 | 类型 | 验证方法 | 预期结果 |
|---|--------|------|----------|----------|
| 4.1 | 生成报告 | 正常路径 | `bash generate-change-report.sh` | 生成报告文件 |
| 4.2 | 报告内容 | 输出验证 | 读取报告文件 | 包含 commit 信息、改动文件列表 |
| 4.3 | 自定义输出 | 边界 | `bash generate-change-report.sh custom.md` | 生成到指定文件名 |

### 2.5 Handoff 生成 (generate-handoff.sh)

| # | 测试项 | 类型 | 验证方法 | 预期结果 |
|---|--------|------|----------|----------|
| 5.1 | 生成 handoff | 正常路径 | `bash generate-handoff.sh TASK-001` | 生成 handoff 文档 |
| 5.2 | 报告内容 | 输出验证 | 读取文档 | 包含任务信息、commit 信息 |
| 5.3 | 无参数默认 | 边界 | `bash generate-handoff.sh` | 生成带时间戳的默认文件名 |

### 2.6 脚本验证 (verify-dev-entry.sh)

| # | 测试项 | 类型 | 验证方法 | 预期结果 |
|---|--------|------|----------|----------|
| 6.1 | 验证 help | 正常路径 | 执行脚本 | 检测 help 包含新命令 |
| 6.2 | 验证 preflight | 正常路径 | 执行脚本 | 检测 preflight 执行成功 |
| 6.3 | 验证 report | 正常路径 | 执行脚本 | 检测 report 生成报告 |
| 6.4 | 验证 all | 正常路径 | 执行脚本 | 检测 all 执行成功 |
| 6.5 | 验证兼容性 | 正常路径 | 执行脚本 | 检测旧命令仍正常 |
| 6.6 | 全部通过 | 结果验证 | 执行脚本 | 输出 "验证全部通过" |

---

## 三、最小测试入口

### 3.1 快速测试

```bash
# 运行所有验证脚本
bash scripts/verify-dev-entry.sh
bash scripts/preflight-check.sh
bash scripts/check-dev-env-server.sh
```

### 3.2 完整测试

```bash
# 测试 dev-entry.sh 所有命令
for cmd in help check status docs handoff reports all preflight report; do
    echo "Testing: $cmd"
    bash scripts/dev-entry.sh $cmd
done
```

---

## 四、回归测试建议

| 场景 | 建议测试 |
|------|----------|
| 代码改动后 | 运行 verify-dev-entry.sh |
| 新增脚本后 | 运行 preflight-check.sh |
| 环境变化后 | 运行 check-dev-env-server.sh |
| 重大改动前 | 运行 dev-entry.sh all |

---

## 五、测试结果记录

| 日期 | 测试项 | 结果 | 备注 |
|------|--------|------|------|
| 2026-03-25 | verify-dev-entry.sh | ✅ 5/5 通过 | 任务24验证 |

---

*本文档为功能测试清单 v1.0*