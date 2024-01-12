return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        indent = {
            char = "│",
            tab_char = "│",
        },
        scope = { enabled = false },
        exclude = {
            filetypes = {
                "help",
                "Trouble",
                "trouble",
                "lazy",
                "mason",
                "lazyterm",
            },
        },
    },
    main = "ibl",
}
