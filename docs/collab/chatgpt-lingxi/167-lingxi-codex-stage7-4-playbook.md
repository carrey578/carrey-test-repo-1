# 灵犀 Codex 阶段 7.4 可直接执行版

这次仍按“必要、够用、轻量”来设计。

---

## 一、阶段 7.4 的定位

阶段 7.4 不是去做复杂任务。  
它的目标很简单：

**再做一次第二个单文件低风险小修补，验证阶段 7.3 不是偶然成功。**

也就是把当前能力从：

- “做成过一次”

推进到：

- “可以连续做成第二次”

这对整个开发环境的意义很大，因为它能证明这条链路已经开始具备**可重复性**。

---

## 二、这轮建议改什么

仍然不要碰复杂逻辑。  
建议只选下面 1 类任务：

## 推荐任务类型
**单文件 help / 文案 / 注释 / 输出提示优化**

## 推荐目标文件
优先级从高到低：

1. `tools/preflight-check.ps1`
2. `tools/repo-health-check.ps1`
3. `tools/verify-dev-entry.ps1`

## 最推荐
先做：

`tools/preflight-check.ps1`

原因：

- 你前面已经碰过这个文件
- 风险相对低
- 验收路径清楚
- 它不是核心入口脚本，心理负担更小

---

## 三、这轮任务边界

这轮明确只允许：

- 改 1 个文件
- 只改 help / 输出文案 / 标题 / 注释
- 不改参数
- 不改退出码
- 不改函数名
- 不改路径逻辑
- 不改判断逻辑
- 不改调用链

一句话：

## 只做“用户可见文本层的小修补”，不做逻辑修复

---

## 四、阶段 7.4 可直接执行版

下面按“人工操作 / Codex任务 / 验收 / 提交”来写。

---

## 第 0 步：开始前确认

### 在哪里
本地 Windows PowerShell

### 怎么做
```powershell
Set-Location "D:\dev\carrey-test-repo-1"
git branch --show-current
git fetch origin
git pull --ff-only origin work/lingxi-codex-bootstrap
git status
git log --oneline -5
```

### 预期结果
你应该看到：

- 当前分支是 `work/lingxi-codex-bootstrap`
- 远端同步成功
- `working tree clean`
- 最近提交里能看到 `b38aa8a` 和 `9c5b475`

### 这一阶段的意义
确认你是从“阶段 7.3 已完成”的干净状态出发，不把旧残留带进来。

---

## 第 1 步：人工先选定本轮唯一目标文件

### 建议直接定为
`tools/preflight-check.ps1`

### 建议目标
例如把某一段输出提示改得更清楚，但不改逻辑。

可接受的例子：

- “检查关键目录...” → “检查关键目录是否齐全...”
- “检查 README 文件...” → “检查 README 文件是否存在...”
- “检查通过但有警告” → “检查通过（存在警告，建议关注）”

### 不要做
下面这些都先不要做：

- 新增参数
- 改返回值
- 改函数结构
- 合并输出逻辑
- 改脚本执行顺序

### 这一阶段的意义
先人为收紧范围，避免 Codex 发散。

---

## 第 2 步：先人工备份现场信息

### 怎么做
```powershell
Remove-Item .\tmp-codex-stage7-4-write.txt -ErrorAction SilentlyContinue
git diff -- tools/preflight-check.ps1
```

### 预期结果
- 临时文件删掉
- `git diff` 没输出，说明目标文件当前无本地改动

### 这一阶段的意义
确保本轮所有变更都来自本次操作，便于回退和验收。

---

## 第 3 步：发给 Codex 的执行指令

### 这是 Codex 的任务
在本地仓库目录执行。

### 指令模板
```powershell
codex exec --sandbox workspace-write --output-last-message .\tmp-codex-stage7-4-write.txt "Modify only tools/preflight-check.ps1.

Task:
- Make one minimal wording-only improvement in user-visible output text.
- Keep the change low risk and easy to review.
- Do not change parameters, function names, exit codes, path logic, conditions, or execution flow.
- Do not modify any other file.

After editing, give a short summary of:
1) what file you changed,
2) what wording you changed,
3) confirmation that no logic was changed."
```

### 预期结果
终端最后应能看到 Codex 的简短总结。  
同时生成：

`tmp-codex-stage7-4-write.txt`

