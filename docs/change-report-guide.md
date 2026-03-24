# 变更报告自动生成机制说明

> 生成时间：2026-03-25 01:26 CST
> 执行者：灵犀
> 分支：chore/cursor-bootstrap

---

## 一、机制概览

| 组件 | 平台 | 路径 |
|------|------|------|
| `generate-change-report.sh` | Linux/服务器 | `scripts/generate-change-report.sh` |
| `generate-change-report.ps1` | Windows | `tools/generate-change-report.ps1` |

---

## 二、功能说明

自动生成变更报告，包含：

| 内容 | 说明 |
|------|------|
| 最近 Commit 信息 | Hash、标题、作者、时间、分支 |
| 改动文件列表 | 按类型分类统计 |
| 改动类型统计 | 新增/修改/删除数量 |
| 建议 Review 点 | 基于改动类型给出建议 |
| Diff 摘要 | 统计信息 |
| 验证建议 | 本地/服务器检查命令 |
| Handoff 信息 | 生成时间、下一步指引 |

---

## 三、安装说明

无需安装，脚本已包含在仓库中。

**服务器端 (Linux)**
```bash
cd /root/workspace/repos/carrey-test-repo-1
bash scripts/generate-change-report.sh
```

**本地端 (Windows)**
```powershell
cd D:\dev\carrey-test-repo-1
.\tools\generate-change-report.ps1
```

---

## 四、输出文件

默认输出到：`docs/collab/chatgpt-lingxi/auto-change-report.md`

可自定义输出路径：
```bash
# Linux
bash scripts/generate-change-report.sh docs/my-report.md

# Windows
.\tools\generate-change-report.ps1 -Output "docs\my-report.md"
```

---

## 五、使用场景

### 1. 开发完成后生成报告
每次完成一个任务后，运行脚本生成报告，便于 review 和 handoff。

### 2. Code Review 前准备
生成报告后，可直接发送给 reviewer，或贴到 PR 评论中。

### 3. Handoff 交接
交接工作时，将报告作为交接文档的一部分。

---

## 六、依赖说明

- **Linux**: bash, git
- **Windows**: PowerShell 5.0+, git

无三方依赖，纯原生工具实现。

---

## 七、可重复执行

脚本可重复执行，每次会覆盖同名输出文件。

建议工作流：
1. 完成开发任务
2. 运行脚本生成报告
3. 检查报告内容
4. 提交代码时同时提交报告（可选）

---

*本文档为变更报告自动生成机制 v1.0*