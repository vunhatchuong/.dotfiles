return {
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            {
                "garymjr/nvim-snippets",
                opts = {
                    friendly_snippets = true,
                    global_snippets = { "all", "global" },
                },
                dependencies = { "rafamadriz/friendly-snippets" },
            },
            -- Adds LSP completion capabilities
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            -- "SergioRibera/cmp-dotenv",
        },
        opts = function()
            vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#cba6f7" })
            vim.api.nvim_set_hl(
                0,
                "CmpGhostText",
                { link = "Comment", default = true }
            )
            local cmp = require("cmp")
            cmp.setup({
                auto_brackets = {}, -- configure any filetype to auto add brackets
                completion = {
                    completeopt = "menu,menuone,noselect,noinsert",
                },
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
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
                    { name = "buffer" },
                    { name = "path" },
                    { name = "cmp_tabnine" },
                    { name = "treesitter" },
                    { name = "snippets" },
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
                        elseif vim.snippet.active({ direction = 1 }) then
                            vim.schedule(function()
                                vim.snippet.jump(1)
                            end)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.snippet.active({ direction = -1 }) then
                            vim.schedule(function()
                                vim.snippet.jump(-1)
                            end)
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
        config = function(_, opts)
            for _, source in ipairs(opts.sources) do
                source.group_index = source.group_index or 1
            end
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = function()
            return {
                library = {
                    uv = "luvit-meta/library",
                    lazyvim = "LazyVim",
                },
            }
        end,
    },
    -- Manage libuv types with lazy. Plugin will never be loaded
    { "Bilal2453/luvit-meta", lazy = true },
    -- Add lazydev source to cmp
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
    },
}
