# 回归汇总报告

> 生成时间: 2026-03-25 11:07:57
> 分支: chore/cursor-bootstrap
> 提交: a9c66a9

---

## 一、执行摘要

| 项目 | 状态 |
|------|------|
| Verify 结果 | ✅ 通过 |
| 最近改动 | 3 个提交 |
| 建议 | ✅ 建议继续 |

---

## 二、Verify 结果

```
[0;34m=== 主功能最小验证 ===[0m

[0;34mℹ[0m 检查 dev-entry.sh 文件...
[0;32m✓[0m dev-entry.sh 存在
[0;34mℹ[0m 检查执行权限...
[0;32m✓[0m 有执行权限
[0;34mℹ[0m 测试 help 命令...
[0;32m✓[0m help 命令正常
[0;33m⊘[0m status 命令 (快速模式)
[0;33m⊘[0m preflight 命令 (快速模式)
[0;34mℹ[0m 检查命令列表...
[0;32m✓[0m 所有核心命令存在

[0;34m=== 验证结果 ===[0m
通过: [0;32m4[0m
失败: [0;31m0[0m
跳过: [0;33m2[0m

[0;32m✅ 验证通过 - 主功能可正常使用[0m
```

---

## 三、最近改动 (3 个提交)

A	docs/collab/chatgpt-lingxi/75-deeper-modularization-plan.md
A	docs/collab/chatgpt-lingxi/76-deeper-modularization-summary.md
A	docs/collab/chatgpt-lingxi/77-change-summary-example.md
A	docs/collab/chatgpt-lingxi/78-demo-summary.md
A	docs/demo-guide.md
A	scripts/README-change-summary.md
A	scripts/demo-entry.sh
M	scripts/lib-common.sh

---

## 四、风险点识别

\n  - docs/collab/chatgpt-lingxi/75-deeper-modularization-plan.md (文档，风险较低)\n  - docs/collab/chatgpt-lingxi/76-deeper-modularization-summary.md (文档，风险较低)\n  - docs/collab/chatgpt-lingxi/77-change-summary-example.md (文档，风险较低)\n  - docs/collab/chatgpt-lingxi/78-demo-summary.md (文档，风险较低)\n  - docs/demo-guide.md (文档，风险较低)\n  - scripts/README-change-summary.md (文档，风险较低)\n  - scripts/demo-entry.sh (脚本，可能影响功能)\n  - scripts/lib-common.sh (脚本，可能影响功能)

---

## 五、建议

### 5.1 是否继续下一轮改动

✅ 建议继续

### 5.2 注意事项

- [ ] 检查新增/修改的脚本是否正常工作
- [ ] 验证公共库改动是否影响其他脚本
- [ ] 确认文档更新是否完整

---

## 六、验证命令

```bash
# 快速验证
bash scripts/verify-main-feature.sh --quick

# 完整验证
bash scripts/verify-main-feature.sh

# 变更摘要
bash scripts/generate-change-summary-v2.sh -n 3
```

---

*本报告由 generate-regression-summary.sh 自动生成*
