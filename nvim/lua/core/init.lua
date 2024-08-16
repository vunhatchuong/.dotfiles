require("core.autocmds")
require("core.keymaps")
require("core.options")
require("core.lazy")

-- Modified default theme
-- https://github.com/glepnir/nvim/blob/main/lua/core/init.lua
vim.cmd([[
hi link @property @variable
hi Type guifg=#eed49f ctermfg=11
hi link @type.builtin Type
hi link @type Type
]])
