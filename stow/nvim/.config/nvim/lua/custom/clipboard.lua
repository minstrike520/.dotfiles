-- Clipboard Traversal
local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

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
        ["+"] = paste,
        ["*"] = paste,
      },
    }
  end
end
local ssh_conn = vim.fn.getenv("SSH_CONNECTION")
if ssh_conn ~= vim.NIL and ssh_conn ~= "" then
    local client_ip = vim.fn.split(ssh_conn, " ")[1]
    if client_ip then
        print("連線來自: " .. client_ip)
    end
end
