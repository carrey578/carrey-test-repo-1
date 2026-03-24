# Feature Task Template

> 任务名称：TASK-XXX
> 生成时间：{{date}}
> 执行者：灵犀
> 分支：chore/cursor-bootstrap

---

## 一、任务基本信息

| 项目 | 值 |
|------|-----|
| 任务编号 | TASK-XXX |
| 任务名称 | {{task_name}} |
| 任务目标 | {{brief_description}} |
| 任务类型 | [ ] 功能开发 [ ] 优化 [ ] 改造 [ ] 文档 |
| 优先级 | P0 / P1 / P2 / P3 |
| 状态 | 待开始 / 进行中 / 已完成 |

---

## 二、输入

### 2.1 需求输入

```
{{requirement_description}}
```

### 2.2 约束条件

| 约束 | 说明 |
|------|------|
| 分支限制 | chore/cursor-bootstrap |
| 禁止操作 | main / systemd / OpenClaw 核心配置 / force push |
| 技术限制 | {{technical_constraints}} |

### 2.3 参考资源

| 资源 | 位置/链接 |
|------|----------|
| 相关文档 | {{related_docs}} |
| 相关代码 | {{related_code}} |

---

## 三、输出

### 3.1 预期交付物

| 交付物 | 类型 | 位置 |
|--------|------|------|
| {{deliverable_1}} | {{type}} | {{path}} |
| {{deliverable_2}} | {{type}} | {{path}} |

### 3.2 输出格式要求

- Markdown 格式
- 包含必要的目录和文件说明
- 包含验证说明

---

## 四、验收标准

### 4.1 功能验收

| 验收项 | 标准 | 验证方式 |
|--------|------|----------|
| {{item_1}} | {{criteria}} | {{verification}} |
| {{item_2}} | {{criteria}} | {{verification}} |

### 4.2 质量验收

| 验收项 | 标准 |
|--------|------|
| 代码规范 | 符合现有代码风格 |
| 文档完整 | 包含 README/使用说明 |
| 无破坏性改动 | 不影响现有功能 |

---

## 五、风险评估

| 风险 | 等级 | 应对措施 |
|------|------|----------|
| {{risk_1}} | 高/中/低 | {{mitigation}} |
| {{risk_2}} | 高/中/低 | {{mitigation}} |

---

## 六、最小回滚方案

```bash
# 回滚命令
{{rollback_commands}}

# 验证
{{verification_commands}}
```

---

## 七、任务流转

| 阶段 | 状态 | 完成时间 | 备注 |
|------|------|----------|------|
| Plan | ⬜ | | 产出计划文档 |
| Execute | ⬜ | | 执行开发 |
| Verify | ⬜ | | 验证功能 |
| Handoff | ⬜ | | 产出交接文档 |

---

*模板版本：v1.0*