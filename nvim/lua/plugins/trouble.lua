return {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
        {
            "<leader>dd",
            "<cmd>TroubleToggle document_diagnostics<cr>",
            desc = "Document Diagnostics (Trouble)",
        },
        {
            "<leader>wd",
            "<cmd>TroubleToggle workspace_diagnostics<cr>",
            desc = "Workspace Diagnostics (Trouble)",
        },
    },
}
