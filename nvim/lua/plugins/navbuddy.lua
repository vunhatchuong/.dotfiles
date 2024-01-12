return {
    event = { "BufReadPre", "BufNewFile" },
    "SmiteshP/nvim-navbuddy",
    dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        {
            "<leader>o",
            ":Navbuddy<cr>",
            silent = true,
            desc = "Navbuddy",
            mode = "n",
        },
    },
    opts = {
        window = {
            border = "rounded",
        },
        icons = require("core.icons").kind,
        lsp = { auto_attach = true },
    },
}
