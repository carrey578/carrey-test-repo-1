# 预提交检查机制说明

> 生成时间：2026-03-25 01:22 CST
> 执行者：灵犀
> 分支： chore/cursor-bootstrap

---

## 一、检查概览

| 检查项 | 说明 | 严重程度 |
|--------|------|----------|
| Git 仓库 | 验证当前目录是 Git 仓库 | 错误 |
| 当前分支 | 建议在 feature 分支开发 | 警告 |
| 工作区状态 | 显示未提交更改数量 | 信息 |
| 关键目录 | docs/, scripts/, tools/ 是否存在 | 错误 |
| README 文件 | 检查是否存在 README | 警告 |
| Markdown | 检查空文件 | 警告 |
| 脚本语法 | Bash/PowerShell 语法检查 | 错误 |
| 仓库结构 | 完整性检查 | 错误 |

---

## 二、安装说明

无需安装，脚本已包含在仓库中。

**服务器端 (Linux)**
```bash
cd /root/workspace/repos/carrey-test-repo-1
bash scripts/preflight-check.sh
```

**本地端 (Windows)**
```powershell
cd D:\dev\carrey-test-repo-1
.\tools\preflight-check.ps1
```

---

## 三、严格模式

使用 `--strict` (Linux) 或 `-Strict` (Windows) 启用严格模式：

```bash
# Linux
bash scripts/preflight-check.sh --strict

# Windows
.\tools\preflight-check.ps1 -Strict
```

严格模式下：
- 禁止直接提交到 main 分支
- 警告视为错误

---

## 四、常见问题处理

### 1. 检查失败：不是 Git 仓库
**原因**：当前目录不是 Git 仓库  
**解决**：确保在正确的仓库目录中执行

### 2. 检查失败：缺少目录
**原因**：docs/, scripts/, tools/ 中有缺失  
**解决**：检查仓库结构是否完整

### 3. 检查失败：脚本语法错误
**原因**：.sh 或 .ps1 文件有语法错误  
**解决**：检查并修复脚本语法

### 4. 警告：空 Markdown 文件
**原因**：存在空的 .md 文件  
**解决**：删除空文件或添加内容

### 5. 警告：在 main 分支
**原因**：当前在 main 分支开发  
**解决**：切换到 feature 分支：
```bash
git checkout -b chore/your-feature
```

---

## 五、集成到开发流程

### 手动执行
每次提交前手动运行：
```bash
# 服务器端
bash scripts/preflight-check.sh

# 本地端
.\tools\preflight-check.ps1
```

### 作为钩子（可选）
如果需要自动执行，可以在 `.git/hooks/pre-commit` 中添加调用（但不建议在测试仓强制推行）。

---

## 六、技术说明

- **轻量**：无外部依赖，仅使用系统自带工具
- **快速**：检查时间 < 1 秒
- **安全**：只读检查，无破坏性操作
- **跨平台**：支持 Linux (Bash) 和 Windows (PowerShell)

---

## 七、后续扩展

可考虑新增检查项：
- 文件大小限制
- 禁止提交特定文件类型（如 .log）
- 强制提交信息格式
- 检查敏感信息（如 API Key 模式）

---

*本文档为预提交检查机制 v1.0*