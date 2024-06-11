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
            -- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "https://codeberg.org/FelipeLema/cmp-async-path.git",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "uga-rosa/cmp-dynamic",
        },
        opts = function()
            vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#cba6f7" })
            vim.api.nvim_set_hl(
                0,
                "CmpGhostText",
                { link = "Comment", default = true }
            )
            local cmp = require("cmp")
            local cmp_confirm = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = false,
            })

            -- don't confirm for signature help to allow new line without selecting argument name
            local confirm = cmp.sync(function(fallback)
                local e = cmp.core.view:get_selected_entry()
                if e and e.source.name == "nvim_lsp_signature_help" then
                    fallback()
                else
                    cmp_confirm(fallback)
                end
            end)

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
                    expandable_indicator = true,
                    format = function(entry, item)
                        local icons = require("core.icons")
                        if icons.kind[item.kind] then
                            item.kind = icons.kind[item.kind] .. item.kind
                        end
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
                    { name = "async_path" },
                    { name = "cmp_tabnine" },
                    { name = "treesitter" },
                    { name = "snippets" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "dynamic" },
                },
                mapping = cmp.mapping.preset.insert({
                    -- Currently not working on windows
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = confirm,
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({
                                behavior = cmp.SelectBehavior.Select,
                            })
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
                            cmp.select_prev_item({
                                behavior = cmp.SelectBehavior.Select,
                            })
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
                    { name = "async_path" },
                }, {
                    { name = "cmdline" },
                }),
            })

            local cwd = require("lspconfig").util.find_git_ancestor(
                vim.fs.normalize(vim.api.nvim_buf_get_name(0))
            )
            local raw_files = vim.fn.globpath(cwd, ".env*", false, true)

            local env_vars = {}
            for i = 1, #raw_files do
                local file = raw_files[i]
                if string.match(vim.fn.fnamemodify(file, ":t"), "template") then
                    goto continue
                end

                local data = {}
                for line in io.lines(file) do
                    for key, value in string.gmatch(line, "([^=]+)=([^=]+)") do
                        data[key] = value
                    end
                end
                for key, value in pairs(data) do
                    table.insert(env_vars, {
                        label = key,
                        insertText = key,
                        detail = "From " .. vim.fn.fnamemodify(file, ":t"),
                        cmp = {
                            kind_text = "Env",
                            kind_hl_group = "CmpItemKindTabNine",
                        },
                    })
                end
                ::continue::
            end
            require("cmp_dynamic").register(env_vars)
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
