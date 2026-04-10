# 灵犀调用 Codex 就绪检查

**日期：** 2026-04-10  
**分支：** work/lingxi-codex-bootstrap  
**服务器执行位：** /root/workspace/worktrees/lingxi-codex-bootstrap

---

## 一、我理解的允许范围

| 类别 | 具体操作 |
|------|----------|
| 只读分析 | 读仓分析、代码理解、架构梳理 |
| 轻量 review | PR review、代码审查 |
| 文案辅助 | PR 文案、change summary、verify 建议 |
| 小改动 | docs/、tools/、scripts/ 下 1~3 个文件的小修补 |
| 文档生成 | 共享目录 markdown 生成与整理 |

---

## 二、我理解的禁止范围

| 类别 | 具体操作 |
|------|----------|
| 改 main | 禁止修改 main 分支 |
| 大范围重构 | 禁止大规模重构 |
| 删除 | 禁止删除大量文件 |
| 系统配置 | 禁止改 systemd、OpenClaw 核心配置 |
| 密钥 | 禁止改 token、密钥、.env |
| 无范围大改 | 禁止无明确文件范围的跨目录大改 |

---

## 三、我后续调用 Codex 的流程

### 1. 先申请
- 收到任务后，先判断是否符合白名单（150）
- 若需要 Codex，按 151 模板向孟安然发申请单
- 申请单需包含：任务名称、目标文件范围、操作类型、预计轮数、产出

### 2. 获批后执行
- 等待孟安然批准
- 批准后仅在白名单范围内调用 Codex
- 执行位置固定为 `/root/workspace/worktrees/lingxi-codex-bootstrap`
- 仅使用 Codex 做已批准的操作类型

### 3. 后留痕
- 完成后更新 152 session log（记录日期、任务、产出、是否改代码等）
- 输出结果文档
- 明确写出"本轮已结束"
- 恢复默认路线（不再调用 Codex）

---

## 四、执行边界承诺

- ✅ 只在 `/root/workspace/worktrees/lingxi-codex-bootstrap` 中执行试点
- ✅ 旧服务器活跃 repo `/root/workspace/repos/carrey-test-repo-1` 本轮不作为执行位
- ✅ 不真正调用 Codex（本轮为 readiness 确认）
- ✅ 不修改代码
- ✅ 严格按白名单边界执行

---

## 五、本轮状态

- **是否调用 Codex：** 否（本轮为 readiness 确认）
- **是否修改代码：** 否
- **输出文档：** 154-lingxi-codex-readiness-check.md
- **后续：** 等待阶段3的第一轮只读分析试点

---

**确认已读懂规则，愿意按此试点。**
