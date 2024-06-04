return {
    {
        "JellyApple102/flote.nvim",
        cmd = { "Flote" },
        keys = {
            {
                "<leader>n",
                "<cmd>Flote<cr>",
                desc = "Open note",
            },
        },
        opts = {
            window_border = "rounded",
            files = {
                -- Using the parent .git folder as the current working directory
                cwd = function()
                    local bufPath = vim.api.nvim_buf_get_name(0)
                    local cwd =
                        require("lspconfig").util.root_pattern(".git")(bufPath)

                    return cwd
                end,
            },
        },
    },
}
