return {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    config = function()
        require("nvim-highlight-colors").setup()
    end,
}
