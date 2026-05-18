# GitHub Plugin PR Smoke Test

## Context

This document records a minimal validation of the Codex GitHub plugin/connector PR workflow.

## Scope

- Source branch: `work/lingxi-codex-bootstrap`
- Smoke-test branch: `codex/github-plugin-pr-smoke-test-20260507`
- Repository: `carrey578/carrey-test-repo-1`
- Change type: documentation-only
- Main branch policy: do not push to `main`

## Validation Goals

- Confirm the GitHub plugin can read PR changed files.
- Confirm the GitHub plugin can add a PR conversation comment.
- Confirm the GitHub plugin can create a draft pull request for the current repository.

## Notes

- This validates the GitHub plugin connector path, not the local GitHub CLI path.
- The target PR base should be `work/lingxi-codex-bootstrap`.
- This smoke test does not change application behavior.
