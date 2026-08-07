require "nvchad.options"

vim.filetype.add({
  extension = {
    pde = "processing",
  }
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})
--]]

-- let NERDTreeShowHidden=1

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
