return {
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        cmd = {
            "MarkdownPreview",
            "MarkdownPreviewStop",
            "MarkdownPreviewToggle",
        },
        keys = {
            {
                "<leader>md",
                "<cmd>MarkdownPreviewToggle<cr>",
                desc = "Find recently opened Files",
            },
        },
        build = function()
            local install_path = vim.fn.stdpath("data")
                .. "/lazy/markdown-preview.nvim/app"

            if vim.fn.executable("node") == 0 then
                print("Node not found")
                vim.fn["mkdp#util#install"]()
            else
                vim.cmd(
                    "silent !cd "
                        .. install_path
                        .. " && npm install && git restore ."
                )
            end
        end,
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_auto_close = 0
        end,
    },
    {
        "MeanderingProgrammer/markdown.nvim",
        name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = { "markdown" },
        config = function()
            require("render-markdown").setup({})
        end,
    },
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
