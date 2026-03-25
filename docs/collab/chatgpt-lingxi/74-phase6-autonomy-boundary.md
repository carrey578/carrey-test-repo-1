# 更高自治试运行边界说明

> 任务52 - 第6批更高自治试运行边界说明
> 生成时间：2026-03-25 11:00 CST
> 分支：chore/cursor-bootstrap

---

## 一、边界分类

### 1.1 默认可直接执行

| 任务类型 | 说明 | 示例 |
|----------|------|------|
| 文档编写 | 生成/更新文档 | 更新 README、整理文档 |
| 脚本增强 | 小范围优化已有脚本 | 添加参数、修复 bug |
| 巡检 | 运行检查脚本 | verify、status check |
| 状态报告 | 生成自动化报告 | status-report、change-summary |
| Handoff 草稿 | 自动生成交接文档 | generate-handoff-v2 |

### 1.2 先出 Plan 再执行

| 任务类型 | 说明 | 示例 |
|----------|------|------|
| 模块化整理 | 抽出公共函数、拆分文件 | 重构 lib-common.sh |
| 功能增强 | 添加新命令/功能 | dev-entry-v2 添加新子命令 |
| 配置变更 | 修改配置常量 | 路径、颜色、输出格式 |
| 多文件联动 | 涉及多个脚本修改 | 统一入口层 |

### 1.3 必须人工确认

| 任务类型 | 说明 | 示例 |
|----------|------|------|
| 代码开发 | 新增/修改业务代码 | 添加新功能模块 |
| 删除操作 | 删除已有文件 | 删除脚本、文档 |
| 权限变更 | 调整执行权限 | chmod、访问控制 |
| 分支操作 | 切换分支、合并 | checkout、merge |
| 发布操作 | 推送到正式分支 | push 到 main |

### 1.4 当前仍禁止

| 操作 | 说明 |
|------|------|
| force push | 禁止 git push -f |
| 改 main | 只能在 chore/cursor-bootstrap |
| 改 systemd | 禁止修改系统服务配置 |
| 改 OpenClaw 配置 | 禁止修改核心运行配置 |
| 写入真实 token | 禁止写入 secrets |
| 大规模重构 | 禁止一次性大范围改动 |

---

## 二、任务类型级别边界

### 2.1 文档类任务

| 操作 | 权限 |
|------|------|
| 生成新文档 | ✅ 默认可执行 |
| 更新现有文档 | ✅ 默认可执行 |
| 删除旧文档 | ⚠️ 先出 plan |
| 移动文档位置 | ⚠️ 先出 plan |

### 2.2 脚本类任务

| 操作 | 权限 |
|------|------|
| 运行已有脚本 | ✅ 默认可执行 |
| 添加新脚本 | ✅ 默认可执行 |
| 修改脚本 bug | ✅ 默认可执行 |
| 添加新功能 | ⚠️ 先出 plan |
| 删除脚本 | ⚠️ 先出 plan |
| 重构脚本 | ⚠️ 先出 plan |

### 2.3 自动化类任务

| 操作 | 权限 |
|------|------|
| 运行 verify | ✅ 默认可执行 |
| 生成状态报告 | ✅ 默可达执行 |
| 生成 Handoff | ✅ 默认可执行 |
| 生成 Regression Summary | ✅ 默认可执行 |
| 新建自动化流程 | ⚠️ 先出 plan |

### 2.4 代码开发类

| 操作 | 权限 |
|------|------|
| 轻量修改 | ⚠️ 先出 plan |
| 中等修改 | ❌ 必须人工确认 |
| 新功能开发 | ❌ 必须人工确认 |

---

## 三、主动停止条件

### 3.1 应主动停止的情况

| 情况 | 说明 |
|------|------|
| verify 失败 | 运行 verify 后有失败项，应先修复 |
| 权限疑问 | 不确定是否有权限时，先问人工 |
| 改动范围过大 | 改动超过3个文件，先出 plan |
| 依赖不明确 | 需要安装新依赖，先确认 |
| 冲突风险 | 可能与人工改动冲突时，先沟通 |

### 3.2 应先生成恢复建议的情况

| 情况 | 说明 |
|------|------|
| 回滚可能 | 改动可能需要回滚时，先准备回滚命令 |
| 不可逆操作 | 删除、移动等操作，先准备恢复方式 |
| 大改动前 | 超过3个文件改动，准备恢复方案 |
| 新依赖 | 引入新依赖前，准备移除方式 |

---

## 四、基于当前仓的具体边界

### 4.1 当前可自治执行的

```bash
# 文档类
bash scripts/dev-entry-v2.sh docs
bash scripts/generate-status-report.sh
bash scripts/generate-handoff-v2.sh -t "任务"

# 验证类
bash scripts/verify-main-feature.sh
bash scripts/verify-main-feature.sh --quick

# 报告类
bash scripts/generate-change-summary-v2.sh
bash scripts/dev-entry-v2.sh report

# 巡检类
bash scripts/dev-entry-v2.sh status
bash scripts/dev-entry-v2.sh check
```

### 4.2 需要先出 plan 的

| 操作 | 示例 |
|------|------|
| 添加新命令 | 在 dev-entry-v2 中添加新子命令 |
| 抽取公共函数 | 从 dev-entry.sh 抽出函数到 lib-common.sh |
| 修改输出格式 | 更改报告的 markdown 格式 |
| 新建脚本 | 创建新的自动化脚本 |

### 4.3 必须人工确认的

| 操作 | 示例 |
|------|------|
| 删除文档 | 删除 docs/main-feature-*.md |
| 删除脚本 | 删除 scripts/dev-entry.sh |
| 改 README | 修改 README.dev.md |
| 创建代码文件 | 添加 .js/.py 等业务代码 |

---

## 五、边界速查表

| 场景 | 操作 | 权限 |
|------|------|------|
| 运行 verify | verify-main-feature.sh | ✅ |
| 生成报告 | generate-*.sh | ✅ |
| 更新文档 | docs/*.md | ✅ |
| 添加新脚本 | scripts/new.sh | ✅ |
| 修改脚本 bug | scripts/*.sh | ✅ |
| 添加新命令 | dev-entry-v2.sh | ⚠️ |
| 删除文件 | rm | ❌ |
| 改 main | git push origin main | ❌ |

---

## 六、相关文档

| 文档 | 说明 |
|------|------|
| `docs/collab/chatgpt-lingxi/73-phase6-readiness-assessment.md` | 就绪评估 |
| `docs/collab/chatgpt-lingxi/69-multi-agent-collab-rules.md` | 多 Agent 规则 |
| `docs/collab/chatgpt-lingxi/70-lingxi-long-term-working-list.md` | 长期工作清单 |

---

*本文档为任务52输出*
