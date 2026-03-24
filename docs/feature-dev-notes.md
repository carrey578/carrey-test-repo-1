# 功能开发说明 - 脚本联动调用

> 生成时间：2026-03-25 01:57 CST
> 执行者：灵犀
> 分支： chore/cursor-bootstrap

---

## 一、功能架构

### 1.1 结构图

```
dev-entry.sh / dev-entry.ps1 (入口)
    │
    ├── cmd_check()      → check-dev-env-server.sh
    ├── cmd_status()     → 内置实现
    ├── cmd_docs()       → 内置实现
    ├── cmd_handoff()    → 内置实现
    ├── cmd_reports()    → 内置实现
    ├── cmd_all()        → check + preflight + status
    ├── cmd_preflight()  → preflight-check.sh
    └── cmd_report()     → generate-change-report.sh
```

### 1.2 文件职责

| 文件 | 职责 |
|------|------|
| `scripts/dev-entry.sh` | Linux 端入口脚本 |
| `tools/dev-entry.ps1` | Windows 端入口脚本 |
| `scripts/check-dev-env-server.sh` | 被调用的环境检查脚本 |
| `scripts/preflight-check.sh` | 被调用的预提交检查脚本 |
| `scripts/generate-change-report.sh` | 被调用的报告生成脚本 |

---

## 二、代码结构

### 2.1 Bash 版 (dev-entry.sh)

```bash
# 命令定义
COMMANDS=(
    "check:运行开发环境检查"
    "all:运行所有检查"
    "preflight:运行预提交检查"
    "report:生成变更报告"
    # ...
)

# 命令函数
cmd_all() {
    bash scripts/check-dev-env-server.sh
    bash scripts/preflight-check.sh
    bash scripts/dev-entry.sh status
}

# 主逻辑
case "${1:-help}" in
    all) cmd_all ;;
    preflight) cmd_preflight ;;
    report) cmd_report ;;
    # ...
esac
```

### 2.2 PowerShell 版 (dev-entry.ps1)

```powershell
# 命令函数
function Cmd-All {
    & "$ScriptDir\check-dev-env-local.ps1"
    & "$ScriptDir\preflight-check.ps1"
    Cmd-Status
}

# 主逻辑
switch ($cmd) {
    "all" { Cmd-All }
    "preflight" { Cmd-Preflight }
    "report" { Cmd-Report }
}
```

---

## 三、添加新命令

### 3.1 步骤

1. 在 `COMMANDS` 数组（或 Show-Help）中添加命令说明
2. 实现 `cmd_<command>()` 函数
3. 在 `case` / `switch` 中添加分支
4. 更新示例

### 3.2 示例：添加 `sync` 命令

**Bash**：
```bash
# 1. 添加命令说明
COMMANDS+=("sync:同步仓库")

# 2. 实现函数
cmd_sync() {
    echo "正在同步仓库..."
    git pull origin chore/cursor-bootstrap
}

# 3. 添加分支
sync) cmd_sync ;;
```

**PowerShell**：
```powershell
# 1. 添加帮助信息
Write-Host "  sync   - 同步仓库"

# 2. 实现函数
function Cmd-Sync {
    Write-Host "正在同步仓库..."
    git pull origin chore/cursor-bootstrap
}

# 3. 添加分支
"sync" { Cmd-Sync }
```

---

## 四、验证测试

### 4.1 手动验证

```bash
# 测试新命令
bash scripts/dev-entry.sh <command>

# 测试联动
bash scripts/dev-entry.sh all
```

### 4.2 自动验证

```bash
# 运行验证脚本
bash scripts/verify-dev-entry.sh
```

---

## 五、注意事项

1. **路径**：所有子脚本调用使用相对路径 `scripts/`
2. **错误处理**：使用 `set -e` (Bash) 或 `$ErrorActionPreference` (PS)
3. **兼容性**：Bash 和 PowerShell 版本应保持功能一致
4. **回滚**：修改前可先 `git checkout HEAD -- <file>`

---

## 六、相关文件

| 文件 | 说明 |
|------|------|
| `scripts/dev-entry.sh` | 入口脚本 (Linux) |
| `tools/dev-entry.ps1` | 入口脚本 (Windows) |
| `scripts/verify-dev-entry.sh` | 验证脚本 (Linux) |
| `tools/verify-dev-entry.ps1` | 验证脚本 (Windows) |
| `docs/feature-usage-guide.md` | 使用说明 |

---

*本文档为功能开发说明 v1.0*