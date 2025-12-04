-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Using vim.lsp.config (Neovim 0.11+)
-- see :help lspconfig-nvim-0.11

local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Add additional capabilities supported by nvim-cmp
local capabilities = cmp_nvim_lsp.default_capabilities()

-- LSP keymaps via LspAttach autocommand
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    -- LSP mappings
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
    map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
    map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, 'Add workspace folder')
    map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
    map('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'List workspace folders')
    map('n', '<space>D', vim.lsp.buf.type_definition, 'Type definition')
    map('n', '<space>rn', vim.lsp.buf.rename, 'Rename')
    map('n', '<space>ca', vim.lsp.buf.code_action, 'Code action')
    map('n', 'gr', vim.lsp.buf.references, 'References')
    map('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, 'Format')

    -- Diagnostic mappings
    map('n', '<space>e', vim.diagnostic.open_float, 'Show diagnostics')
    map('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
    map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')
    map('n', '<space>q', vim.diagnostic.setloclist, 'Diagnostics to loclist')
  end,
})

-- Configure LSP servers using vim.lsp.config
vim.lsp.config('*', {
  capabilities = capabilities,
})

vim.lsp.config('solargraph', {
  capabilities = capabilities,
})

vim.lsp.config('sorbet', {
  cmd = { 'bundle', 'exec', 'srb', 'tc', '--lsp' },
  filetypes = { 'ruby' },
  capabilities = capabilities,
})

-- Setup mason-lspconfig to auto-install LSP servers
require('mason-lspconfig').setup {
  ensure_installed = { 'solargraph' },
  automatic_installation = true,
}

-- Enable configured servers
vim.lsp.enable({ 'solargraph', 'sorbet' })
