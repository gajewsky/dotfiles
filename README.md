## Yet another dotfiles manifestation

Managed with [chezmoi](https://www.chezmoi.io/).

### Prerequisites

* [chezmoi](https://www.chezmoi.io/install/)

### Installation

```
chezmoi init --apply gajewsky/dotfiles
```

### Configuration

After installation, create `~/.config/chezmoi/chezmoi.toml` with your public/personal data. If you use a separate private work repo, keep work-only values there.

```toml
[data]
  name = "Your Name"
  email_personal = "your.personal@email.com"
```

Then re-apply:

```
chezmoi apply
```

### Usage

```
# See what changes chezmoi would make
chezmoi diff

# Apply changes
chezmoi apply

# Pull latest and apply
chezmoi update
```
