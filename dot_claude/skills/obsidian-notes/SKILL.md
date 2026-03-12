---
name: obsidian-notes
description: Use when saving notes to Obsidian vault, creating documentation, capturing knowledge, or logging any information. Uses the official Obsidian CLI (`obsidian` command) to create notes, apply templates, manage properties, and interact with the vault.
---

# Obsidian Notes

## Overview

Save notes to a PARA-structured Obsidian vault using the **official Obsidian CLI** (`obsidian` command). The CLI communicates with the running Obsidian instance, enabling note creation with templates, property management, search, and more — all from the terminal.

## Prerequisites

- Obsidian desktop app must be running (the CLI connects to it)
- CLI is registered at `/usr/bin/obsidian`
- Vault name: `me`, path: `~/Obsidian/me/`

## Vault & PARA Structure

```
~/Obsidian/me/
├── 0.Inbox/     # Quick captures, unsorted notes, daily captures (default for new files)
├── 1.Projects/  # Active projects with defined outcomes
├── 2.Areas/     # Ongoing areas of life: personal, health, relationships, finances, hobbies, career
├── 3.Resources/ # Reference material: books, articles, recipes, technical notes, prompts
├── 4.Archives/  # Completed/inactive items
└── 5.Meta/      # System files: templates, attachments
```

## Location Decision Tree

1. **Quick capture or unsorted?** → `0.Inbox/`
2. **Active project with a defined end goal?** → `1.Projects/[project-name]/`
3. **Ongoing area of life?** → `2.Areas/` — personal life, health, relationships, hobbies, career, finances, travel, home
4. **Reference material or knowledge?** → `3.Resources/` — books, articles, recipes, technical notes, AI prompts
5. **Completed or inactive?** → `4.Archives/`

## Template Discovery

Templates live in `5.Meta/Templates/` within the vault.

**To find the right template:**
1. List available templates: `obsidian templates`
2. Read a template: `obsidian template:read name="<template-name>" resolve`
3. Match note type to template name
4. If no match, create with minimal frontmatter

**Available templates:**

### Book Template (`Book Template`)
Use for book summaries and reading notes. Frontmatter:
```yaml
---
type: book
author:
title:
category:
status:        # "reading" | "completed" | "abandoned"
rating:        # 1-5
created: {{date}}
completed:
---
```
Sections: Summary, Key Concepts, Top Insights, Practical Applications, Highlights & Notes, Related Resources, Review

### Gravel Ultra Race Template (`Gravel Ultra Race Template`)
Use for race preparation and planning. Frontmatter:
```yaml
---
race_name:
date:
distance_km:
elevation_m:
location:
estimated_time_hours:
status:         # "planned" | "registered" | "completed"
surface_type:
website:
---
```
Sections: Race Overview, Pre-Race Preparation, Logistics, Nutrition Strategy, Performance Strategy, Pre-Race TODOs, post-race procedures

## Creating Notes

Use the `obsidian create` command. The CLI handles file creation, template application, and variable resolution (`{{date}}`, `{{time}}`, `{{title}}`).

### Workflow

1. **Determine location** — Use the decision tree to pick the right PARA folder/subfolder
2. **Find template** — Run `obsidian templates` and match type
3. **Create note with template:**
   ```bash
   obsidian create path="<PARA-folder>/<filename>.md" template="<template-name>"
   ```
4. **Or create note with inline content (no template):**
   ```bash
   obsidian create path="<PARA-folder>/<filename>.md" content="---\ntype: note\ncreated: {{date}}\n---\n\n<content>"
   ```

### Setting properties after creation

Use `property:set` to fill in frontmatter fields:
```bash
obsidian property:set path="<path>" name="author" value="James Clear"
obsidian property:set path="<path>" name="status" value="reading"
```

### Appending content to existing notes

```bash
obsidian append path="<path>" content="<text to append>"
```

## File Naming

- **Date-based** (diary, daily captures, inbox): `YYYY-MM-DD.md`
- **Book/article**: `Title - Author.md`
- **People**: `First Last.md`
- **General notes**: `Descriptive Title.md` (sentence case)
- **Attachments**: stored in `5.Meta/Assets/`

## Minimal Frontmatter

When no template matches, use inline content:

```bash
obsidian create path="<location>/<name>.md" content="---\ntype: note\ncreated: {{date}}\n---"
```

## Examples

