return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = { enabled = false },
            exclude = {
                filetypes = {
                    "netrw",
                    "help",
                    "lspinfo",
                    "lazy",
                    "mason",
                    "oil",
                    "trouble",
                    "harpoon",
                    "TelescopePrompt",
                    "notify",
                    "undotree",
                    "grapple",
                    "FTerm",
                },
                buftypes = { "terminal", "nofile" },
            },
        },
        main = "ibl",
    },
    {
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
                    "netrw",
                    "help",
                    "lspinfo",
                    "lazy",
                    "mason",
                    "oil",
                    "trouble",
                    "harpoon",
                    "TelescopePrompt",
                    "notify",
                    "undotree",
                    "grapple",
                    "FTerm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
}
