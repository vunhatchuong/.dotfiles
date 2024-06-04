return {
    "briangwaltney/paren-hint.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
}
