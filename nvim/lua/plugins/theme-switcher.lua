return {
    "vague2k/huez.nvim",
    lazy = false,
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    cmd = "Huez",
    opts = {
        fallback = "catppuccin",
        picker = "telescope",
    },
    config = function(_, opts)
        require("huez").setup(opts)
        local colorscheme = require("huez.api").get_colorscheme()
        vim.cmd("colorscheme " .. colorscheme)
    end,
}
