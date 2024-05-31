return {
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
                "FTerm"
            },
            buftypes = { "terminal", "nofile" },
        },
    },
    main = "ibl",
}
