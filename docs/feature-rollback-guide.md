# 回滚与恢复手册 - 统一入口功能

> 生成时间：2026-03-25 03:17 CST
> 执行者：灵犀
> 分支： chore/cursor-bootstrap

---

## 一、概述

本文档详细说明统一入口功能（dev-entry.sh）出错时的恢复步骤。

---

## 二、场景与恢复步骤

### 场景 1：参数解析出错

**症状**：执行命令时报错 "unknown option" 或参数不生效

**原因**：参数解析逻辑被破坏

**恢复步骤**：
```bash
# 方法1：使用默认参数
bash scripts/dev-entry.sh check

# 方法2：回滚到上一个版本
git checkout HEAD -- scripts/dev-entry.sh

# 方法3：如果知道好的 commit，回滚到该 commit
git checkout <good-commit-hash> -- scripts/dev-entry.sh

# 验证恢复
bash scripts/dev-entry.sh help
```

---

### 场景 2：子脚本调用失败

**症状**：执行命令时提示 "No such file or directory"

**原因**：子脚本路径错误或被删除

**恢复步骤**：
```bash
# 检查子脚本是否存在
ls -la scripts/*.sh

# 如果缺失，从 git 恢复
git checkout HEAD -- scripts/check-dev-env-server.sh
git checkout HEAD -- scripts/preflight-check.sh
git checkout HEAD -- scripts/generate-change-report.sh

# 验证
bash scripts/dev-entry.sh check
```

---

### 场景 3：公共库引入失败

**症状**：报错 "lib-common.sh: not found" 或颜色变量未定义

**原因**：lib-common.sh 路径错误或被删除

**恢复步骤**：
```bash
# 检查公共库是否存在
ls -la scripts/lib-common.sh

# 如果缺失，恢复
git checkout HEAD -- scripts/lib-common.sh

# 或者手动修复路径
# 编辑 dev-entry.sh，检查 source 行：
source "$SCRIPT_DIR/lib-common.sh"
```

---

### 场景 4：输出格式混乱

**症状**：输出乱码、颜色异常、格式错位

**原因**：颜色定义被修改或编码问题

**恢复步骤**：
```bash
# 回滚到上一个版本
git checkout HEAD -- scripts/dev-entry.sh

# 验证
bash scripts/dev-entry.sh status
```

---

### 场景 5：命令函数丢失

**症状**：执行命令时提示 "command not found"

**原因**：函数定义被删除或命名错误

**恢复步骤**：
```bash
# 检查函数定义
grep -n "cmd_" scripts/dev-entry.sh | head -20

# 如果缺失，回滚
git checkout HEAD -- scripts/dev-entry.sh

# 验证
bash scripts/dev-entry.sh check
```

---

### 场景 6：Windows 版问题

**症状**：PowerShell 版本报错

**原因**：PowerShell 语法被破坏

**恢复步骤**：
```powershell
# 回滚
git checkout HEAD -- tools/dev-entry.ps1

# 验证
.\tools\dev-entry.ps1 help
```

---

## 三、快速回滚命令

### 全部回滚（推荐）

```bash
# 回滚 dev-entry 相关文件
git checkout HEAD -- scripts/dev-entry.sh
git checkout HEAD -- tools/dev-entry.ps1
git checkout HEAD -- scripts/lib-common.sh
git checkout HEAD -- scripts/README.md

# 验证
bash scripts/dev-entry.sh help
```

### 单独回滚

```bash
# 只回滚主脚本
git checkout HEAD -- scripts/dev-entry.sh

# 只回滚公共库
git checkout HEAD -- scripts/lib-common.sh
```

---

## 四、验证恢复

恢复后，请执行以下验证：

```bash
# 1. 帮助命令
bash scripts/dev-entry.sh help

# 2. 执行命令
bash scripts/dev-entry.sh status

# 3. 参数命令
bash scripts/dev-entry.sh -v check

# 4. 验证脚本
bash scripts/verify-dev-entry.sh
```

---

## 五、预防措施

1. **改动前备份**：重要改动前创建备份分支
2. **小步提交**：每次小改动后测试再继续
3. **验证脚本**：使用 verify-dev-entry.sh 验证
4. **回归检查**：改完后执行回归检查清单

---

## 六、联系方式

如遇无法恢复的问题，请联系：
- 检查 Git 历史：`git log --oneline -10`
- 回滚到稳定版本：`git checkout <stable-commit> -- scripts/dev-entry.sh`

---

*本文档为回滚与恢复手册 v1.0*