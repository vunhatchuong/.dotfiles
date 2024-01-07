return {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        symbol = "│",
        options = { try_as_border = true, indent_at_cursor = false },
        draw = { animation = function() return 0 end }
    },
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "help",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "harpoon",
                "TelescopePrompt",
                "oil",
            },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
        })
    end,
}

