return {
    "echasnovski/mini.notify",
    event = { "VeryLazy" },
    config = function()
        local format_config = function(notif)
            return notif.msg
        end
        local win_config = function()
            local has_statusline = vim.o.laststatus > 0
            local bottom_space = vim.o.cmdheight + (has_statusline and 1 or 0)
            return {
                anchor = "SE",
                col = vim.o.columns,
                row = vim.o.lines - bottom_space,
                border = "none",
            }
        end
        require("mini.notify").setup({
            content = {
                format = format_config,
            },
            window = {
                config = win_config,
                winblend = 100,
            },
        })
    end,
}
