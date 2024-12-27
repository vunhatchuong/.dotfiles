-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        build = ":TSUpdate",
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        init = function(plugin)
            -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                init = function(plugin)
                    -- disable rtp plugin, as we only need its queries for mini.ai
                    -- In case other textobject modules are enabled, we will load them
                    -- once nvim-treesitter is loaded
                    require("lazy.core.loader").disable_rtp_plugin(plugin)
                    LOAD_TEXTOBJECTS = true
                end,
            },
        },
        opts = {
            -- Set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            -- vim-matchup
            matchup = {
                enable = true,
            },
            ensure_installed = {
                "lua",
                "luadoc",
                "luap",
                "bash",
                "vimdoc",
                "diff",
                "html",
                "http",
                "gitignore",
                "markdown",
                "markdown_inline",
                "query",
                "json",
                "jsonc",
                "yaml",
                "toml",
                "xml",
                "regex",
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
            if LOAD_TEXTOBJECTS then
                -- PERF: no need to load the plugin, if we only need its queries for mini.ai
                if opts.textobjects then
                    for _, mod in ipairs({
                        "move",
                        "select",
                        "swap",
                        "lsp_interop",
                    }) do
                        if
                            opts.textobjects[mod]
                            and opts.textobjects[mod].enable
                        then
                            require("lazy.core.loader").disabled_rtp_plugins["nvim-treesitter-textobjects"] =
                                nil
                            require("lazy.core.loader").source_runtime(
                                require("lazy.core.config").plugins["nvim-treesitter-textobjects"].dir,
                                "plugin"
                            )
                            break
                        end
                    end
                end
            end
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
        keys = { { "J", ":TSJToggle<CR>", desc = "Join Toggle" } },
        opts = { use_default_keymaps = false, max_join_length = 150 },
    },
    {
        "briangwaltney/paren-hint.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "VeryLazy",
        opts = {},
    },
}
