# 22-shared-docs-status-index

## 文档目的
用于说明 `docs/collab/chatgpt-lingxi/` 中各文档的当前状态，区分“当前有效”“过程留痕”“历史参考”，减少后续维护与 AI 读取时的歧义。

## 一、当前优先参考的文档
以下文档作为当前阶段的主入口：

- `README.md`
- `11-github-writeback-status.md`
- `19-openclaw-agent-phase5-status.md`
- `21-env-plan-2.0-brief.md`

## 二、过程留痕 / smoke test 文档
以下文档保留为执行证据与过程留痕，不作为当前主口径：

- `14-codex-cli-smoke-test.md`
- `18-openclaw-agent-smoke-test.md`
- `98-lingxi-write-test.md`
- `2026-03-15-第3.5步-方案2-GitHub配置-执行结果.md`

## 三、历史参考文档
以下文档保留用于阶段复盘、历史决策参考，但当前口径已被较新文档覆盖：

- `00-context.md`
- `10-status.md`
- `12-current-overall-status.md`
- `13-current-status-brief.md`
- `16-codex-cli-phase4-brief.md`
- `17-current-overall-status-through-phase4.md`
- `20-next-actions.md`
- `30-decisions.md`
- `99-handoff.md`

## 四、当前使用建议
- 查当前状态，优先看：`19-openclaw-agent-phase5-status.md`、`21-env-plan-2.0-brief.md`
- 查 GitHub 写回边界，优先看：`11-github-writeback-status.md`
- 查某一步是否真的跑通过，优先看 smoke test / 执行结果文档
- 历史文档默认不删除，但不作为当前主口径

## 五、维护原则
- 新状态优先沉淀到当前有效文档
- smoke test 继续单独留痕
- 历史参考文件不急着迁移或删除
- 当前阶段不做大规模目录重构

## 2026.4.6 环境情况
- 145-dev-env-baseline-4.5.1.md：当前开发环境 4.5.1 基线说明