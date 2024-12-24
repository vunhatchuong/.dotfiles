vim.api.nvim_set_hl(0, "Comment", { fg = "NvimDarkGrey4", ctermfg = 8 })
vim.api.nvim_set_hl(0, "LineNr", { fg = "NvimDarkGrey4", ctermfg = 8 })
vim.api.nvim_set_hl(0, "NonText", { fg = "NvimDarkGrey4", ctermfg = 8 })

vim.api.nvim_set_hl(0, "@property", { link = "@variable" })
vim.api.nvim_set_hl(0, "Type", { fg = "#eed49f", ctermfg = 11 })
vim.api.nvim_set_hl(0, "@type.builtin", { link = "Type" })
vim.api.nvim_set_hl(0, "@type", { link = "Type" })
