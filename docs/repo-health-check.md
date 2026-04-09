# Repo Health Check Guide

## 1. 文档目的
把当前分散的本地检查、服务器检查、预检、验证、状态报告入口整理成统一说明。

## 2. 本地入口
- tools/check-dev-env-local.ps1
- tools/preflight-check.ps1
- tools/verify-dev-entry.ps1
- tools/verify-main-feature.ps1
- tools/generate-status-report.ps1

## 3. 服务器入口
- scripts/check-dev-env-server.sh
- scripts/preflight-check.sh
- scripts/verify-dev-entry.sh
- scripts/verify-main-feature.sh
- scripts/generate-status-report.sh

## 4. 推荐执行顺序
1. 先跑 check-dev-env
2. 再跑 preflight-check
3. 需要时跑 dev-entry / dev-entry-v2
4. 改动完成后跑 verify
5. 最后生成 status report

## 5. 本地已验证结果
- tools/check-dev-env-local.ps1 已在 Windows PowerShell 实测通过

## 6. 当前建议
本轮先复用已有脚本，不先重写逻辑；若后续高频使用，再补统一入口脚本。