-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main", -- new versions follow `main`
        lazy = false,
        init = function()
            vim.g.loaded_nvim_treesitter = 1
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        opts = {
            install_dir = vim.fn.stdpath("data") .. "/treesitter-parsers",
            matchup = { enable = true }, -- vim-matchup
        },
        config = function(_, opts)
            require("nvim-treesitter").setup(opts)

            vim.api.nvim_create_autocmd("FileType", {
                desc = "Enable Treesitter",
                callback = function()
                    -- Enable Treesitter syntax highlighting.
                    if pcall(vim.treesitter.start) then
                        vim.bo.indentexpr =
                            "v:lua.require'nvim-treesitter'.indentexpr()"
                        -- vim.wo.foldmethod = "expr"
                        -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    end
                end,
            })
        end,
    },
    {
        "lewis6991/ts-install.nvim",
        lazy = false,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = { auto_install = true },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = "VeryLazy",
        opts = {
            select = {
                lookahead = true,
                -- `true` would even remove line breaks from charwise objects,
                -- thus staying with `false`
                include_surrounding_whitespace = false,
            },
        },
    },
    {
        -- "windwp/nvim-ts-autotag",
        "tronikelis/ts-autotag.nvim",
        ft = { "html", "jsx", "xml", "templ" },
        -- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {},
    },
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            local spec_ts = ai.gen_spec.treesitter

            return {
                n_lines = 500,
                custom_textobjects = {
                    o = spec_ts({ -- code block
                        a = {
                            "@block.outer",
                            "@conditional.outer",
                            "@loop.outer",
                        },
                        i = {
                            "@block.inner",
                            "@conditional.inner",
                            "@loop.inner",
                        },
                    }),
                    f = spec_ts({ -- function
                        a = "@function.outer",
                        i = "@function.inner",
                    }),
                    c = spec_ts({ -- class
                        a = "@class.outer",
                        i = "@class.inner",
                    }),
                    t = { -- tags
                        "<([%p%w]-)%f[^<%w][^<>]->.-</%1>",
                        "^<.->().*()</[^/]->$",
                    },
                    -- u = spec_ts(), -- u for "Usage"
                    -- U = spec_ts({ name_pattern = "[%w_]" }), -- without dot in function name
                },
            }
        end,
    },
    {
        "danymat/neogen",
        cmd = { "Neogen" },
        opts = {
            snippet_engine = "nvim",
            languages = {
                python = {
                    template = {
                        annotation_convention = "google_docstrings",
                    },
                },
            },
        },
        keys = {
            {
                "<leader>cn",
                function()
                    require("neogen").generate()
                end,
                desc = "Generate Annotations (Neogen)",
            },
        },
    },
    { -- split-join lines
        "Wansmer/treesj",
        keys = { { "J", "<CMD>TSJToggle<CR>", desc = "Join Toggle" } },
        opts = { use_default_keymaps = false, max_join_length = 150 },
    },
    {
        "briangwaltney/paren-hint.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "VeryLazy",
        opts = {},
    },
    { -- Sort every child node of X type
        "maxbol/treesorter.nvim",
        cmd = "TSort",
        opts = {},
    },
}
