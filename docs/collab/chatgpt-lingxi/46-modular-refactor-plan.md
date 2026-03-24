# 任务27 - 小范围模块化改造计划

> 生成时间：2026-03-25 02:04 CST
> 执行者：灵犀
> 分支： chore/cursor-bootstrap

---

## 一、模块化目标区域

**区域**：scripts/ 目录下的脚本

**当前问题**：
- 多个脚本重复定义颜色常量（RED, GREEN, YELLOW, BLUE, NC）
- 多个脚本重复定义消息函数（log_pass, log_fail, log_warn, log_info）
- 缺乏统一的消息输出格式

---

## 二、改造方案

### 2.1 新建公共库

**文件**：`scripts/lib-common.sh`

**包含内容**：
- 颜色定义（RED, GREEN, YELLOW, BLUE, NC）
- 消息函数（log_pass, log_fail, log_warn, log_info）
- 工具函数（get_repo_root, check_git_repo, get_current_branch, get_latest_commit）

### 2.2 改造脚本

选择 `scripts/dev-entry.sh` 作为试点，引入公共库：

**改造前**：
```bash
# 内联定义
RED='\033[0;31m'
GREEN='\033[0;32m'
# ...

log_info() { ... }
log_verbose() { ... }
log_success() { ... }
log_error() { ... }
```

**改造后**：
```bash
# 引入公共库
source scripts/lib-common.sh

# 使用公共函数
log_info "消息"
log_verbose "详细"
log_success "成功"
log_error "错误"
```

---

## 三、预期收益

| 收益 | 说明 |
|------|------|
| 代码减少 | dev-entry.sh 减少约 30 行重复代码 |
| 维护性提升 | 修改颜色/函数只需改一处 |
| 可扩展性 | 新脚本可直接引用公共库 |
| 一致性 | 所有脚本使用相同的输出格式 |

---

## 四、改造范围控制

- 仅改造 `scripts/dev-entry.sh` 作为试点
- 其他脚本（preflight-check.sh 等）保持不变
- 不改动工具脚本（tools/）

---

## 五、验收标准

| 标准 | 说明 |
|------|------|
| 公共库可用 | lib-common.sh 可被正确 source |
| 功能正常 | dev-entry.sh 原有功能不受影响 |
| 向后兼容 | 不带参数调用仍正常工作 |

---

## 六、待审批后执行