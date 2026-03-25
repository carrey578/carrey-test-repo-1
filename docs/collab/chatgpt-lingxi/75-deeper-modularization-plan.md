# 更深模块化整理计划

> 任务53 - 更深模块化整理试运行
> 生成时间：2026-03-25 11:02 CST

---

## 一、识别最值得整理的区域

### 当前脚本情况

| 脚本 | 行数 | 整理价值 |
|------|------|----------|
| dev-entry-v2.sh | 297 | 高 |
| generate-handoff-v2.sh | 241 | 中 |
| generate-change-summary-v2.sh | 180 | 中 |
| lib-common.sh | 51 | 低(可扩展) |

### 识别结果

**最值得整理的区域**：各脚本中重复的 Git 操作和输出函数

### 具体重复项

1. **Git 信息获取**：每个脚本都重复获取 branch/commit/status
2. **消息函数**：log_info/log_success/log_error 重复定义
3. **目录检查**：检查 repo root 的逻辑重复
4. **输出格式**：表格输出、统计信息输出重复

---

## 二、整理方案

### 方案：扩展 lib-common.sh

**策略**：将重复代码抽取到 lib-common.sh，让各脚本引用

### 计划添加的公共函数

| 函数名 | 功能 | 原重复位置 |
|--------|------|------------|
| get_git_status | 获取 Git 状态 | 各脚本 |
| get_git_changes | 获取改动文件列表 | generate-* |
| get_repo_info | 获取仓库基本信息 | 所有脚本 |
| log_success | 成功消息 | dev-entry-v2 |
| log_error | 错误消息 | dev-entry-v2 |
| ensure_dir | 确保目录存在 | generate-* |
| get_timestamp | 获取时间戳 | generate-* |

### 预期收益

1. **代码复用**：减少重复代码约 100 行
2. **维护性**：修改公共逻辑只需改一处
3. **一致性**：统一输出格式
4. **可测试性**：公共函数可单独测试

---

## 三、实施步骤

1. 扩展 lib-common.sh，添加新公共函数
2. 修改 dev-entry-v2.sh，引用新的公共函数
3. 修改 generate-*.sh，引用新的公共函数
4. 验证所有脚本仍能正常运行
5. 记录整理前后对比

---

## 四、控制范围

- 只修改 `scripts/` 目录
- 不修改 `tools/` 目录（Windows 版）
- 不修改任何文档
- 总改动控制在 5 个文件以内

---

## 五、恢复方案

```bash
# 如需恢复
git checkout HEAD -- scripts/lib-common.sh
git checkout HEAD -- scripts/dev-entry-v2.sh
git checkout HEAD -- scripts/generate-*.sh
```

---

*本文档为整理计划*
