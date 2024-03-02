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
                "Trouble",
                "harpoon",
                "TelescopePrompt",
                "notify",
                "undotree",
                "grapple",
            },
        },
    },
    main = "ibl",
}
