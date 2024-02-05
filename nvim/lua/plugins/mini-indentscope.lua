return {
    "echasnovski/mini.indentscope",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
        symbol = "│",
        options = {
            indent_at_cursor = true,
            try_as_border = true,
        },
        draw = {
            animation = function()
                return 0
            end,
        },
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
