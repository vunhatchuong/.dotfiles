return {
    "vague2k/huez.nvim",
    lazy = false,
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    cmd = "Huez",
    opts = {
        fallback = "catppuccin",
        omit = {
            "default",
            "desert",
            "evening",
            "industry",
            "koehler",
            "morning",
            "murphy",
            "pablo",
            "peachpuff",
            "ron",
            "shine",
            "slate",
            "torte",
            "zellner",
            "blue",
            "darkblue",
            "delek",
            "quiet",
            "elflord",
            "habamax",
            "lunaperche",
            -- External themes
            "catppuccin-frappe",
            "catppuccin-macchiato",
            -- Zenbones
            "zenburned",
            "randombones",
            "seoulbones",
            "vimbones",
        },
        picker = "telescope",
    },
    config = function(_, opts)
        require("huez").setup(opts)
        local colorscheme = require("huez.api").get_colorscheme()
        vim.cmd("colorscheme " .. colorscheme)
    end,
}
