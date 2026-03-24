# 功能级模板索引

> 生成时间：2026-03-25 02:08 CST
> 执行者：灵犀
> 分支： chore/cursor-bootstrap

---

## 一、模板概览

| 模板 | 文件 | 说明 |
|------|------|------|
| 任务模板 | `template-feature-task.md` | 功能任务完整模板 |
| 计划模板 | `template-feature-plan.md` | 功能开发计划模板 |
| 验证模板 | `template-feature-verify.md` | 功能验证报告模板 |
| 代码改动模板 | `template-code-change.md` | 代码改动记录模板 |
| 交接模板 | `template-feature-handoff.md` | 功能交接文档模板 |

---

## 二、模板使用场景

### 2.1 任务模板 (template-feature-task.md)

**适用场景**：新任务开始时

**包含内容**：
- 任务基本信息（编号、名称、目标）
- 输入（需求、约束、参考资源）
- 输出（交付物、格式要求）
- 验收标准（功能、质量）
- 风险评估
- 最小回滚方案
- 任务流转

---

### 2.2 计划模板 (template-feature-plan.md)

**适用场景**：任务规划阶段

**包含内容**：
- 功能目标
- 技术判断（现状、方案对比）
- 涉及文件
- 子步骤拆解
- 最小验收标准
- 回滚方案
- 测试建议

---

### 2.3 验证模板 (template-feature-verify.md)

**适用场景**：任务验证阶段

**包含内容**：
- 验证目标
- 验证方式（自动 + 手动）
- 验证结果
- 验证通过标准
- 发现的问题
- 验证结论

---

### 2.4 代码改动模板 (template-code-change.md)

**适用场景**：代码改动记录

**包含内容**：
- 改动目标
- 改动文件列表
- Diff 摘要
- 代码改动说明
- 依赖与影响
- 验证建议
- 回滚方案

---

### 2.5 交接模板 (template-feature-handoff.md)

**适用场景**：任务完成交接

**包含内容**：
- 任务信息
- 功能概述
- 关键文件
- 验证状态
- 使用说明
- 交接确认清单
- 后续任务建议
- 联系人

---

## 三、模板使用示例

### 3.1 完整任务流程

```
1. 创建任务 → 使用 template-feature-task.md
2. 制定计划 → 使用 template-feature-plan.md
3. 执行开发 → ---
4. 验证功能 → 使用 template-feature-verify.md
5. 记录改动 → 使用 template-code-change.md
6. 任务交接 → 使用 template-feature-handoff.md
```

### 3.2 快速使用

```bash
# 复制任务模板
cp docs/collab/chatgpt-lingxi/template-feature-task.md docs/collab/chatgpt-lingxi/task-XXX.md

# 复制计划模板
cp docs/collab/chatgpt-lingxi/template-feature-plan.md docs/collab/chatgpt-lingxi/plan-XXX.md

# 复制交接模板
cp docs/collab/chatgpt-lingxi/template-feature-handoff.md docs/collab/chatgpt-lingxi/handoff-XXX.md
```

---

## 四、模板维护

- 模板版本：v1.0
- 基于任务11-27的经验总结
- 持续迭代优化

---

## 五、相关文档

| 文档 | 说明 |
|------|------|
| `docs/collab/chatgpt-lingxi/41-feature-mvp-summary.md` | MVP 实现摘要 |
| `docs/collab/chatgpt-lingxi/42-feature-verification-report.md` | 验证报告 |
| `docs/collab/chatgpt-lingxi/43-feature-handoff.md` | 实际 Handoff 示例 |
| `docs/feature-usage-guide.md` | 功能使用说明 |
| `docs/feature-dev-notes.md` | 开发说明 |

---

*本文档为模板索引 v1.0*