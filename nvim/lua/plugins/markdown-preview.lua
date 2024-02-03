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

        -- This won't work on some shell?? Currently not working on Windows
        if vim.fn.system("node --version > /dev/null 2>&1") == 0 then
            print(
                "Node.js is not installed. Please install Node.js to continue."
            )
            vim.cmd(
                "silent !cd "
                    .. install_path
                    .. " && npm install && git restore ."
            )
        else
            print("Node not found")
            vim.fn["mkdp#util#install"]()
        end
    end,
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
        vim.g.mkdp_auto_close = 0
    end,
}
