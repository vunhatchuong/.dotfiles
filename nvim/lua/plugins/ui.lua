local icons = require("core.icons")
return {
    {
        "echasnovski/mini.icons",
        lazy = true,
        opts = {
            file = {
                [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
                ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
            },
            filetype = {
                dotenv = { glyph = "", hl = "MiniIconsYellow" },
            },
        },
        config = function(_, opts)
            local mini_icons = require("mini.icons")
            mini_icons.setup(opts)
            mini_icons.mock_nvim_web_devicons()
        end,
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
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        opts = {
            user_default_options = {
                rgb_fn = true,
                hsl_fn = true,

                css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
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
                    "harpoon",
                    "TelescopePrompt",
                    "fzf",
                    "notify",
                    "undotree",
                    "grapple",
                    "toggleterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
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
        config = function(_, opts)
            require("mini.indentscope").setup(opts)
            vim.cmd("hi! link MiniIndentscopeSymbol Special")
        end,
    },
    { -- Bug closed as not planned: https://github.com/lewis6991/satellite.nvim/issues/81
        "lewis6991/satellite.nvim",
        enabled = false,
        dependencies = { { "echasnovski/mini.diff" } },
        event = "VeryLazy",
        opts = {
            current_only = true,
            handlers = {
                cursor = { enable = false },
                gitsigns = { enable = false },
                -- require diff.lua
                minidiff = { enable = true },
                marks = { enable = false },
                quickfix = { enable = false },
            },
        },
        config = function(_, opts)
            require("plugins.lsp.mini-diff-satellite")
            require("satellite").setup(opts)
        end,
    },
    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        opts = {
            show_in_active_only = true,
            -- hide_if_all_visible = true,
            handlers = {
                cursor = false,
                diagnostic = true,
                -- gitsigns = true,
                -- I can't implement minidiff for this :(
                search = true, -- Requires hlslens
            },
        },
    },
    { -- when searching, search count is shown next to the cursor
        "kevinhwang91/nvim-hlslens",
        keys = {
            {
                "n",
                "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
                desc = "Increment",
            },
            {
                "N",
                "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
                desc = "Decrement",
            },
        },
        opts = {
            nearest_only = true,
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
        "vunhatchuong/focus.nvim",
        branch = "feat/auto-disable",
        event = "BufWinEnter",
        cmd = { "Focus", "Zen", "Narrow" },
        keys = {
            { "<leader>zz", ":Focus<CR>", desc = "Toggle Zen" },
            { "<leader>zm", ":Zen<CR>", desc = "Toggle Minimal" },
        },
        opts = {
            window = {
                backdrop = 0.8,
            },
            auto_zen = true,
            auto_disable_zen = true,
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
        "vunhatchuong/bmessages.nvim",
        branch = "feat/filetype",
        event = "CmdlineEnter",
        opts = {
            split_type = "split",
            split_direction = "botright",
        },
    },
    {
        "svampkorg/moody.nvim",
        event = { "ModeChanged", "BufWinEnter", "WinEnter" },
        opts = {
            -- you can set different blend values for your different modes.
            -- Some colours might look better more dark, so set a higher value
            -- will result in a darker shade.
            blends = {
                normal = 0.2,
                insert = 0.2,
                visual = 0.25,
                command = 0.2,
                operator = 0.2,
            },
            colors = {
                normal = vim.api.nvim_get_hl(0, { name = "WarningMsg" }).fg,
                insert = vim.api.nvim_get_hl(0, { name = "Function" }).fg,
                visual = vim.api.nvim_get_hl(0, { name = "Function" }).fg,
                command = vim.api.nvim_get_hl(0, { name = "String" }).fg,
                operator = vim.api.nvim_get_hl(0, { name = "WarningMsg" }).fg,
                -- terminal = "#4CD4BD",
                -- terminal_n = "#00BBCC",
            },
            disabled_filetypes = { "TelescopePrompt", "fzf" },
            -- disabled buftypes here
            disabled_buftypes = {},
            -- you can turn on or off bold characters for the line numbers
            bold_nr = true,
            extend_to_linenr = false,
        },
    },
}
