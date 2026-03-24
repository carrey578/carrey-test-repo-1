# 任务25 - 功能 Handoff 文档

> 生成时间：2026-03-25 01:57 CST
> 执行者：灵犀
> 分支： chore/cursor-bootstrap

---

## 一、功能信息

| 项目 | 值 |
|------|-----|
| 功能名称 | 脚本联动调用（统一入口增强） |
| 任务编号 | 任务23 |
| 开发日期 | 2026-03-25 |
| 状态 | 已完成并验证 |

---

## 二、功能描述

增强统一入口脚本 `dev-entry.sh`/`dev-entry.ps1`，使其可以直接调用其他脚本，形成工具链联动。

**新增命令**：
- `all` - 运行所有检查
- `preflight` - 运行预提交检查
- `report` - 生成变更报告

---

## 三、关键文件

| 文件 | 职责 |
|------|------|
| `scripts/dev-entry.sh` | Linux 端入口 |
| `tools/dev-entry.ps1` | Windows 端入口 |
| `scripts/verify-dev-entry.sh` | 验证脚本 |

---

## 四、验证状态

| 验证项 | 状态 |
|--------|------|
| help 显示新命令 | ✅ |
| preflight 命令 | ✅ |
| report 命令 | ✅ |
| all 命令 | ✅ |
| 旧命令兼容 | ✅ |
| 验证脚本 | ✅ |

---

## 五、使用说明

### 快速开始

```bash
# Linux
bash scripts/dev-entry.sh all

# Windows
.\tools\dev-entry.ps1 all
```

### 详细说明

见：`docs/feature-usage-guide.md`

---

## 六、开发者说明

见：`docs/feature-dev-notes.md`

---

## 七、后续任务建议

| 优先级 | 任务 | 说明 |
|--------|------|------|
| 1 | 增加 sync 命令 | 自动拉取最新代码 |
| 2 | 增加日志输出 | 同时写入日志文件 |
| 3 | 增加配置支持 | 通过 JSON 配置行为 |

---

## 八、交接确认

- [x] 功能已完成
- [x] 验证脚本可运行
- [x] 使用说明已补齐
- [x] 开发者说明已补齐
- [x] 文档齐全

---

*本文档为功能 Handoff v1.0*