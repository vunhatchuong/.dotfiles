return {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
        focus = true,
        keys = {
            ["<cr>"] = "jump_close",
            ["<space>"] = "jump",
        },
    },
    keys = {
        {
            "<leader>dd",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>wd",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
    },
}
