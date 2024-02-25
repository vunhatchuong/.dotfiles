return {
    "NvChad/nvim-colorizer.lua",
    lazy = false,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
        require("colorizer").setup()
    end,
}
