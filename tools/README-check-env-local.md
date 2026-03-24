# Local Development Environment Check Script

## Script Location
`tools/check-dev-env-local.ps1`

##适用环境
- Windows PowerShell 5.1+
- Git CLI required
- Run in Git repository directory

## 运行方式

### Method 1: Direct Run

```powershell
cd D:\dev\carrey-test-repo-1
.\tools\check-dev-env-local.ps1
```

### Method 2: With Path

```powershell
Set-Location "D:\dev\carrey-test-repo-1"
& ".\tools\check-dev-env-local.ps1"
```

## 检查项

| # | Check Item | Description |
|---|------------|-------------|
| 1 | Git branch | Verify chore/cursor-bootstrap |
| 2 | README files | Check README exists |
| 3 | docs directory | Check docs/ exists |
| 4 | Shared directory | Check docs/collab/chatgpt-lingxi exists |
| 5 | Git status | Check for uncommitted changes |

## 输出示例

```
=== Local Development Environment Check ===

[1] Check Git branch... OK
[2] Check README files... OK (3 file(s))
[3] Check docs directory... OK
[4] Check Shared directory... OK
[5] Check Git status... Working tree clean

=== Check Complete ===
```

## Windows 本地常见问题排查

### 问题1: "因为在此系统上禁止运行脚本"

**原因**: PowerShell 执行策略限制

**解决方法**:

```powershell
# 临时允许当前进程执行脚本
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# 然后运行脚本
.\tools\check-dev-env-local.ps1
```

### 问题2: "无法加载文件"

**原因**: 文件可能被阻止

**解决方法**:

```powershell
# 解除文件阻止
Unblock-File -Path ".\tools\check-dev-env-local.ps1"

# 然后运行
.\tools\check-dev-env-local.ps1
```

### 问题3: 中文乱码

**原因**: 文件编码问题

**解决方法**:

```powershell
# 使用 UTF-8 编码查看
Get-Content -Path ".\tools\check-dev-env-local.ps1" -Encoding UTF8

# 或使用 VS Code / Notepad++ 打开查看
```

## 验收标准

运行成功后，应看到以下5项检查结果全部输出：

1. Git branch - OK 或具体分支名
2. README files - OK (数量)
3. docs directory - OK
4. Shared directory - OK
5. Git status - Working tree clean 或 Uncommitted changes

最后应有 "=== Check Complete ===" 结尾信息。

## 编码说明

- 脚本文件使用 UTF-8 with BOM 编码
- 兼容 Windows PowerShell 5.1+
- 推荐使用 VS Code、Notepad++ 或 PowerShell ISE 查看脚本内容
- 直接 `Get-Content` 可能出现编码差异，建议使用 `-Encoding UTF8` 参数

## 注意事项

- 脚本不需要管理员权限
- 依赖 Git CLI (需在 PATH 中)
- 无其他外部依赖
