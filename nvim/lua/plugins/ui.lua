local icons = require("core.icons")
return {
    { "m00qek/baleia.nvim", opts = {} },
    {
        "echasnovski/mini.icons",
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
                            { find = "^[/?]."  }, -- Skip search messages
                        },
                    },
                    skip = true,
                },
                {
                    filter = {
                        event = "notify",
                        any = {
                            { find = "^Client marksman quit with" }, -- FIX https://github.com/artempyanykh/marksman/issues/348
                            { find = "No code actions available" },
                            { find = "No information available" },
                        },
                    },
                    skip = true,
                },
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
        "echasnovski/mini.cursorword",
        event = "BufRead",
        opts = { delay = 350 },
        config = function(_, opts)
            require("mini.cursorword").setup(opts)
            vim.api.nvim_set_hl(0, "MiniCursorword", { link = "Visual" })
        end,
    },
    {
        "cdmill/focus.nvim",
        enabled = false,
        event = "BufWinEnter",
        cmd = { "Focus", "Zen", "Narrow" },
        keys = {
            { "<leader>zz", "<CMD>Focus<CR>", desc = "Toggle Zen" },
            { "<leader>zm", "<CMD>Zen<CR>", desc = "Toggle Minimal" },
        },
        opts = {
            window = { backdrop = 1 },
            auto_zen = true,
            maintain_zen = true,
            zen = {
                diagnostics = true,
                opts = {
                    colorcolumn = "",
                },
            },
            plugins = {
                gitsigns = { enabled = true },
                -- tmux = { enabled = false },
            },
        },
        config = function(_, opts)
            require("focus").setup(opts)

            vim.api.nvim_create_autocmd("VimEnter", {
                desc = "Focus.nvim: Enter Zen",
                callback = function()
                    require("focus").toggle_zen({})
                    require("focus").toggle({})
                end,
            })
        end,
    },
    { "lukas-reineke/virt-column.nvim", event = "VimEnter", opts = {} },
    {
        "hankertrix/nerd_column.nvim",
        event = { "BufEnter" },
        opts = {
            scope = "line",
        },
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = "UIEnter",
        init = function()
            -- recommended by nvim-ufo: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
        end,
        opts = {
            open_fold_hl_timeout = 150,
            --- @diagnostic disable: unused-local
            provider_selector = function(_bufnr, ft, _buftype)
                -- ufo accepts only two kinds as priority, see https://github.com/kevinhwang91/nvim-ufo/issues/256
                local lspWithOutFolding =
                    { "markdown", "zsh", "bash", "css", "python", "json" }

                if vim.tbl_contains(lspWithOutFolding, ft) then
                    return { "treesitter", "indent" }
                end
                return { "lsp", "indent" }
            end,
            -- Use `:UfoInspect` to get see available fold kinds
            close_fold_kinds_for_ft = {
                default = { "imports", "comment" },
                json = { "array" },
                markdown = {}, -- avoid everything becoming folded
                toml = {},
                python = { "import_from_statement" },
            },
            fold_virt_text_handler = function(
                virtText,
                lnum,
                endLnum,
                width,
                truncate
            )
                local hlgroup = "MoreMsg"
                local icon = ""

                local newVirtText = {}
                local suffix = (" %s %d"):format(icon, endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0

                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix
                                .. (" "):rep(
                                    targetWidth - curWidth - chunkWidth
                                )
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end

                table.insert(newVirtText, { suffix, hlgroup })
                return newVirtText
            end,
        },
    },
    {
        "OXY2DEV/helpview.nvim",
        ft = "help",
        opts = {},
    },
}
