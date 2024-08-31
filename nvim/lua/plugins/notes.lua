return {
    {
        "JellyApple102/flote.nvim",
        cmd = { "Flote" },
        keys = { { "<leader>n", ":Flote<CR>", desc = "Open note" } },
        opts = {
            window_border = "rounded",
            files = {
                -- Using the parent .git folder as the current working directory
                cwd = function()
                    local cwd = require("lspconfig").util.find_git_ancestor(
                        vim.fs.normalize(vim.api.nvim_buf_get_name(0))
                    )

                    return cwd
                end,
            },
        },
    },
}
