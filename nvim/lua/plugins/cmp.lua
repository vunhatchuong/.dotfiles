return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        -- Required
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        -- Adds LSP completion capabilities
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        -- "SergioRibera/cmp-dotenv",
        -- Additional snippets
        "rafamadriz/friendly-snippets",
    },
    config = function()
        vim.opt.completeopt = { "menu", "menuone", "noselect" }
        vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#cba6f7" })
        vim.api.nvim_set_hl(
            0,
            "CmpGhostText",
            { link = "Comment", default = true }
        )
        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, item)
                    local icons = require("core.icons")
                    if icons.kind[item.kind] then
                        item.kind = icons.kind[item.kind] .. item.kind
                    end
                    item.maxwidth = 50
                    item.ellipsis_char = "..."
                    item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                    })[entry.source.name]
                    return item
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText",
                },
            },
            sources = {
                {
                    name = "nvim_lsp",
                    entry_filter = function(entry, _)
                        local kind =
                            require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]

                        if kind == "Text" then
                            return false
                        end

                        return true
                    end,
                },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
                { name = "cmp_tabnine" },
                { name = "treesitter" },
                -- {
                --     name = "dotenv",
                --     option = {
                --         load_shell = false,
                --     },
                -- },
            },
            mapping = cmp.mapping.preset.insert({
                -- Currently not working on windows
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = false,
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
        })
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })
    end,
}
