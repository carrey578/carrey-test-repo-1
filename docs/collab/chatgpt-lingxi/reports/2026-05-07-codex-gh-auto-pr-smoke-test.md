# Codex GitHub CLI Auto PR Smoke Test

## Context

This document records a minimal validation of the local Codex -> GitHub CLI -> draft PR workflow.

## Scope

- Source branch: `work/lingxi-codex-bootstrap`
- Smoke-test branch: `codex/gh-auto-pr-smoke-test-20260507`
- Repository: `carrey578/carrey-test-repo-1`
- Change type: documentation-only
- Main branch policy: do not push to `main`

## Validation Goals

- Confirm local `gh auth` can authenticate as `carrey578`.
- Confirm Codex can create a local branch from the current work branch.
- Confirm Codex can commit and push a minimal documentation-only change.
- Confirm Codex can create a draft pull request with `gh pr create`.

## Notes

- This validates the GitHub CLI path, not the GitHub plugin connector path.
- The target PR base should be `work/lingxi-codex-bootstrap`.
- This smoke test does not change application behavior.
