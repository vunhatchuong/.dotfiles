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
        "saghen/blink.cmp",
        version = "v0.*",
        opts_extend = { "sources.default" },
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

                cmdline = {
                    preset = "enter",
                },
            },
            completion = {
                trigger = {
                    -- show_on_insert_on_trigger_character = false,
                },
                list = { selection = "manual" },
                accept = { auto_brackets = { enabled = false } },
                menu = {
                    border = vim.g.bordor_style,
                    draw = {
                        treesitter = { "lsp" },
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
                    window = { border = vim.g.bordor_style },
                },
            },
            -- Experimental signature help support
            signature = {
                enabled = true,
                window = { border = vim.g.bordor_style },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                providers = {
                    buffer = {
                        max_items = 4,
                        min_keyword_length = 4,
                        score_offset = -3,
                    },
                },
            },
            appearance = { kind_icons = icons.kind },
        },
    },
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                default = { "lazydev" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100, -- show at a higher priority than lsp
                    },
                },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            for server, config in pairs(opts.servers) do
                config.capabilities = require("blink.cmp").get_lsp_capabilities(
                    config.capabilities
                )
                lspconfig[server].setup(config)
            end
        end,
    },
}
