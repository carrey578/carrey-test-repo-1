# Env5.1 Baseline Change Summary

**Date**: 2026-05-07  
**Branch**: `work/lingxi-codex-bootstrap`  
**Change type**: documentation-only baseline upgrade

## Summary

This change adds `开发环境5.1版（多Agent初阶）.md` as the current Env5.1 multi-agent initial-stage baseline.

The Env5.1 baseline keeps `开发环境5.0版（Hermes替代OpenClaw）.md` as the historical Hermes-over-OpenClaw baseline, and adds the post-stage-8 facts verified during the recent multi-agent setup work.

## Main Changes From Env5.0

- Defines Env5.1 as the multi-agent initial-stage baseline.
- Records Hermes as the cloud control agent.
- Records Codex as the local code execution agent.
- Records GitHub as the source of truth and PR automation hub.
- Records that local `gh` CLI Draft PR creation has been verified.
- Records that the Codex GitHub plugin/connector Draft PR creation has been verified.
- Records Claude as a lightweight web review role, with Claude Code terminal integration still deferred.
- Records Tencent Cloud COS as an archive layer, not as a local repository workspace.
- Captures the main operational boundaries: no direct `main` push, no token/key/password in repo, no PR merge/close without explicit human authorization.

## Evidence

- Stage summary: `docs/collab/chatgpt-lingxi/reports/2026-05-07-env5-recent-stage-summary.md`
- Initial closure addendum: `docs/collab/chatgpt-lingxi/reports/2026-05-07-env5-initial-stage-closure-and-baseline-addendum.md`
- Local `gh` auto PR smoke test: PR #3
- GitHub plugin PR smoke test: PR #4
- Current FastAPI test result: `3 passed`

## Files Added Or Updated

- Added repo baseline copy: `开发环境5.1版（多Agent初阶）.md`
- Added change-summary: `docs/collab/chatgpt-lingxi/reports/2026-05-07-env51-baseline-change-summary.md`
- Synced external reference document: `D:\dev\Dev-Document\开发环境5.1版（多Agent初阶）.md`

## Scope Notes

- No business code was changed.
- `tools/` was not changed.
- `scripts/` was not changed.
- No token, key, password, or secret was written.
- `main` was not pushed.
- PR #3 and PR #4 were not merged, closed, or otherwise modified.
