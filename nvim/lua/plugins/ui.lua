local icons = require("core.icons")
return {
    { "m00qek/baleia.nvim", opts = {} },
    {
        "echasnovski/mini.icons",
        lazy = true,
        init = function()
            require("mini.icons").mock_nvim_web_devicons()
        end,
        opts = {
            file = {
                [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
                ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
            },
            filetype = {
                dotenv = { glyph = "", hl = "MiniIconsYellow" },
            },
        },
    },
    { -- Replaces the UI for messages, cmdline and the popupmenu.
        "folke/noice.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        event = "VeryLazy",
        opts = {
            presets = {
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
                lsp_doc_border = true,
            },
            notify = { enabled = false }, -- using snacks.nvim
            lsp = {
                progress = { enabled = false }, -- using my own
                signature = { enabled = false }, -- using lsp_signature.nvim
                hover = { enabled = false }, -- using hover.nvim

                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- stylua: ignore
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                            { find = "%d+B written$" },
                            { find = "%-%-No lines in buffer%-%-" },
                            { find = "^E486: Pattern not found" },
                            { find = "^%[nvim%-treesitter%]" },
                        },
                    },
                    view = "mini",
                },

                -- Skip search messages
                { filter = { event = "msg_show", find = "^[/?]." }, skip = true },
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d fewer lines" },
                            { find = "%d more lines" },
                            { find = "%d lines <ed %d time[s]?" },
                            { find = "%d lines >ed %d time[s]?" },
                            { find = "%d lines yanked" },
                            { find = "^E36: Not enough room" },
                        },
                    },
                    skip = true,
                },

                -- FIX https://github.com/artempyanykh/marksman/issues/348
                { filter = { event = "notify", find = "^Client marksman quit with" }, skip = true },

                -- code actions
                { filter = { event = "notify", find = "No code actions available" }, skip = true },
            },
            views = {
                cmdline_popup = {
                    position = { row = 20, col = "50%" },
                    size = { width = 60, height = "auto" },
                },
                notify = { focusable = false },
                mini = { size = { max_height = 3 } },
            },
        },
    },
    { -- Color picker
        "uga-rosa/ccc.nvim",
        cmd = { "CccPick" },
        config = function()
            local ccc = require("ccc")
            local mapping = ccc.mapping
            ccc.setup({
                -- nvim-colorizer is better
                highlighter = {
                    auto_enable = false,
                },
                mappings = {
                    ["<Right>"] = mapping.increase1,
                    ["<Left>"] = mapping.decrease1,
                },
            })
        end,
    },
    {
        "catgoose/nvim-colorizer.lua",
        cmd = { "ColorizerToggle" },
        -- event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        opts = {
            user_default_options = {
                css = true,
                css_fn = true,
                tailwind = true, ---@type boolean|"normal"|"lsp"|"both" True is same as normal

                mode = "virtualtext", ---@type "background"|"foreground"|"virtualtext" Highlighting mode
                virtualtext = "",
                virtualtext_inline = true,

                -- update color values even if buffer is not focused
                -- example use: cmp_menu, cmp_docs
                always_update = false,
            },
        },
    },
    {
        "echasnovski/mini.hipatterns",
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        opts = {
            -- stylua: ignore
            highlighters = {
                fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
                hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
                todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
                note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
            },
        },
    },
    {
        "echasnovski/mini.indentscope",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "netrw",
                    "help",
                    "lspinfo",
                    "lazy",
                    "mason",
                    "oil",
                    "trouble",
                    "TelescopePrompt",
                    "fzf",
                    "undotree",
                    "grapple",
                    "notify",
                    "snacks_dashboard",
                    "snacks_notif",
                    "snacks_terminal",
                    "snacks_win",
                    "toggleterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,

                vim.api.nvim_set_hl(
                    0,
                    "MiniIndentscopeSymbol",
                    { link = "Special" }
                ),
            })
        end,
        opts = {
            -- symbol = "╷",
            -- symbol = "┃",
            symbol = "│",
            options = { indent_at_cursor = true, try_as_border = true },
            draw = {
                animation = function()
                    return 0
                end,
            },
        },
    },
    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        opts = {
            show_in_active_only = true,
            hide_if_all_visible = true,
            throttle_ms = 500,
            excluded_filetypes = {
                "dropbar_menu",
                "dropbar_menu_fzf",
                "DressingInput",
                "noice",
                "prompt",
                "TelescopePrompt",
                "snacks_dashboard",
                "blink-cmp-menu",
                "blink-cmp-signature",
                "blink-cmp-documentation",
            },
            handlers = {
                cursor = false,
                diagnostic = true,
                -- gitsigns = false, -- Requires gitsigns
            },
        },
    },
    {
        "tzachar/local-highlight.nvim",
        event = "BufRead",
        opts = {
            hlgroup = "LspReferenceText",
            cw_hlgroup = "LspReferenceText",
            highlight_single_match = false,
        },
    },
    {
        "cdmill/focus.nvim",
        event = "BufWinEnter",
        cmd = { "Focus", "Zen", "Narrow" },
        keys = {
            { "<leader>zz", "<CMD>Focus<CR>", desc = "Toggle Zen" },
            { "<leader>zm", "<CMD>Zen<CR>", desc = "Toggle Minimal" },
        },
        opts = {
            window = {
                backdrop = 0.8,
            },
            auto_zen = true,
            zen = {
                diagnostics = true, -- disables diagnostics
                opts = {
                    colorcolumn = "",
                },
            },
            plugins = {
                -- gitsigns = { enabled = false }, -- disables git signs
                -- todo = { enabled = false }, -- if set to "true", todo-comments.nvim highlights will be disabled
            },
        },
        config = function(_, opts)
            require("focus").setup(opts)

            -- vim.api.nvim_create_autocmd("VimEnter", {
            --     desc = "Enter Focus",
            --     callback = function()
            --         require("focus").toggle({})
            --     end,
            -- })
            vim.api.nvim_create_autocmd("VimEnter", {
                desc = "Enter Zen",
                callback = function()
                    require("focus").toggle_zen({})
                end,
            })
        end,
    },
    { "lukas-reineke/virt-column.nvim", lazy = false, opts = {} },
    {
        "m4xshen/smartcolumn.nvim",
        lazy = false,
        opts = {
            disabled_filetypes = {
                "netrw",
                "NvimTree",
                "Lazy",
                "mason",
                "help",
                "text",
                "markdown",
                "tex",
                "html",
            },
            scope = "line",
        },
    },
    {
        "ryanfkeepers/conceal.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            local conceal = require("conceal")
            conceal.setup({})

            conceal.generate_conceals()
        end,
    },
    {
        "xzbdmw/colorful-menu.nvim",
        lazy = false,
        opts = {},
    },
}
