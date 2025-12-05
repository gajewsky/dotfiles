## Yet another dotfiles manifestation

Managed with [chezmoi](https://www.chezmoi.io/).

### Prerequisites

* [chezmoi](https://www.chezmoi.io/install/)
* [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish)

### Installation

```
chezmoi init --apply gajewsky/dotfiles
```

#### Fish shell plugins

After applying chezmoi, install Oh My Fish and its plugins:

```
curl -L https://get.oh-my.fish | fish
omf install
```

This will install plugins from `~/.config/omf/bundle`.

### Usage

```
# See what changes chezmoi would make
chezmoi diff

# Apply changes
chezmoi apply

# Pull latest and apply
chezmoi update
```
