# Integrate Opencode Config with Chezmoi Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Manage the Opencode configuration via chezmoi so new machines get the same plugins, DCP settings, and install hooks without manual setup.

**Architecture:** Mirror the essential Opencode config files into the chezmoi source under `dot_config/opencode/`, exclude vendor/cache directories, and rely on the existing `run_onchange_after_install_opencode.sh.tmpl` hook to bootstrap Opencode on apply. Validate with `chezmoi diff`/`apply` and a quick `opencode --version` sanity check.

**Tech Stack:** chezmoi templates and plain files, shell, Opencode config JSON, bun.lock/package.json for plugin resolution.

### Task 1: Template Opencode config files

**Files:**
- Modify: `dot_config/opencode/opencode.json`
- Modify: `dot_config/opencode/dcp.jsonc`
- Modify: `dot_config/opencode/package.json`
- Modify: `dot_config/opencode/bun.lock`

**Step 1: Capture live config into chezmoi**

Run:
```bash
chezmoi add --autotemplate \
  ~/.config/opencode/opencode.json \
  ~/.config/opencode/dcp.jsonc \
  ~/.config/opencode/package.json \
  ~/.config/opencode/bun.lock
```
Expected: Files appear under `dot_config/opencode/` with same content as current setup.

**Step 2: Verify plugin and DCP settings**

Check `dot_config/opencode/opencode.json` contains plugins `@franlol/opencode-md-table-formatter@0.0.3` and `@tarquinen/opencode-dcp@latest`, schema URL, and theme `gruvbox`. Check `dot_config/opencode/dcp.jsonc` keeps `pruneNotification: "detailed"`, `turnProtection: false`, and `tools: ["discard","extract"].`

**Step 3: Ensure dependency lock is tracked**

Confirm `dot_config/opencode/package.json` still lists `@opencode-ai/plugin` and `dot_config/opencode/bun.lock` is present so plugin resolution is reproducible.

### Task 2: Ignore vendor/cache artifacts

**Files:**
- Modify: `.chezmoiignore`

**Step 1: Add ignore patterns**

Append:
```text
dot_config/opencode/node_modules
.dot_config/opencode/logs/
```
Expected: `chezmoi diff` no longer tries to track `node_modules` or log output under Opencode config.

**Step 2: Confirm ignore works**

Run:
```bash
chezmoi status | grep opencode || true
```
Expected: Only the intended config files show as tracked; `node_modules`/logs do not appear.

### Task 3: Validate apply flow

**Files:**
- (no code changes)

**Step 1: Review changes**

Run:
```bash
chezmoi diff
```
Expected: Only `dot_config/opencode/*` and `.chezmoiignore` differences.

**Step 2: Dry-run apply**

Run:
```bash
chezmoi apply --dry-run
```
Expected: Shows writes to `~/.config/opencode` files without errors.

**Step 3: Sanity-check Opencode availability**

Run:
```bash
chezmoi apply
opencode --version
```
Expected: Apply succeeds; Opencode reports its version (leveraging the existing install hook if needed).

### Task 4: Commit

**Files:**
- `dot_config/opencode/opencode.json`
- `dot_config/opencode/dcp.jsonc`
- `dot_config/opencode/package.json`
- `dot_config/opencode/bun.lock`
- `.chezmoiignore`

**Step 1: Stage and commit**

Run:
```bash
git add dot_config/opencode/opencode.json dot_config/opencode/dcp.jsonc \
  dot_config/opencode/package.json dot_config/opencode/bun.lock .chezmoiignore
git commit -m "chore: manage opencode config via chezmoi"
```
Expected: Commit records the managed Opencode config and ignore rules.
