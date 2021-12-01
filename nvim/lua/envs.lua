-----------------------------------------------------------
-- Env configuration file: envs of neovim
-- and plugins.
-----------------------------------------------------------

vim.fn.setenv("FZF_DEFAULT_COMMAND", 'rg --files --follow --no-ignore-vcs --hidden --glob "!{node_modules/*,.git/*,sorbet/*}"')
