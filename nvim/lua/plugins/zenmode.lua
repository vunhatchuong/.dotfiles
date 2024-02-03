return {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            width = 0.80,
        },
        plugin = {
            gitsigns = { enabled = true },
            tmux = { enabled = true },
        },
    },
    keys = {
        { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Toggle ZenMode" },
    },
}
