local icons = require("core.icons")
return {
    -- {
    --     "supermaven-inc/supermaven-nvim",
    --     build = ":SupermavenUseFree",
    --     cmd = "SupermavenToggle",
    --     opts = {
    --         log_level = "off",
    --         disable_keymaps = true,
    --         disable_inline_completion = true,
    --         ignore_filetypes = {
    --             gitcommit = true,
    --             TelescopePrompt = true,
    --         },
    --     },
    -- },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
                { path = "lazy.nvim", words = { "LazyVim" } },
            },
        },
    },
    {
        "saghen/blink.cmp",
        version = "v0.*",
        event = { "InsertEnter", "CmdlineEnter" },
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config
        --- @diagnostic disable: missing-fields
        opts = {
            keymap = {
                preset = "enter",
                ["<C-e>"] = {},

                ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

                ["<C-p>"] = {},
                ["<C-n>"] = {},

                ["<C-b>"] = {},
                ["<C-f>"] = {},
            },
            completion = {
                keyword = {
                    -- Remove `\`, so it does not trigger completion.
                    -- Useful when breaking up lines in bash/zsh.
                    regex = "[%w_-]",
                },
                list = { selection = "manual" },
                accept = { auto_brackets = { enabled = true } },
                menu = {
                    border = "rounded",
                    draw = {
                        treesitter = true,
                        columns = {
                            { "kind_icon", "kind", gap = 1 },
                            { "label", "label_description", gap = 1 },
                            { "source_name" },
                        },
                    },
                    -- Don't auto popup completion menu
                    -- auto_show = false,
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = { border = "rounded" },
                },
                -- Experimental signature help support
                signature = {
                    enabled = true,
                    window = { border = "border" },
                },
            },
            sources = {
                completion = {
                    enabled_providers = {
                        "lsp",
                        "path",
                        "snippets",
                        "buffer",
                        "lazydev",
                    },
                },
                providers = {
                    lsp = { fallback_for = { "lazydev" } },
                    buffer = {
                        max_items = 4,
                        min_keyword_length = 4,
                        score_offset = -3,
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                    },
                },
            },
            appearance = { kind_icons = icons.kind },
        },
    },
}
