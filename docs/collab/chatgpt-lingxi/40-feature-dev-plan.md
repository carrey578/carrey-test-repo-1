# 任务22 - 脚本联动调用开发方案

> 生成时间：2026-03-25 01:49 CST
> 执行者：灵犀
> 分支： chore/cursor-bootstrap

---

## 一、功能目标

**功能**：增强 scripts/dev-entry.sh，使其可以直接调用其他脚本，形成工具链联动。

**目标效果**：
```bash
# 增强后的命令
bash scripts/dev-entry.sh all        # 运行所有检查
bash scripts/dev-entry.sh preflight  # 运行预提交检查
bash scripts/dev-entry.sh report     # 生成完整报告
```

---

## 二、涉及目录和文件

| 文件 | 操作 | 说明 |
|------|------|------|
| `scripts/dev-entry.sh` | 修改 | 增强入口脚本 |
| `tools/dev-entry.ps1` | 修改 | 同步增强 Windows 版 |
| `scripts/preflight-check.sh` | 不变 | 被调用脚本 |
| `scripts/check-dev-env-server.sh` | 不变 | 被调用脚本 |
| `scripts/generate-change-report.sh` | 不变 | 被调用脚本 |

---

## 三、子步骤拆解

### 步骤 1：增强 dev-entry.sh 增加新命令

**输入**：无  
**输出**：修改 `scripts/dev-entry.sh`  
**是否改现有文件**：是  
**是否新增文件**：否

**具体内容**：
- 新增 `all` 命令：依次调用 check + preflight + status
- 新增 `preflight` 命令：调用 scripts/preflight-check.sh
- 新增 `report` 命令：调用 generate-change-report.sh
- 更新 COMMANDS 数组
- 更新 show_help 显示

---

### 步骤 2：增强 dev-entry.ps1 增加新命令

**输入**：无  
**输出**：修改 `tools/dev-entry.ps1`  
**是否改现有文件**：是  
**是否新增文件**：否

**具体内容**：
- 同步增加 all/preflight/report 命令
- 适配 PowerShell 语法
- 更新帮助信息

---

### 步骤 3：验证脚本联动

**输入**：修改后的脚本  
**输出**：测试结果  
**是否改现有文件**：否  
**是否新增文件**：否

**具体内容**：
- 运行 `bash scripts/dev-entry.sh all` 验证
- 运行 `bash scripts/dev-entry.sh preflight` 验证
- 运行 `bash scripts/dev-entry.sh report` 验证

---

### 步骤 4：更新目录 README

**输入**：无  
**输出**：修改 `scripts/README.md`  
**是否改现有文件**：是  
**是否新增文件**：否

**具体内容**：
- 在快速开始部分增加新命令示例

---

### 步骤 5：生成执行报告

**输入**：验证结果  
**输出**：新建 `docs/collab/chatgpt-lingxi/41-feature-impl-report.md`  
**是否改现有文件**：否  
**是否新增文件**：是

**具体内容**：
- 记录开发过程
- 记录测试结果

---

## 四、最小验收标准

| 验收项 | 标准 |
|--------|------|
| `dev-entry.sh all` | 依次输出 check + preflight + status 结果 |
| `dev-entry.sh preflight` | 成功调用 preflight-check.sh 并输出结果 |
| `dev-entry.sh report` | 成功生成变更报告 |
| Windows 版同步 | tools/dev-entry.ps1 同样支持以上命令 |
| 旧命令兼容 | check/status/docs/handoff/reports 仍正常工作 |

---

## 五、最小回滚方案

**回滚命令**：
```bash
# 撤销 dev-entry.sh 修改
git checkout HEAD -- scripts/dev-entry.sh

# 撤销 dev-entry.ps1 修改
git checkout HEAD -- tools/dev-entry.ps1

# 撤销 README 修改
git checkout HEAD -- scripts/README.md
```

**验证**：
```bash
bash scripts/dev-entry.sh help
```

---

## 六、测试与文档建议

| 类型 | 建议 | 说明 |
|------|------|------|
| 测试 | 建议补 | 运行 3 个新命令验证联动 |
| 文档 | 建议补 | 更新 README 快速开始 |
| 回滚说明 | 已包含 | 在本方案第五节 |

---

## 七、预期改动规模

| 文件 | 操作 | 行数预估 |
|------|------|----------|
| scripts/dev-entry.sh | 修改 | +30~40 行 |
| tools/dev-entry.ps1 | 修改 | +30~40 行 |
| scripts/README.md | 修改 | +10 行 |
| 新文档 | 新建 | ~50 行 |

---

*本文档为脚本联动调用开发方案 v1.0*