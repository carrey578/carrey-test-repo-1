# 任务12 - 多文件小改动摘要

> 生成时间：2026-03-25 01:16 CST
> 执行者：灵犀
> 分支：chore/cursor-bootstrap

---

## 一、方案选择

**自选方案**：增强服务器检查脚本 + 增强本地检查脚本

**理由**：
1. 两个脚本功能互补，增强后形成完整的开发环境检查体系
2. 改动文件数 = 2（在 2～5 范围内）
3. 风险极低，均为只读检查
4. 收益明显，提升巡检能力

---

## 二、实际改动文件

### 1. scripts/check-dev-env-server.sh

**改动前**：6 项检查（仓库路径、分支、共享目录、OpenClaw 目录、workspace、进程）

**改动后**：10 项检查，新增：
- [7] 内存使用检查（使用率百分比）
- [8] 磁盘使用检查（使用量 + 百分比）
- [9] Node 版本检查
- [10] Git 状态检查（工作区状态 + 远程地址）

### 2. tools/check-dev-env-local.ps1

**改动前**：5 项检查（分支、README、docs、shared 目录、Git 状态）

**改动后**：8 项检查，新增：
- [6] Node.js 检查（可选，检测是否安装）
- [7] npm 检查（可选，检测是否安装）
- [8] Cursor 检查（可选，检测是否安装）

---

## 三、Diff 摘要

```diff
scripts/check-dev-env-server.sh:
+ 内存检查 (+8 行)
+ 磁盘检查 (+6 行)
+ Node 版本检查 (+6 行)
+ Git 状态检查 (+9 行)

tools/check-dev-env-local.ps1:
+ Node.js 检查 (+10 行)
+ npm 检查 (+10 行)
+ Cursor 检查 (+9 行)
```

---

## 四、收益说明

| 维度 | 收益 |
|------|------|
| **服务器端** | 巡检覆盖：6项 → 10项，新增内存/磁盘/Node/远程检查 |
| **本地端** | 巡检覆盖：5项 → 8项，新增 Node/npm/Cursor 检查 |
| **整体** | 初步形成「服务器+本地」双端检查体系 |
| **风险** | 仅增加只读检查，无破坏性操作 |

---

## 五、待提交文件

1. `scripts/check-dev-env-server.sh` - 已修改
2. `tools/check-dev-env-local.ps1` - 已修改
3. `docs/collab/chatgpt-lingxi/33-multi-file-change-plan.md` - 已新建

---

## 六、验证建议

本地执行：
```powershell
.\tools\check-dev-env-local.ps1
```

服务器执行：
```bash
bash scripts/check-dev-env-server.sh
```

---