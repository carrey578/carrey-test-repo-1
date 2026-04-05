# Repo Health Check 交接文档

## 项目背景

本项目旨在为仓库提供统一的 health check 链路，当前已通过本地验证并产出三份协作文档。

## 当前状态

- **分支**: `chore/cursor-bootstrap`
- **验证结果**: 全部通过 (exit code = 0)
- **产出文档**:
  - `142-repo-health-check-overview.md` - 概览
  - `143-repo-health-check-verify.md` - 验证指南
  - 本文档

## 已验证脚本清单

| 脚本 | 路径 | 状态 |
|------|------|------|
| dev-entry.ps1 | tools/dev-entry.ps1 | ✅ PASS |
| preflight-check.ps1 | tools/preflight-check.ps1 | ✅ PASS |
| verify-dev-entry.ps1 | tools/verify-dev-entry.ps1 | ✅ PASS |
| repo-health-check.ps1 | tools/repo-health-check.ps1 | ✅ PASS |

## 使用说明

### 新成员快速上手

1. **确认环境**：
   ```powershell
   Set-Location "D:\dev\carrey-test-repo-1"
   ```

2. **运行统一检查**：
   ```powershell
   .\tools\repo-health-check.ps1
   ```

3. **查看文档**：
   - 概览: `docs/collab/chatgpt-lingxi/142-repo-health-check-overview.md`
   - 验证: `docs/collab/chatgpt-lingxi/143-repo-health-check-verify.md`

### 推荐工作流

```
开发前 → check-dev-env → 开发 → preflight-check → 提交 → verify
```

## 维护指南

### 更新检查脚本

1. 修改对应 `.ps1` 文件
2. 本地验证通过
3. 提交到 `chore/cursor-bootstrap` 分支
4. 更新本文档相关记录

### 添加新检查项

1. 在对应脚本中添加检查逻辑
2. 更新 `repo-health-check.ps1` Wrapper
3. 验证通过后更新文档

## 分支管理

- **当前分支**: `chore/cursor-bootstrap`
- **主分支**: `main`
- **合并策略**: 通过 PR 合并到 main

## 后续计划

- 阶段 6 暂缓，不影响主流程
- 持续优化检查链路
- 考虑扩展到服务器端

## 交接检查点

- [x] 142 概览文档已创建
- [x] 143 验证指南已创建
- [x] 本文档已创建
- [x] 所有脚本已验证通过
- [x] 已 commit 到 chore/cursor-bootstrap