# 本地开发环境检查脚本

## 脚本位置
`tools/check-dev-env-local.ps1`

## 适用环境
- Windows PowerShell 5.1+
- 需在 Git 仓库目录下运行

## 使用方法

### 方法 1：直接运行

```powershell
cd D:\dev\carrey-test-repo-1
.\tools\check-dev-env-local.ps1
```

### 方法 2：带路径运行

```powershell
# 进入仓库目录
Set-Location "D:\dev\carrey-test-repo-1"

# 运行脚本
& ".\tools\check-dev-env-local.ps1"
```

## 检查项

| # | 检查项 | 说明 |
|---|--------|------|
| 1 | Git 分支 | 确认在 chore/cursor-bootstrap |
| 2 | README 文件 | 确认项目有说明文档 |
| 3 | docs 目录 | 确认 docs 目录存在 |
| 4 | 共享目录 | 确认 docs/collab/chatgpt-lingxi 存在 |
| 5 | Git 状态 | 检查是否有未提交更改 |

## 输出示例

```
=== 本地开发环境检查 ===

[1] 检查 Git 分支... OK
[2] 检查 README 文件... OK (3 个文件)
[3] 检查 docs 目录... OK
[4] 检查共享目录... OK
[5] 检查 Git 状态... 工作区干净

=== 检查完成 ===
```

## 注意事项

- 脚本不需要管理员权限
- 依赖 Git CLI
- 无外部依赖，直接可运行
