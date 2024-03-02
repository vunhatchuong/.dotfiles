return {
    "briangwaltney/paren-hint.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("paren-hint")
    end,
}
