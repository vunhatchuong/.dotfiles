-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
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
            -- WINDOWS USES Zig:
            if vim.fn.executable("zig") == 1 then
                require("nvim-treesitter.install").compilers = { "zig" }
            end

            if type(opts.ensure_installed) == "table" then
                ---@type table<string, boolean>
                local added = {}
                opts.ensure_installed = vim.tbl_filter(function(lang)
                    if added[lang] then
                        return false
                    end
                    added[lang] = true
                    return true
                end, opts.ensure_installed)
            end
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {},
    },
}
