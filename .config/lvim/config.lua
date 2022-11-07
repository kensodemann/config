-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "spaceduck"
lvim.nospell = true
vim.opt.relativenumber = true
vim.g.spelunker_disable_uri_checking = 1
vim.g.spelunker_disable_email_checking = 1
vim.g.spelunker_disable_account_name_checking = 1
vim.g.spelunker_disable_acronym_checking = 1
vim.g.spelunker_disable_backquoted_checking = 1
vim.g.spelunker_disable_auto_group = 1
vim.g.spelunker_spell_bad_group = 'SpelunkerSpellBad'
vim.g.spelunker_complex_or_compound_word_group = 'SpelunkerComplexOrCompoundWord'

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    filetypes = { "html", "css", "scss", "typescript", "typescriptreact" },
  },
}

-- generic LSP settings
-- None at this point...

-- Additional Plugins
lvim.plugins = {
  { "pineapplegiant/spaceduck" },
  { "kamykn/spelunker.vim" },
  { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }
}

-- Autocommands
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.vim", "*.js", "*.jsx", "*.json", "*.md", "*.ts", "*.tsx" },
  command = "call spelunker#check()",
})
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.vim", "*.js", "*.jsx", "*.json", "*.md", "*.ts", "*.tsx" },
  command = "call spelunker#check()",
})
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = { "*.vim", "*.js", "*.jsx", "*.json", "*.md", "*.ts", "*.tsx" },
  command = "call spelunker#check_displayed_words()",
})
