---
name: obsidian-notes
description: Use when saving notes to Obsidian vault, creating documentation, capturing knowledge, or logging any information. This skill determines the correct PARA location and applies the appropriate template from the vault.
---

# Obsidian Notes

## Overview

Save notes to a PARA-structured Obsidian vault by selecting the appropriate location and template. Templates are read dynamically from the vault itself.

## Vault Location

The vault is at `~/Obsidian/me/` (identified by the `.obsidian/` subdirectory).

## PARA Structure

```
~/Obsidian/me/
├── 0.Inbox/     # Quick captures, unsorted notes, daily captures (default for new files)
├── 1.Projects/  # Active projects with defined outcomes
├── 2.Areas/     # Ongoing areas of life: personal, health, relationships, finances, hobbies, career
├── 3.Resources/ # Reference material: books, articles, recipes, technical notes, prompts
├── 4.Archives/  # Completed/inactive items
└── 5.Meta/     # System files: templates, attachments
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
1. List all `.md` files in `5.Meta/Templates/`
2. Match note type to template filename/frontmatter
3. If no match, use minimal frontmatter

**Available templates:**

### Book Template (`Book Template.md`)
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

### Gravel Ultra Race Template (`Gravel Ultra Race Template.md`)
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

1. **Determine location** — Use the decision tree to pick the right PARA folder/subfolder
2. **Find template** — Read from `5.Meta/Templates/` and match type
3. **Apply template** — Replace placeholders:
   - `{{date}}` → Current date (YYYY-MM-DD)
   - `{{title}}` → Note title
   - `{{time}}` → Current time (HH:MM)
4. **Write file** — Save to determined location

## File Naming

- **Date-based** (diary, daily captures, inbox): `YYYY-MM-DD.md`
- **Book/article**: `Title - Author.md`
- **People**: `First Last.md`
- **General notes**: `Descriptive Title.md` (sentence case)
- **Attachments**: stored in `5.Meta/Assets/`

## Minimal Frontmatter

When no template matches, use:

```yaml
---
type: note
created: {{date}}
---
```

## Examples

### Quick capture
User: "Save this quick thought about refactoring"

Location: `0.Inbox/Refactoring thought.md`
Template: Minimal frontmatter

### Book note
User: "Create a note for the book 'Atomic Habits'"

1. Read `5.Meta/Templates/Book Template.md`
2. Location: `3.Resources/Books/Atomic Habits - James Clear.md`
3. Apply Book Template with frontmatter filled in

### Race planning
User: "Create a race note for Transcarpathia 2026"

1. Read `5.Meta/Templates/Gravel Ultra Race Template.md`
2. Location: `2.Areas/Bikes/Races/Transcarpathia 2026.md` (browse existing structure to find the right folder)
3. Apply Gravel Ultra Race Template

### Diary entry
User: "Log today's diary entry"

Location: `2.Areas/Mind/Diary/2026/2026-02-16.md` (browse existing structure to find the right folder)
Frontmatter:
```yaml
---
journal: Diary
journal-date: 2026-02-16
---
```

### Reference material
User: "Save this article about Kubernetes networking"

Location: `3.Resources/IT/Kubernetes networking.md` (browse existing structure to find the right folder)
Template: Minimal frontmatter

## Notes

- Always include YAML frontmatter with at least `type` and `created` (except diary entries which use `journal` and `journal-date`)
- Use wikilinks `[[]]` for internal links
- Create subfolders as needed within PARA directories
- The vault uses Polish and English content interchangeably