### Quick capture
User: "Save this quick thought about refactoring"

```bash
obsidian create path="0.Inbox/Refactoring thought.md" content="---\ntype: note\ncreated: {{date}}\n---\n\nQuick thought about refactoring..."
```

### Book note
User: "Create a note for the book 'Atomic Habits'"

```bash
obsidian create path="3.Resources/Books/Atomic Habits - James Clear.md" template="Book Template"
obsidian property:set path="3.Resources/Books/Atomic Habits - James Clear.md" name="author" value="James Clear"
obsidian property:set path="3.Resources/Books/Atomic Habits - James Clear.md" name="title" value="Atomic Habits"
```

### Race planning
User: "Create a race note for Transcarpathia 2026"

1. Browse existing structure: `obsidian files folder="2.Areas/Bikes"`
2. Create with template:
```bash
obsidian create path="2.Areas/Bikes/Races/Transcarpathia 2026.md" template="Gravel Ultra Race Template"
obsidian property:set path="2.Areas/Bikes/Races/Transcarpathia 2026.md" name="race_name" value="Transcarpathia 2026"
```

### Diary entry
User: "Log today's diary entry"

Use the daily note command if configured, or create manually:
```bash
obsidian create path="2.Areas/Mind/Diary/2026/2026-03-12.md" content="---\njournal: Diary\njournal-date: 2026-03-12\n---\n\n"
```

Or append to an existing daily note:
```bash
obsidian daily:append content="<diary content>"
```

### Reference material
User: "Save this article about Kubernetes networking"

1. Browse existing structure: `obsidian files folder="3.Resources"`
2. Create:
```bash
obsidian create path="3.Resources/IT/Kubernetes networking.md" content="---\ntype: note\ncreated: {{date}}\n---\n\n<article content>"
```

### Appending to an existing note
User: "Add this to my project notes"

```bash
obsidian append path="1.Projects/my-project/notes.md" content="\n## New Section\n\nContent here..."
```

## CLI Quick Reference

### Note Operations
| Command | Description |
|---|---|
| `obsidian create path=<path> content=<text>` | Create a note with content |
| `obsidian create path=<path> template=<name>` | Create a note from template |
| `obsidian read path=<path>` | Read note contents |
| `obsidian append path=<path> content=<text>` | Append to a note |
| `obsidian prepend path=<path> content=<text>` | Prepend after frontmatter |
| `obsidian move path=<path> to=<new-path>` | Move/rename a note |
| `obsidian delete path=<path>` | Delete a note |

### Properties (Frontmatter)
| Command | Description |
|---|---|
| `obsidian property:set path=<path> name=<key> value=<val>` | Set a property |
| `obsidian property:read path=<path> name=<key>` | Read a property |
| `obsidian property:remove path=<path> name=<key>` | Remove a property |
| `obsidian properties path=<path>` | List all properties |

### Templates
| Command | Description |
|---|---|
| `obsidian templates` | List available templates |
| `obsidian template:read name=<name>` | Read template content |
| `obsidian template:read name=<name> resolve` | Read with resolved variables |

### Search & Browse
| Command | Description |
|---|---|
| `obsidian search query=<text>` | Search vault |
| `obsidian search:context query=<text>` | Search with line context |
| `obsidian files folder=<path>` | List files in folder |
| `obsidian folders` | List all folders |
| `obsidian tags counts` | List tags with counts |

### Daily Notes
| Command | Description |
|---|---|
| `obsidian daily` | Open today's daily note |
| `obsidian daily:read` | Read daily note contents |
| `obsidian daily:append content=<text>` | Append to daily note |
| `obsidian daily:prepend content=<text>` | Prepend to daily note |

### Vault Info
| Command | Description |
|---|---|
| `obsidian vault` | Show vault info |
| `obsidian file path=<path>` | Show file info |
| `obsidian backlinks path=<path>` | List backlinks |
| `obsidian links path=<path>` | List outgoing links |

## Notes

- Always include YAML frontmatter with at least `type` and `created` (except diary entries which use `journal` and `journal-date`)
- Use wikilinks `[[]]` for internal links
- The CLI creates intermediate directories automatically
- Use `overwrite` flag to replace existing notes: `obsidian create path=<path> content=<text> overwrite`
- For multiline content use `\n` for newline and `\t` for tab
- The vault uses Polish and English content interchangeably
- Obsidian must be running for CLI commands to work
