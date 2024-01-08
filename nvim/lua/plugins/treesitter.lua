return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
            },
        },
        cmd = { "TSUpdateSync" },
        opts = {
            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "vim",
                "vimdoc",
                "lua",
                "html",
                "go",
                "python",
                "markdown",
                "markdown_inline",
                "json",
                "yaml",
                "toml",
            },
            matchup = {
                enable = true,
            },
        },
            -- ENABLES THIS IF USING WINDOWS:
            -- require('nvim-treesitter.install').compilers = { 'zig' }
    },

    -- Show context of the current function
    {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },

    -- Automatically add closing tags for HTML and JSX
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
}

