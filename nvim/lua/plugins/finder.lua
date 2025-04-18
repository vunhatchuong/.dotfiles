return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            defaults = {
                results_title = false,
                entry_prefix = "   ",
                sorting_strategy = "ascending",
                layout_config = { horizontal = { prompt_position = "top" } },
                mappings = {
                    n = { ["q"] = "close" },
                    i = { ["<ESC>"] = "close" },
                },
            },
        },
    },
    {
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        --stylua: ignore
        keys = {
            {
                "<leader><space>",
                desc = "Find Files",
                function()
                    local path, prompt_title = Util.get_folder_location()
                    require("fzf-lua").files({ cwd = path, winopts = { title = prompt_title } })
                end,
            },
            {
                "<leader>ft",
                desc = "[F]ind [T]ext",
                function()
                    local path, prompt_title = Util.get_folder_location()
                    require("fzf-lua").live_grep_native({ cwd = path, winopts = { title = prompt_title } })
                end,
            },
            {
                "<leader>fs",
                desc = "[F]ind [S]tring",
                function()
                    local path, prompt_title = Util.get_folder_location()
                    require("fzf-lua").grep_cword({ cwd = path, winopts = { title = prompt_title } })
                end,
            },
            {
                "<leader>,",
                desc = "FzfLua: Buffers",
                function() require("fzf-lua").buffers() end,
            },
            {
                "gr",
                desc = "[G]oto [R]eferences",
                function()
                    local cursor = vim.api.nvim_win_get_cursor(0)

                    require("fzf-lua").lsp_references({regex_filter=function(item)
                    if item.lnum == cursor[1] then return false end

                    return true
                end}) end,
            },
            {
                "gd",
                desc = "[G]oto [D]definition",
                function() require("fzf-lua").lsp_definitions() end,
            },
        },
        opts = function()
            local fzf = require("fzf-lua")
            local actions = fzf.actions

            return {
                { "border-fused", "hide" },
                fzf_colors = true,
                defaults = {
                    formatter = "path.dirname_first",
                    git_icons = true, -- display git status
                    file_icons = false,
                    no_header = true,
                },
                fzf_opts = {
                    ["--no-scrollbar"] = true,
                },
                winopts = {
                    backdrop = 100,
                    preview = {
                        default = "bat",
                        scrollbar = false,
                        delay = 10,
                        winopts = { -- builtin previewer window options
                            number = false,
                        },
                    },
                },
                previewers = {
                    builtin = {
                        extensions = {
                            ["png"] = Util.finder.image_previewer(),
                            ["jpg"] = Util.finder.image_previewer(),
                            ["jpeg"] = Util.finder.image_previewer(),
                            ["svg"] = { "chafa" },
                            ["gif"] = Util.finder.image_previewer(),
                            ["webp"] = Util.finder.image_previewer(),
                        },
                        ueberzug_scaler = "fit_contain",
                    },
                },
                actions = {
                    files = {
                        ["enter"] = actions.file_edit,
                        ["ctrl-h"] = actions.toggle_hidden,
                        ["ctrl-g"] = actions.toggle_ignore,
                    },
                },
                files = {
                    previewer = false,
                    file_icons = true,
                    winopts = { width = 0.5, height = 0.8 },
                },
                buffers = {
                    previewer = false,
                    winopts = { width = 0.5, height = 0.8 },
                },
                grep = {
                    -- fzf_opts = { ["--ansi"] = false },
                    grep_opts = "--color=never --binary-files=without-match --line-number --recursive --perl-regexp -e",
                    rg_opts = " --color=never --column --line-number --no-heading --smart-case --max-columns=4096 -e",
                },
                lsp = {
                    async = false, -- True will make jump1 shows UI
                    jump1 = true,
                    code_actions = {
                        previewer = "codeaction_native",
                    },
                },
                oldfiles = { include_current_session = true },
                keymap = {
                    builtin = {
                        true,
                        ["<C-d>"] = "preview-page-down",
                        ["<C-u>"] = "preview-page-up",
                    },
                    fzf = {
                        true,
                        ["ctrl-d"] = "preview-page-down",
                        ["ctrl-u"] = "preview-page-up",
                    },
                },
            }
        end,
    },
    {
        "snacks.nvim",
        --stylua: ignore
        keys = {
            { "<leader>u", function() Snacks.picker.undo() end, desc = "Undo Tree" },
        },
        opts = {
            ---@type snacks.picker.Config
            --- @diagnostic disable: missing-fields
            picker = {
                sources = {
                    files = {
                        -- cwd = "",
                        layout = {
                            -- layout = {
                            --     title = "hello",
                            -- },
                            preview = false,
                            preset = "vertical",
                        },
                    },
                },
                win = {
                    input = {
                        --stylua: ignore
                        keys = {
                            ["<Esc>"] = { "close", mode = { "n", "i" } },
                            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                        },
                    },
                },
            },
        },
    },
    { -- https://github.com/bassamsdata/namu.nvim/blob/main/docs/Namu_config.md
        "bassamsdata/namu.nvim",
        keys = {
            {
                "<leader>o",
                "<CMD>Namu symbols<CR>",
                desc = "Namu: Buffer Symbols",
            },
        },
        opts = {
            namu_symbols = {
                enable = true,
                options = {
                    auto_select = false,
                    multiselect = { enabled = false },
                    display = { mode = "icon", padding = 1 },
                    preview = { highlight_mode = "always" },
                    icon = ">",
                    window = { min_width = 25 },
                },
            },
            colorscheme = { enable = false },
            ui_select = { enable = false },
        },
    },
}
