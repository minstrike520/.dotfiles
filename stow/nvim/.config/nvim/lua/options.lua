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

-- Clipboard Traversal
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
    },
    paste = {
      ['+'] = '/usr/bin/win32yank',
    },
    cache_enabled = 0,
  }
elseif vim.env.SSH_CONNECTION then
  if vim.env.REMOTE_IS_TERMUX then
  else
    vim.g.clipboard = {
      name = "osc52",
      copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
      },
      paste = {
        ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
      },
    }
  end
end
local client_ip = vim.fn.split(vim.fn.getenv("SSH_CONNECTION"), " ")[1]
if client_ip then
    local client_hostname = vim.fn.system("host " .. client_ip):match("pointer (.-)%.?$")
    print("連線來自: " .. (client_hostname or client_ip))
end


--]]

-- let NERDTreeShowHidden=1

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