### 这一阶段的意义
这是阶段 7.4 的核心动作：再完成一次第二个单文件、低风险、小修补。

---

## 第 4 步：人工检查 Codex 输出摘要

### 怎么做
```powershell
Get-Content .\tmp-codex-stage7-4-write.txt
```

### 你要重点看什么
确认它是否明确说了：

- 只改了 `tools/preflight-check.ps1`
- 只改了文案
- 没动逻辑

### 如果它说改了多个文件
本轮直接判失败，不进入提交。

---

## 第 5 步：人工检查 diff

### 怎么做
```powershell
git diff -- tools/preflight-check.ps1
git diff --name-only
```

### 通过标准
你应该看到：

- `git diff --name-only` 只出现  
  `tools/preflight-check.ps1`
- diff 内容只体现字符串 / 文案变化

### 不通过标准
如果看到：

- 改了多个文件
- 改了逻辑判断
- 改了退出码
- 改了路径 / 参数

则本轮停止，走失败回退。

### 这一阶段的意义
这是控制范围最关键的一步。  
不是 Codex 说“没改逻辑”就算，而是你自己看 diff 亲自确认。

---

## 第 6 步：跑本地验收

### 怎么做
```powershell
.\tools\verify-dev-entry.ps1
.\tools\repo-health-check.ps1
git status
```

### 通过标准
你希望看到：

- `verify-dev-entry.ps1` 仍然通过
- `repo-health-check.ps1` 仍然通过
- `git status` 只有目标文件和临时 txt 文件变化

### 这一阶段的意义
验证这次第二个小修补没有把当前阶段 7.3 刚建立起来的闭环打坏。

---

## 第 7 步：失败时回退

只要有下面任一情况，就直接回退：

- 改了多个文件
- diff 超出文案层
- 本地验收不通过
- 你看不懂 diff

### 怎么做
```powershell
git restore --source=HEAD -- tools/preflight-check.ps1
Remove-Item .\tmp-codex-stage7-4-write.txt -ErrorAction SilentlyContinue
git status
```

### 预期结果
回到 clean，或至少只剩无关临时文件。

### 这一阶段的意义
保持 7.x 阶段的保守推进方式，不把不确定改动留下来。

---

## 第 8 步：通过后提交

如果第 4 到第 6 步都通过，再提交。

### 怎么做
```powershell
git add tools/preflight-check.ps1
git commit -m "chore: clarify preflight check wording"
git push origin work/lingxi-codex-bootstrap
```

### 预期结果
提交并推送成功。

### 这一阶段的意义
把“第二次低风险单文件 Codex 写入成功案例”正式落仓。

---

## 第 9 步：补 session log

### 建议补到
`docs/collab/chatgpt-lingxi/152-lingxi-codex-session-log.md`

新增一条“第十次记录”或“第十一次记录”，按你当前编号顺延。

### 建议记录的核心点
- 阶段 7.4 的目标文件
- 是否只改了单文件
- 是否只改了文案
- 验收是否通过
- commit hash
- push 是否成功

### 这一阶段的意义
把“第二次成功案例”沉淀为后续阶段依据。

---

## 五、阶段 7.4 的通过标准

满足下面 5 条，就可以定义 7.4 通过：

1. 只改 1 个目标文件
2. 只改 help / 文案 / 注释 / 输出提示
3. `verify-dev-entry.ps1` 通过
4. `repo-health-check.ps1` 通过
5. 已 commit + push，并补 session log

---

## 六、阶段 7.4 完成后的意义

如果 7.4 也通过，说明你已经不只是“偶然成功一次”，而是：

## 已连续完成两次本地 Windows Codex 低风险单文件写入闭环

这时才能更有底气地进入后续轻量扩展，比如：

- 7.5：单文件文档类写入再验证
- 7.6：双文件但同一主题的小变更
- 7.x：更稳的申请-执行-验收模板化

---

## 七、这一轮先不要做什么

阶段 7.4 明确先不要做：

- 不做多文件逻辑改造
- 不做大段重构
- 不做跨目录联动修改
- 不做参数接口调整
- 不做“顺手把别的地方也修了”

---

## 八、建议你现在的执行顺序

直接按这个顺序来最稳：

1. 先把 166 文档落盘
2. 再按 7.4 的第 0 步到第 8 步执行
3. 成功后更新 152 session log
4. 最后再看要不要进入 7.5
