return {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
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
}
