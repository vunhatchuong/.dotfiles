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
                    local cwd = require("lspconfig").util.find_git_ancestor(
                        vim.fs.normalize(vim.api.nvim_buf_get_name(0))
                    )

                    return cwd
                end,
            },
        },
    },
    {
        "serenevoid/kiwi.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {
                "<leader>nw",
                ':lua require("kiwi").open_wiki_index("wiki")<cr>',
                desc = "Open Wiki index",
            },
            {
                "<leader>nt",
                ':lua require("kiwi").todo.toggle()<cr>',
                desc = "Toggle Markdown Task",
            },
        },
        config = function()
            local wiki_index = vim.fn.has("win64") == 1 and "D:/wiki"
                or "~/wiki"
            require("kiwi").setup({
                {
                    name = "wiki",
                    path = wiki_index,
                },
            })
        end,
    },
}
