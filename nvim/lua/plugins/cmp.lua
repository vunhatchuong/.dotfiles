local icons = require("core.icons")

local ext = {
    "lazydev",
    "ecolog",
    "supermaven",
    "lorem_ipsum",
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
            { "lorem-ipsum.nvim" },
            "xzbdmw/colorful-menu.nvim",
        },
        --- @module "blink.cmp"
        --- @type blink.cmp.Config
        --- @diagnostic disable: missing-fields
        opts = {
            keymap = {
                preset = "none",
                ["<C-space>"] = { "show", "hide" },
                ["<Esc>"] = { "cancel", "fallback" },

                ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },

                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },

                ["<CR>"] = { "accept", "fallback" },
            },
            cmdline = {
                keymap = {
                    preset = "inherit",
                    ["<CR>"] = { "accept_and_enter", "fallback" },
                },
                completion = {
                    list = {
                        selection = { preselect = false, auto_insert = true },
                    },
                    menu = { auto_show = true },
                    ghost_text = { enabled = false },
                },
            },
            completion = {
                accept = { auto_brackets = { enabled = false } },
                list = {
                    selection = { preselect = false, auto_insert = false },
                },
                menu = {
                    -- auto_show = false,
                    draw = {
                        treesitter = { "lsp" },
                        columns = {
                            -- { "label", "label_description", gap = 1 },
                            { "kind_icon", "label", gap = 1 }, -- colorful-menu.nvim combines both labels,
                            { "kind", gap = 1 },
                            { "source_name" },
                        },
                        components = {
                            -- stylua: ignore
                            kind_icon = {
                                highlight = function(ctx)
                                    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                    return hl
                                end,
                            },
                            kind = {
                                highlight = function(ctx)
                                    return "None"
                                end,
                            },
                            -- colorful_menu.nvim
                            -- stylua: ignore
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                            source_name = {
                                text = function(ctx)
                                    return "[" .. ctx.source_name .. "]"
                                end,
                            },
                        },
                    },
                    winblend = vim.o.pumblend,
                    winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = {
                        winblend = vim.o.pumblend,
                        winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpDocCursorLine,Search:None",
                    },
                    draw = function(opts)
                        if opts.item and opts.item.documentation then
                            local out = require("pretty_hover.parser").parse(
                                opts.item.documentation.value
                            )
                            opts.item.documentation.value = out:string()
                        end

                        opts.default_implementation(opts)
                    end,
                },
            },
            -- Experimental signature help support
            -- Disable floating win in ray-x/lsp_signature.nvim instead
            signature = {
                enabled = true,
                window = {
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
                        score_offset = 4,
                    },
                    path = {
                        name = "Path",
                        score_offset = 2,
                    },
                    snippets = {
                        name = "Snip",
                        score_offset = 3,
                    },
                    buffer = {
                        name = "Buf",
                        max_items = 5,
                        -- min_keyword_length = 4,
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
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100, -- show at a higher priority than lsp
                    },
                    ecolog = {
                        name = "Env",
                        module = "ecolog.integrations.cmp.blink_cmp",
                        score_offset = 101,
                    },
                    supermaven = {
                        name = "SuperMaven",
                        module = "blink.compat.source",
                        score_offset = 100,
                        async = true,
                        opts = {
                            cmp_name = "supermaven",
                            impersonate_nvim_cmp = true,
                        },
                    },
                    lorem_ipsum = {
                        name = "lorem",
                        module = "blink.compat.source",
                        score_offset = 100,
                        opts = {
                            cmp_name = "lorem_ipsum",
                            impersonate_nvim_cmp = true,
                        },
                    },
                },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                kind_icons = icons.kind,
            },
        },
    },
}
