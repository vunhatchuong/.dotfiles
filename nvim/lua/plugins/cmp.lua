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
                        -- colorful_menu.nvim
                        -- stylua: ignore
                        components = {
                            label = {
                                width = { fill = true, max = 60 },
                                text = function(ctx)
                                    local highlights_info =
                                        require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
                                    if highlights_info ~= nil then return highlights_info.text else
                                        return ctx.label
                                    end
                                end,
                                highlight = function(ctx)
                                    local highlights_info =
                                        require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
                                    local highlights = {}
                                    if highlights_info ~= nil then
                                        for _, info in
                                            ipairs(highlights_info.highlights)
                                        do
                                            table.insert(highlights, {
                                                info.range[1],
                                                info.range[2],
                                                group = ctx.deprecated and "BlinkCmpLabelDeprecated" or info[1],
                                            })
                                        end
                                    end
                                    for _, idx in
                                        ipairs(ctx.label_matched_indices)
                                    do
                                        table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                                    end
                                    return highlights
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
                window = { border = vim.g.border_style },
            },
            sources = {
                default = function()
                    if _G.LearnMode then
                        return { "buffer" }
                    end

                    return default_sources
                end,

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
