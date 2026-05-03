#!/usr/bin/env python3
"""Generate a lightweight repository health report for env5 recent stage."""

from __future__ import annotations

import subprocess
import sys
from dataclasses import dataclass
from datetime import date
from pathlib import Path


@dataclass
class CommandResult:
    command: list[str]
    returncode: int
    stdout: str
    stderr: str


SCRIPT_DIR = Path(__file__).resolve().parent
REPO_ROOT = SCRIPT_DIR.parent
COLLAB_ROOT = REPO_ROOT / "docs" / "collab" / "chatgpt-lingxi"
REPORTS_DIR = COLLAB_ROOT / "reports"
TODAY = date.today().isoformat()
REPORT_PATH = REPORTS_DIR / f"{TODAY}-repo-doctor-report.md"


def run_command(args: list[str]) -> CommandResult:
    """Run a command in the repository root and capture text output."""
    completed = subprocess.run(
        args,
        cwd=REPO_ROOT,
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
        check=False,
    )
    return CommandResult(
        command=args,
        returncode=completed.returncode,
        stdout=completed.stdout.strip(),
        stderr=completed.stderr.strip(),
    )


def format_command_result(result: CommandResult) -> str:
    """Render command output for the markdown report."""
    output = result.stdout or result.stderr or "(no output)"
    return (
        f"### `$ {' '.join(result.command)}`\n"
        f"- return code: {result.returncode}\n\n"
        "```text\n"
        f"{output}\n"
        "```\n"
    )


def format_directory_checks(targets: list[tuple[str, Path]]) -> str:
    lines = [
        "| Directory | Exists |",
        "| --- | --- |",
    ]
    for label, path in targets:
        exists = "true" if path.exists() else "false"
        lines.append(f"| `{label}` | `{exists}` |")
    return "\n".join(lines)


def build_report() -> str:
    repo_path = str(REPO_ROOT)
    branch = run_command(["git", "branch", "--show-current"])
    status = run_command(["git", "status", "--short", "--untracked-files=all"])
    top_level = run_command(["git", "rev-parse", "--show-toplevel"])

    directory_checks = [
        ("docs/collab/chatgpt-lingxi/", COLLAB_ROOT),
        ("docs/collab/chatgpt-lingxi/tasks/", COLLAB_ROOT / "tasks"),
        ("docs/collab/chatgpt-lingxi/reports/", REPORTS_DIR),
        ("scripts/", REPO_ROOT / "scripts"),
    ]

    lines = [
        "# Env5 Repo Doctor Report",
        "",
        f"- date: {TODAY}",
        f"- repo path: `{repo_path}`",
        "",
        "## Summary",
        "This report checks the local repository path, current git branch, "
        "git status, and the required collaboration directories for env5 "
        "recent stage.",
        "",
        "## Git Checks",
        format_command_result(top_level),
        format_command_result(branch),
        format_command_result(status),
        "## Directory Checks",
        format_directory_checks(directory_checks),
        "",
        "## Output",
        f"- report path: `{REPORT_PATH.relative_to(REPO_ROOT).as_posix()}`",
    ]
    return "\n".join(lines).rstrip() + "\n"


def main() -> int:
    REPORTS_DIR.mkdir(parents=True, exist_ok=True)
    report_content = build_report()
    REPORT_PATH.write_text(report_content, encoding="utf-8")

    print(f"Env5 repo doctor completed.")
    print(f"Report written to: {REPORT_PATH}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
