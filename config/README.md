# 配置模板说明

> 生成时间：2026-03-25 01:29 CST
> 执行者：灵犀
> 分支： chore/cursor-bootstrap

---

## 一、模板概览

| 模板文件 | 说明 | 位置 |
|----------|------|------|
| `.env.example` | 环境变量模板 | `config/.env.example` |
| `example-config.json` | 项目配置模板 | `config/example-config.json` |
| `task-template.json` | 任务配置模板 | `config/task-template.json` |

---

## 二、各模板说明

### 1. .env.example

**用途**：环境变量配置模板

**包含字段**：
| 字段 | 类型 | 说明 |
|------|------|------|
| OPENCLAW_GATEWAY_URL | URL | OpenClaw Gateway 地址 |
| OPENCLAW_API_KEY | String | API Key (占位) |
| GITHUB_TOKEN | String | GitHub PAT (占位) |
| GITHUB_USERNAME | String | GitHub 用户名 |
| SSH_HOST | String | 服务器 SSH Host |
| SSH_USER | String | SSH 用户名 |
| SSH_PORT | Number | SSH 端口 (默认 22) |

**使用方式**：
```bash
# 复制为真实配置文件
cp config/.env.example .env

# 编辑填入真实值
nano .env

# 确保 .env 在 .gitignore 中
echo ".env" >> .gitignore
```

**安全提醒**：
- ❌ 禁止将真实 token/密钥写入模板
- ❌ 禁止提交 .env 到仓库
- ✅ 确保 .gitignore 包含 .env

---

### 2. example-config.json

**用途**：项目通用配置模板

**包含字段**：
| 字段 | 说明 |
|------|------|
| repository | 仓库信息（类型/URL/分支） |
| paths | 各目录路径配置 |
| openclaw | OpenClaw 配置 |
| github | GitHub 相关配置 |
| scripts | 常用脚本入口 |
| checks | 预提交检查配置 |
| metadata | 模板元信息 |

**使用方式**：
```bash
# 复制为实际配置
cp config/example-config.json config/project.json

# 编辑填入实际值
nano config/project.json
```

---

### 3. task-template.json

**用途**：任务配置模板，用于跟踪任务状态

**包含字段**：
| 字段 | 说明 |
|------|------|
| task | 任务基本信息 (id/name/description/status) |
| assignee | 执行者信息 (name/role) |
| timeline | 时间线 (创建/截止/开始/完成时间) |
| scope | 操作范围 (允许目录/允许动作/禁止动作) |
| checkpoints | 检查点列表 (Plan/执行/Review) |
| handoff | 交接信息 |

**使用方式**：
```bash
# 为新任务创建配置
cp config/task-template.json config/task-TASK-XXX.json

# 编辑填入任务信息
nano config/task-TASK-XXX.json
```

---

## 三、安全原则

| 原则 | 说明 |
|------|------|
| 只做模板 | 本仓库只提供模板，不含真实值 |
| 禁止敏感值 | 不写入 token、私钥、密码、.env 真值 |
| 分离配置 | 开发/测试/生产配置分离 |
| .gitignore | 确保敏感文件被忽略 |

---

## 四、目录结构

```
config/
├── .env.example          # 环境变量模板
├── example-config.json   # 项目配置模板
├── task-template.json    # 任务配置模板
└── README.md             # 本文档
```

---

## 五、后续扩展

可考虑的扩展：
- 多环境配置（dev/staging/prod）
- 密钥轮换机制
- 配置验证脚本
- 环境差异对比工具

---

*本文档为配置模板体系 v1.0*