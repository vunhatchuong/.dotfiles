local icons = require("core.icons")
return {
    {
        "saghen/blink.compat",
        version = "*",
        lazy = true,
        opts = {},
    },
    {
        "saghen/blink.cmp",
        version = "*",
        event = "InsertEnter",
        opts_extend = { "sources.compat", "sources.default" },
        dependencies = {
            { "supermaven-nvim" },
        },
        --- @module "blink.cmp"
        --- @type blink.cmp.Config
        --- @diagnostic disable: missing-fields
        opts = {
            keymap = {
                preset = "none",
                ["<C-space>"] = { "show", "hide" },

                ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },

                ["<CR>"] = { "accept", "fallback" },

                cmdline = {
                    preset = "none",
                    ["<C-space>"] = { "show", "hide" },

                    ["<Tab>"] = { "select_next", "fallback" },
                    ["<S-Tab>"] = { "select_prev", "fallback" },
                    ["<Up>"] = { "select_prev", "fallback" },
                    ["<Down>"] = { "select_next", "fallback" },

                    ["<CR>"] = { "accept", "fallback" },
                },
            },
            completion = {
                list = {
                    selection = function(ctx)
                        return ctx.mode == "cmdline" and "auto_insert"
                            or "manual"
                    end,
                },
                accept = { auto_brackets = { enabled = false } },
                menu = {
                    -- auto_show = false,
                    draw = {
                        treesitter = { "lsp" },
                        columns = {
                            { "kind_icon", "kind", gap = 1 },
                            { "label", "label_description", gap = 1 },
                            { "source_name" },
                        },
                    },
                    border = vim.g.bordor_style,
                    winblend = vim.o.pumblend,
                    winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = {
                        border = vim.g.bordor_style,
                        winblend = vim.o.pumblend,
                        winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpDocCursorLine,Search:None",
                    },
                },
            },
            -- Experimental signature help support
            -- Disable floating win in ray-x/lsp_signature.nvim instead
            signature = {
                enabled = true,
                window = { border = vim.g.bordor_style },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                -- Don't show completion if len(cmd) < 2 words
                -- https://github.com/Saghen/blink.cmp/issues/585
                min_keyword_length = function(ctx)
                    if
                        ctx.mode == "cmdline"
                        and string.find(ctx.line, " ") == nil
                    then
                        return 2
                    end
                    return 0
                end,
                providers = {
                    lsp = {
                        name = "[LSP]",
                        score_offset = 4,
                    },
                    snippets = {
                        name = "[Snip]",
                        score_offset = 3,
                    },
                    path = {
                        name = "[Path]",
                        score_offset = 2,
                    },
                    buffer = {
                        name = "[Buf]",
                        max_items = 4,
                        min_keyword_length = 4,
                        score_offset = 1,
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
                        name = "[LazyDev]",
                        module = "lazydev.integrations.blink",
                        score_offset = 100, -- show at a higher priority than lsp
                    },
                },
            },
        },
    },
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                default = { "ecolog" },
                providers = {
                    ecolog = {
                        name = "[Env]",
                        module = "ecolog.integrations.cmp.blink_cmp",
                        score_offset = 101,
                    },
                },
            },
        },
    },
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                default = { "supermaven" },
                providers = {
                    supermaven = {
                        name = "supermaven",
                        module = "blink.compat.source",
                        score_offset = 100,
                        async = true,
                    },
                },
            },
        },
    },
}
