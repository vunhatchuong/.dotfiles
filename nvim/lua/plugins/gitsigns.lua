return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
        require("gitsigns").setup()
    end,
}
