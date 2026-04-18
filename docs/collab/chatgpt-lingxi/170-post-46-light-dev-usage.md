# 基于《开发环境 4.6版》的后续轻量开发使用说明（可直接交给 Codex）

> 适用范围：本说明用于《开发环境4.6版.md》落盘后的日常轻量开发使用，不是新一轮环境搭建方案。  
> 当前口径：默认轻量任务优先本地 Codex，长任务与批处理优先云上灵犀，GitHub 仍是唯一事实版本库。  
> 版本日期：2026-04-18

---

## 1. 文档用途

本说明对应的是《开发环境 4.6版》进入使用态之后的默认操作方法。

当前环境已经完成从“规划态”向“可复验落地态”的切换：

- 本地 Surface + GitHub + Codex CLI 的轻量协作链路已跑通
- 阶段 7.1 ~ 7.5 与阶段 8 已完成
- 默认轻量任务可直接走本地 Codex + 本地验收
- 云上腾讯云 / OpenClaw（灵犀）继续保留为更重任务、更长链路和 Agent 常驻执行位
- 当前常用分支仍是 `work/lingxi-codex-bootstrap`
- 当前常用验收脚本仍是：
  - `tools/dev-entry.ps1`
  - `tools/verify-dev-entry.ps1`
  - `tools/repo-health-check.ps1`

因此，后续重点不再是继续扩环境，而是把现有环境真正用起来。

---

## 2. 当前统一使用口径

### 2.1 一句话口径

**本地 Codex 负责快、小、清晰的任务；云上灵犀负责长、重、自动化的任务；GitHub 仍是唯一事实版本库；人工主要负责定目标、看结果、做最终验收。**

### 2.2 当前默认策略

1. **不再额外开大阶段**  
   除非出现新的真实协作链需求，否则不再为“环境工程”本身开阶段。

2. **轻量任务默认本地先走**  
   文档、小修、小范围脚本改动、diff 检查、验收、提交推送，优先本地 Codex。

3. **云上资源尽量真正用起来**  
   既然当前云服务器、Coding Plan、ChatGPT Plus 都已固定付费，且当前环境里没有高敏资料，就不必再把灵犀限制得过紧。  
   可以把云上灵犀作为：
   - 长任务执行位
   - 多步骤自动执行位
   - 批量扫描 / 批量修订位
   - 容器 / 常驻 Agent / 后台任务位
   - 大一点的试验位

4. **权限口径可明显放宽，但范围仍要清楚**  
   当前可以接受：
   - 分支内自动改动
   - 分支内自动 commit / push
   - 云上安装必要依赖
   - 云上跑容器、脚本、批处理
   - 生成中间文件、日志、报告  
   但仍不建议默认直接碰：
   - `main` 分支
   - 明显不可逆的大删改
   - 未明确授权的系统级重装

---

## 3. 后续推荐的分工方式

### 3.1 本地 Surface + Codex

适合承担：

- 文档撰写与更新
- 小范围脚本修改
- help / 提示语 / 输出文案优化
- 仓库内目标文件定位
- diff 检查
- 本地验收
- commit / push
- 对灵犀任务做拆解与回收

意义：

- 这是最短路径，反馈快，最适合“想到就做的小任务”
- 把轻任务都在本地消化掉，云上资源就能集中给真正值得云上做的事情

### 3.2 云上灵犀

适合承担：

- 长时间运行脚本
- 批量文件扫描 / 批量修订
- 大范围 repo 巡检
- 多步骤自动化执行
- 容器 / 常驻 Agent / 后台任务
- 云上日志采集、导出、汇总
- 多轮命令串联
- 本地不想持续盯着跑的工作

建议权限：

- 可在非 `main` 分支直接执行
- 可直接 `git fetch / pull / commit / push`
- 可安装任务所需轻依赖
- 可写临时目录、报告目录、导出目录
- 可在云上先跑一轮，再把结果交回本地 Codex / 人工验收

意义：

