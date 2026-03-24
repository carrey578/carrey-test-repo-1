# 开发任务统一入口指南

> 生成时间：2026-03-25 01:18 CST
> 执行者：灵犀
> 分支：chore/cursor-bootstrap

---

## 一、入口脚本概览

| 脚本 | 平台 | 路径 | 功能 |
|------|------|------|------|
| `dev-entry.sh` | Linux/服务器 | `scripts/dev-entry.sh` | 统一任务入口 |
| `dev-entry.ps1` | Windows | `tools/dev-entry.ps1` | 统一任务入口 |

---

## 二、安装说明

无需安装，脚本已包含在仓库中。

**服务器端 (Linux)**
```bash
cd /root/workspace/repos/carrey-test-repo-1
bash scripts/dev-entry.sh [command]
```

**本地端 (Windows)**
```powershell
cd D:\dev\carrey-test-repo-1
.\tools\dev-entry.ps1 [command]
```

---

## 三、可用命令

| 命令 | 说明 | 示例 |
|------|------|------|
| `check` | 运行开发环境检查 | `dev-entry.sh check` |
| `status` | 显示仓库状态摘要 | `dev-entry.sh status` |
| `docs` | 查看文档索引 | `dev-entry.sh docs` |
| `handoff` | 生成 handoff 入口 | `dev-entry.sh handoff` |
| `reports` | 检查报告目录 | `dev-entry.sh reports` |
| `help` | 显示帮助 | `dev-entry.sh help` |

---

## 四、各命令详细说明

### 1. check - 开发环境检查

运行完整的开发环境检查脚本。

**服务器端**
```bash
bash scripts/dev-entry.sh check
```

**本地端**
```powershell
.\tools\dev-entry.ps1 check
```

**输出示例**
```
=== 运行开发环境检查 ===
[1] Check Git branch... OK
[2] Check README files... OK (4 file(s))
[3] Check docs directory... OK
...
```

---

### 2. status - 仓库状态摘要

快速查看当前仓库状态。

**输出内容**
- 当前分支
- 远程仓库
- 最近提交
- 文件统计（文档/脚本/工具数量）
- 未提交更改数

---

### 3. docs - 文档索引

查看当前可用的文档结构。

**输出内容**
- 主要目录结构
- 最新文档列表（按修改时间）
- 模板文件位置

---

### 4. handoff - Handoff 生成入口

提供 handoff 文档的创建指引。

**输出内容**
- 当前可用的 handoff 模板
- 复制命令示例

---

### 5. reports - 报告目录检查

检查报告和输出目录的状态。

**输出内容**
- 各报告目录的文件数量
- 最近 7 天内的报告列表

---

## 五、整合能力说明

本入口脚本整合了以下能力：

| 能力 | 状态 | 说明 |
|------|------|------|
| 开发检查 | ✅ | 调用 check-dev-env-server.sh / check-dev-env-local.ps1 |
| 仓库状态摘要 | ✅ | 整合 git branch/remote/log/status |
| 文档索引查看 | ✅ | 列出 docs 目录结构和模板文件 |
| handoff 生成入口 | ✅ | 列出模板并提供复制命令 |
| 报告目录检查 | ✅ | 检查 collab 目录和 outputs 目录 |

---

## 六、故障排查

### 权限问题 (Linux)
```bash
chmod +x scripts/dev-entry.sh
```

### 执行策略问题 (Windows)
```powershell
Set-ExecutionPolicy -RemoteSigned -Scope Process
.\tools\dev-entry.ps1 help
```

---

## 七、后续扩展

可考虑新增功能：
- `git log` 查看最近提交
- `diff` 查看未推送的更改
- `sync` 一键拉取最新
- `backup` 快速备份当前状态

---

*本指南为 v1.0*