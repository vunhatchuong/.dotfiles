return {
    "briangwaltney/paren-hint.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        anywhere_on_line = true,
        show_same_line_opening = false,
    },
    config = function(_, opts)
        require("paren-hint")
    end,
}