- 这一步是把“灵犀是保留位”真正升级成“灵犀是实用执行位”
- 后续如果要做稍复杂的小项目，不用先扩环境，直接让灵犀接重活即可

### 3.3 人工

当前人工重点只保留三件事：

1. 定任务边界
2. 看最终 diff / 结果
3. 决定是否接受、提交、合并

不再需要人工盯每一个中间小动作。

---

## 4. 后续轻量开发的默认工作流

### 4.1 工作流 A：本地 Codex 直做型

适用场景：

- 改 1~5 个文件
- 文档、playbook、session log
- 小范围 PowerShell 文案修补
- repo 内已有模式的轻微延续

默认步骤：

1. 进入仓库并确认状态

```powershell
Set-Location "D:\dev\carrey-test-repo-1"
git fetch origin
git pull --ff-only origin work/lingxi-codex-bootstrap
git status
git branch --show-current
```

预期：

- 当前分支是 `work/lingxi-codex-bootstrap`
- `working tree clean`

2. 把任务直接发给 Codex  
   建议明确写清楚：
   - 只改哪些文件
   - 不准改哪些文件
   - 是否允许 commit / push
   - 是否需要补 `152-lingxi-codex-session-log.md`

3. 查看改动

```powershell
git diff --name-only
git diff
```

4. 本地验收

```powershell
.\tools\dev-entry.ps1 help
.\tools\verify-dev-entry.ps1
.\tools\repo-health-check.ps1
```

5. 提交与推送

```powershell
git add <files>
git commit -m "<message>"
git push origin work/lingxi-codex-bootstrap
```

意义：

- 最快闭环，最适合日常小开发

### 4.2 工作流 B：云上灵犀执行型

适用场景：

- 长任务
- 批处理
- 多步骤串联
- 不想在本地一直盯着的执行
- 想充分利用云服务器与灵犀

默认步骤：

1. 先由本地 Codex 生成任务说明  
   建议在 `docs/collab/chatgpt-lingxi/` 下补一个简短任务单，写清楚：
   - 任务目标
   - 文件范围
   - 允许改动范围
   - 验收命令
   - 回退方式

2. 把任务交给灵犀  
   推荐模板：

```text
请在云上执行本任务，默认允许你在当前任务分支内自主完成：
1. 先确认当前工作目录、分支、git 状态
2. 拉取最新远端
3. 按任务单执行修改 / 生成报告 / 跑脚本
4. 保留关键执行日志
5. 自查 diff
6. 若任务边界清楚且结果正常，允许直接 commit / push 到当前任务分支
7. 最后回报：改了哪些文件、跑了哪些命令、是否通过、是否已 push
```

3. 云上先自验  
   建议至少跑：
   - `git status`
   - `git diff --name-only`
   - 相关脚本或测试
   - 需要时输出报告或日志

4. 本地回收结果

```powershell
git fetch origin
git pull --ff-only origin work/lingxi-codex-bootstrap
git diff HEAD~1 HEAD --name-only
git diff HEAD~1 HEAD
```

然后再补跑本地验收。

意义：

- 把“重活、慢活、脏活”尽量丢给云上，让本地只做控制与验收

### 4.3 工作流 C：本地 Codex + 云上灵犀协同型

适用场景：

- 任务不大，但步骤较多
- 需要本地先设计，再让云上跑
- 需要云上产出结果，再回本地收口

推荐分工：

- **ChatGPT**：出方案、拆任务、定边界
- **Codex（本地）**：读仓、写任务单、做小改动、收口文档
- **灵犀（云上）**：跑长链路、批处理、自动执行
- **人工**：只看最终结果与是否接受

这是后续最推荐的常态协作方式。

---

## 5. 后续可直接放开的任务白名单

当前建议直接放开的任务包括：

### 5.1 文档类

- 方案文档
- playbook
- closeout
- handoff
- session log
- 使用说明
- 状态总结

### 5.2 巡检类

