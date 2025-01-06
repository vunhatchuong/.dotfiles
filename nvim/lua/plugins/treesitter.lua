-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        init = function(plugin)
            -- PERF: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                init = function(plugin)
                    require("lazy.core.loader").disable_rtp_plugin(plugin)
                    LOAD_TEXTOBJECTS = true
                end,
            },
        },
        opts_extend = { "ensure_installed" },
        opts = {
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            matchup = { enable = true }, -- vim-matchup
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        enabled = true,
        config = function()
            -- If treesitter is already loaded, we need to run config again for textobjects
            if Util.lazy.is_loaded("nvim-treesitter") then
                local opts = Util.lazy.opts("nvim-treesitter")
                ---@diagnostic disable-next-line: missing-fields
                require("nvim-treesitter.configs").setup({
                    textobjects = opts.textobjects,
                })
            end

            -- When in diff mode, we want to use the default
            -- vim text objects c & C instead of the treesitter ones.
            local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
            local configs = require("nvim-treesitter.configs")
            for name, fn in pairs(move) do
                if name:find("goto") == 1 then
                    move[name] = function(q, ...)
                        if vim.wo.diff then
                            local config =
                                configs.get_module("textobjects.move")[name] ---@type table<string,string>
                            for key, query in pairs(config or {}) do
                                if q == query and key:find("[%]%[][cC]") then
                                    vim.cmd("normal! " .. key)
                                    return
                                end
                            end
                        end
                        return fn(q, ...)
                    end
                end
            end
        end,
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
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({ -- code block
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
                    f = ai.gen_spec.treesitter({ -- function
                        a = "@function.outer",
                        i = "@function.inner",
                    }),
                    c = ai.gen_spec.treesitter({ -- class
                        a = "@class.outer",
                        i = "@class.inner",
                    }),
                    t = { -- tags
                        "<([%p%w]-)%f[^<%w][^<>]->.-</%1>",
                        "^<.->().*()</[^/]->$",
                    },
                    -- u = ai.gen_spec.function_call(), -- u for "Usage"
                    -- U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
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
