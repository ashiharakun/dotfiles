vim.o.number = true
vim.o.termguicolors = true
vim.o.scrolloff = 4
vim.o.clipboard = 'unnamedplus'
vim.wo.cursorline = true

vim.o.autoindent = true
vim.o.smartindent = true

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'
vim.o.hlsearch = true

vim.o.helplang = 'ja,en'

-- 組み込みtreesitterハイライト（パーサーが存在するファイルタイプのみ有効）
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