- 仓库扫描
- Markdown 批量巡检
- 路径 / 链接 / 标题格式整理
- 文档索引更新
- 报告导出

### 5.3 低风险脚本类

- help 文案
- 提示语
- 输出文字
- 注释
- 包装层脚本
- 不改核心逻辑的小修补

### 5.4 云上自动化类

- 拉仓 / 更新分支
- 跑脚本
- 生成中间报告
- 日志采集
- 临时依赖安装
- 容器 dry run
- 批处理任务

---

## 6. 仍建议保留人工卡口的事项

以下事项，当前仍建议先人工看一眼再放行：

1. 改 `main`
2. 改大量核心逻辑
3. 改依赖版本
4. 改系统级配置
5. 会大范围删文件
6. 会重建云上环境
7. 会引入新的长期常驻服务

这不是因为当前环境不允许，而是因为这些动作已经不属于“轻量开发使用说明”的范围。

---

## 7. 后续最推荐的真实用法

后续不要再把重点放在“继续造环境文档”，而是直接开始做这三类小任务：

### 类型 A：文档与规则沉淀

例如：

- 更新某个流程说明
- 生成某个任务模板
- 补充某个 handoff 入口
- 收口某个阶段总结

### 类型 B：仓库轻维护

例如：

- 巡检 `docs/`
- 修复 help 文案
- 整理报告脚本输出
- 统一提示语和命名

### 类型 C：轻量云上自动化

例如：

- 让灵犀在云上做 repo 巡检并回传报告
- 让灵犀批量生成 markdown 索引
- 让灵犀执行长一点的检查链
- 让灵犀跑容器或脚本试验，再由本地 Codex 收口

---

## 8. 给 Codex 的落盘执行要求

这一份说明文档，建议优先由本地 Surface 上的 Codex 落盘，不要人工手写。

### 8.1 建议落盘位置

```text
docs/collab/chatgpt-lingxi/170-post-46-light-dev-usage.md
```

### 8.2 本轮允许修改的文件

仅允许：

1. 新建本说明文档
2. 更新 `docs/collab/chatgpt-lingxi/152-lingxi-codex-session-log.md`

不要改其他文件。

### 8.3 Codex 执行任务说明

可直接发给 Codex：

```text
请在本地仓库 D:\dev\carrey-test-repo-1 中落盘一份新文档，标题为《基于〈开发环境 4.6版〉的后续轻量开发使用说明（可直接交给 Codex）》。

要求：
1. 先读取仓库根目录的《开发环境4.6版.md》
2. 在 docs/collab/chatgpt-lingxi/ 下新建一份编号顺延的 markdown 文档，文件名可用 170-post-46-light-dev-usage.md；若 170 已占用则顺延
3. 文档内容以“后续轻量开发如何实际使用当前 4.6 环境”为主题
4. 同时在 152-lingxi-codex-session-log.md 追加本轮记录
5. 只允许修改这两个 markdown 文件
6. 不要修改 tools/*.ps1、scripts/*、配置文件或其他文档
7. 完成后先自查 git diff --name-only，再回报
8. 若 diff 正常，再执行：
   - .\tools\dev-entry.ps1 help
   - .\tools\verify-dev-entry.ps1
   - .\tools\repo-health-check.ps1
9. 验收通过后可直接 commit 并 push 到 work/lingxi-codex-bootstrap
10. commit message 建议：docs: add post-4.6 light development usage guide
```

### 8.4 人工需要配合的环节

通常只需要人工做两件事：

1. 把任务说明发给 Codex
2. 在 Codex 回报 diff 后，看一眼是否只改了目标两个文件

如果 Codex 已经做完、验收通过、diff 清楚，可以直接让它提交推送。

---

## 9. 这份说明的意义

### 9.1 对当前整体环境的意义

把《开发环境 4.6版》从“环境总说明”进一步变成“可日常执行的操作说明”。

### 9.2 对下一步的意义

后续真正开始做小任务时，不需要再回头讨论“到底该本地做还是云上做”，直接按这份说明执行即可。
