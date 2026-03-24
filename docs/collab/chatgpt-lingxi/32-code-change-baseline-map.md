# 任务11 - 代码改动基线图

> 生成时间：2026-03-25 01:12 CST
> 执行者：灵犀
> 分支：chore/cursor-bootstrap

---

## 一、当前仓库主要目录结构

```
carrey-test-repo-1/
├── docs/                      # 文档主目录
│   ├── collab/chatgpt-lingxi/ # AI协作文档区 (主要工作区)
│   ├── 00-env-status.md
│   ├── quickstart.md
│   ├── project-structure.md
│   └── runtime-notes.md
├── scripts/                   # 服务器端脚本
│   ├── check-dev-env-server.sh
│   └── README*.md
├── tools/                     # 本地端工具
│   ├── check-dev-env-local.ps1
│   └── README*.md
├── shared-for-ai/            # AI共享工作区 (空结构)
│   ├── docs/
│   ├── notes/
│   └── outputs/
├── README.dev.md             # 开发说明
├── README.local.md           # 本地说明
└── README.ssh-check.md      # SSH检查说明
```

---

## 二、区域划分与改动建议

### 🟢 可优先改动区

| 区域 | 原因 |
|------|------|
| `docs/collab/chatgpt-lingxi/` | 专为AI协作设计，文档密集，风险低 |
| `scripts/` | 纯脚本，无业务逻辑，可大胆增强 |
| `tools/` | 本地工具脚本，安全边际大 |
| 根目录 `README*.md` | 项目入口文档，重要性高但风险可控 |

### 🟡 建议谨慎改动区

| 区域 | 原因 |
|------|------|
| `shared-for-ai/` | 空目录结构，预留给AI但未填充，需确保不破坏预期用途 |
| `docs/00-env-status.md` | 环境状态文档，关联服务器基线，修改需同步服务器 |

### 🔴 当前不建议改动区

| 区域 | 原因 |
|------|------|
| (无) | 当前为纯文档仓，无高风险代码区 |

---

## 三、最适合第二批任务介入的区域

| 优先级 | 区域 | 适合做的改动类型 |
|--------|------|------------------|
| 1 | `docs/collab/chatgpt-lingxi/` | 补全任务模板、决策模板、交接模板 |
| 2 | `scripts/` | 增加检查项、输出格式化、自动化增强 |
| 3 | `tools/` | PowerShell 脚本增强、输出美化 |
| 4 | 根目录 README | 补充快速入口、链接整理 |
| 5 | `shared-for-ai/notes/` | 建立AI工作笔记结构 |

---

## 四、最适合推进的 5 类改动

### 1. 模板文件补全
- **目标**：补充 decision/task/report/handoff 模板
- **位置**：`docs/collab/chatgpt-lingxi/`
- **收益**：统一协作格式，提高交接效率

### 2. 自动化检查增强
- **目标**：扩展 scripts/check-dev-env-server.sh 检查项
- **位置**：`scripts/`
- **收益**：提升开发环境巡检覆盖率

### 3. 本地工具增强
- **目标**：扩展 tools/check-dev-env-local.ps1 功能
- **位置**：`tools/`
- **收益**：让本地开发检查更自动化

### 4. AI 工作区激活
- **目标**：在 shared-for-ai/ 下建立实际子目录和说明
- **位置**：`shared-for-ai/`
- **收益**：明确AI工作空间用途

### 5. 文档索引优化
- **目标**：更新 docs/collab/chatgpt-lingxi/README.md 索引
- **位置**：`docs/collab/chatgpt-lingxi/`
- **收益**：便于后续快速导航

---

## 五、边界说明

| 动作 | 允许 | 备注 |
|------|------|------|
| 新建 .md 文件 | ✅ | docs/, shared-for-ai/ 下均可 |
| 新建脚本 | ✅ | scripts/, tools/ 下均可 |
| 修改现有 .md | ✅ | 优先改 docs/collab/chatgpt-lingxi/ |
| 修改脚本 | ✅ | 注意兼容性 |
| 删除空目录 | ✅ | 仅限 shared-for-ai/ 下的空子目录 |
| 删除文件 | ⚠️ | 需先确认非核心文档 |

---

## 六、后续任务入口

基于本基线图，以下任务可继续推进：

- 任务12：补全决策模板
- 任务13：扩展服务器检查脚本
- 任务14：激活 shared-for-ai 工作区
- 任务15：优化文档索引
- 任务16：本地工具增强

---

*本文档为代码改动基线图 v1.0*