return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
            },
        },
        cmd = { "TSUpdateSync" },
        opts = {
            -- Set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            autopairs = { enable = true },
            ensure_installed = {
                "lua",
                "bash",
                "vimdoc",
                "html",
                "http",
                "gitignore",
                "markdown",
                "markdown_inline",
                "json",
                "yaml",
                "toml",
                "regex",
            },
            matchup = {
                enable = true,
            },
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                },
            },
        },

        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            -- ENABLES THIS IF USING WINDOWS:
            require("nvim-treesitter.install").compilers = { "zig" }
        end,
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
