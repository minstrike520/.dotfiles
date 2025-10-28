require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {desc = "LSP code action"})

map('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', {desc = "LSP floating diagnostic"})
map('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', {desc = "LSP next diagnostic"})
map('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {desc = "LSP previous diagnostic"})

map('n', '<leader>gn', '<cmd>Gitsigns nav_hunk next<CR>', {desc = "Git next hunk"})
map('n', '<leader>gp', '<cmd>Gitsigns nav_hunk next<CR>', {desc = "Git previous hunk"})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
