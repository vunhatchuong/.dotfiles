local icons = require("core.icons")

local ext = {
    "lazydev",
    "ecolog",
    "supermaven",
}
local default_sources =
    vim.list_extend({ "lsp", "path", "snippets", "buffer" }, ext)

return {
    {
        "saghen/blink.compat",
        version = "*",
        opts = {},
    },
    {
        "saghen/blink.cmp",
        version = "*",
        event = "InsertEnter",
        opts_extend = { "sources.compat", "sources.default" },
        dependencies = {
            { "supermaven-nvim" },
            "xzbdmw/colorful-menu.nvim",
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
            },
            cmdline = {
                keymap = {
                    preset = "none",
                    ["<C-space>"] = { "show", "hide" },

                    ["<Tab>"] = { "select_next", "fallback" },
                    ["<S-Tab>"] = { "select_prev", "fallback" },
                    ["<Up>"] = { "select_prev", "fallback" },
                    ["<Down>"] = { "select_next", "fallback" },

                    ["<CR>"] = { "accept_and_enter", "fallback" },
                },
            },
            completion = {
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = function(ctx)
                            return ctx.mode == "cmdline" and true or false
                        end,
                    },
                },
                accept = { auto_brackets = { enabled = false } },
                menu = {
                    -- auto_show = false,
                    draw = {
                        treesitter = { "lsp" },
                        columns = {
                            { "kind_icon", "kind", gap = 1 },
                            -- { "label", "label_description", gap = 1 },
                            { "label", gap = 1 }, -- colorful-menu.nvim combines both labels
                            { "source_name" },
                        },
                        -- colorful_menu.nvim
                        -- stylua: ignore
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                    border = vim.g.border_style,
                    winblend = vim.o.pumblend,
                    winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = {
                        border = vim.g.border_style,
                        winblend = vim.o.pumblend,
                        winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpDocCursorLine,Search:None",
                    },
                },
            },
            -- Experimental signature help support
            -- Disable floating win in ray-x/lsp_signature.nvim instead
            signature = {
                enabled = true,
                window = {
                    border = vim.g.border_style,
                    show_documentation = true,
                },
            },
            sources = {
                default = function()
                    if _G.LearnMode then
                        return { "buffer" }
                    end

                    return default_sources
                end,
                providers = {
                    lsp = {
                        name = "[LSP]",
                        score_offset = 4,
                    },
                    path = {
                        name = "[Path]",
                        score_offset = 2,
                    },
                    snippets = {
                        name = "[Snip]",
                        score_offset = 3,
                    },
                    buffer = {
                        name = "[Buf]",
                        max_items = 4,
                        min_keyword_length = 4,
                        score_offset = 1,
                    },
                    cmdline = {
                        min_keyword_length = 2,
                        -- Ignores cmdline cmp when executing certain shell commands
                        -- This avoid lags, mainly in Win/WSL
                        enabled = function()
                            local cmd_type = vim.fn.getcmdtype()
                            local cmd_line = vim.fn.getcmdline()

                            if cmd_type == ":" then
                                if cmd_line:match("^[%%0-9,'<>%-]*!") then
                                    return false
                                end
                                if
                                    cmd_line:match("^%s*Compile")
                                    or cmd_line:match("^%s*term")
                                then
                                    return false
                                end
                            end

                            return true
                        end,
                    },
                    -- Extensions
                    lazydev = {
                        name = "[LazyDev]",
                        module = "lazydev.integrations.blink",
                        score_offset = 100, -- show at a higher priority than lsp
                    },
                    ecolog = {
                        name = "[Env]",
                        module = "ecolog.integrations.cmp.blink_cmp",
                        score_offset = 101,
                    },
                    supermaven = {
                        name = "supermaven",
                        module = "blink.compat.source",
                        score_offset = 100,
                        async = true,
                    },
                },
            },
            appearance = { kind_icons = icons.kind },
        },
    },
}
