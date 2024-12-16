return {
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle" },
        keys = {
            { "<leader>u", ":UndotreeToggle<CR>", desc = "Undo Tree" },
        },
    },
    {
        "chrisgrieser/nvim-early-retirement",
        event = "VeryLazy",
        opts = {
            -- retirementAgeMins = 20,
            notificationOnAutoClose = true,
        },
    },
    {
        "chrisgrieser/nvim-origami",
        event = "VeryLazy",
        -- stylua: ignore
        keys = {
            { "<Left>",  function() require("origami").h() end },
            { "<Right>", function() require("origami").l() end },
        },
        opts = {
            -- This breaks fileline.nvim and actually.nvim
            keepFoldsAcrossSessions = false,
        },
    },
    { -- Turn off features when file > ? MB
        "pteroctopus/faster.nvim",
        lazy = false,
        opts = {
            behaviours = {
                bigfile = {
                    on = true,
                    filesize = 2,
                },
            },
        },
    },
    -- open file given a line, Ex in terminal: nvim general.lua:20
    { "lewis6991/fileline.nvim", event = "BufNewFile" },
    -- Ask when try to open a disambiguate file: nvim gener
    {
        "vunhatchuong/actually.nvim",
        branch = "fix/nested-autocmd",
        event = "BufNewFile",
    },
    {
        "lewis6991/hover.nvim",
        -- stylua: ignore
        keys = { { "K", function() require("hover").hover() end } },
        opts = {
            init = function()
                -- require("hover.providers.lsp")
                require("plugins.lsp.lspsaga-hover")
                require("hover.providers.fold_preview")
            end,
            preview_opts = { border = "rounded" },
        },
    },
    { "psjay/buffer-closer.nvim", keys = { "q" }, opts = {} },
    { -- Keep cursor position when yank
        "svban/YankAssassin.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = { auto_normal = true, auto_visual = true },
    },
    { -- Install distant then run :DistantConnect ssh://{username}@{IP}
        "chipsenkbeil/distant.nvim",
        cmd = { "DistantInstall", "DistantConnect", "DistantLaunch" },
        opts = {
            ["network.private"] = true,
            -- manager = {
            --     log_file = "/tmp/manager.log",
            --     log_level = "trace",
            -- },
        },
        config = function(_, opts)
            require("distant"):setup(opts)
        end,
    },
    {
        "mistricky/codesnap.nvim",
        -- Doesn't support Windows yet
        enabled = vim.fn.has("Linux") == 1,
        build = "make",
        -- stylua: ignore
        cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapASCII", "CodeSnapHighlight" },
        keys = {
            {
                "<leader>xs",
                mode = { "n", "x" },
                desc = "CodeSnap",
                ":CodeSnap<CR>",
            },
            {
                "<leader>xS",
                mode = { "n", "x" },
                desc = "CodeSnap: Save",
                ":CodeSnapSave<CR>",
            },
        },
        opts = {
            save_path = "~/Pictures",
            mac_window_bar = false,
            has_breadcrumbs = true,
            show_workspace = true,
            has_line_number = true,
            bg_theme = "peach",
            -- bg_color = "#535c68",
        },
    },
    {
        "HakonHarnes/img-clip.nvim",
        cmd = { "PasteImage" },
        keys = {
            {
                "<leader>p",
                function()
                    local telescope = require("telescope.builtin")
                    local actions = require("telescope.actions")
                    local action_state = require("telescope.actions.state")

                    telescope.find_files({
                        attach_mappings = function(_, map)
                            local function embed_image(prompt_bufnr)
                                local entry = action_state.get_selected_entry()
                                local filepath = entry[1]
                                actions.close(prompt_bufnr)

                                require("img-clip").paste_image(nil, filepath)
                            end

                            map("i", "<CR>", embed_image)
                            map("n", "<CR>", embed_image)

                            return true
                        end,
                    })
                end,
                desc = "Paste Image",
            },
        },
        opts = {},
    },
    {
        "rlychrisg/truncateline.nvim",
        event = "VeryLazy",
        opts = {
            -- Note: Make it less than sidescrolloff
            line_start_length = 15,
        },
    },
    {
        "vunhatchuong/browse.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        -- stylua: ignore
        keys = {
            { "<leader>b",  ":Browse<CR>", desc = "Browse" },
            { "<leader>bi", ":BrowseInputSearch<CR>", desc = "Browse: Input Search"  },
            { "<leader>bb", ":BrowseBookmarks<CR>", desc = "Browse: Bookmarks"  },
            { "<leader>bd", ":BrowseDevdocsSearch<CR>", desc = "Browse: Dev docs"  },
            { "<leader>bf", ":BrowseDevdocsFiletypeSearch<CR>", desc = "Browse: Filetype"  },
            { "<leader>bm", ":BrowseMdnSearch<CR>", desc = "Browse: MDN"  }
        },
        opts = {
            provider = "duckduckgo",
            bookmarks = {
                ["personal"] = {
                    ["github"] = "https://github.com/vunhatchuong",
                    ["dotfiles"] = "https://github.com/vunhatchuong/.dotfiles",
                },
                ["github"] = {
                    ["repo_search"] = "https://github.com/%s",
                    ["awesome-nvim"] = "https://github.com/rockerBOO/awesome-neovim",
                },
                ["docs"] = {
                    ["learnxinyminutes"] = "https://learnxinyminutes.com/docs/%s",
                    ["pkg.go.dev"] = "https://pkg.go.dev/search?q=%s",
                    ["zig:std"] = "https://ziglang.org/documentation/master/std/",
                },
                ["entertainment"] = {
                    ["neovim_reddit"] = "https://www.reddit.com/r/neovim/",
                    ["unix-porn_reddit"] = "https://www.reddit.com/r/unixporn/",
                },
            },
            icons = {
                bookmarks_prompt = "󰂺 ",
                bookmark_alias = " ",
                grouped_bookmarks = "|",
            },
        },
    },
    {
        "chrishrb/gx.nvim",
        cmd = { "Browse" },
        keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        opts = {
            handlers = {
                brewfile = false,
            },
            handler_options = { search_engine = "duckduckgo" },
        },
    },
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = { { "nvim-telescope/telescope.nvim" } },
        keys = { { "<leader>y", ":Telescope neoclip<CR>", desc = "Neoclip" } },
        opts = {
            enable_macro_history = false,
            preview = false,
            filter = function(data)
                local function is_whitespace(line)
                    return vim.fn.match(line, [[^\s*$]]) ~= -1
                end

                local function all(tbl, check)
                    for _, entry in ipairs(tbl) do
                        if not check(entry) then
                            return false
                        end
                    end
                    return true
                end
                return not all(data.event.regcontents, is_whitespace)
            end,
            default_register = { '"', "+" },
        },
    },
    {
        "Tronikelis/xylene.nvim",
        cmd = { "Xylene" },
        opts = {},
    },
    {
        "smilhey/ed-cmd.nvim",
        event = { "CmdlineEnter" },
        init = function()
            local saved_sidescrolloff
            vim.api.nvim_create_autocmd("CmdlineEnter", {
                desc = "Temporarily set sidescrolloff to 0 in command-line mode",
                callback = function()
                    saved_sidescrolloff = vim.opt.sidescrolloff
                    vim.opt.sidescrolloff = 0
                end,
            })

            vim.api.nvim_create_autocmd("CmdlineLeave", {
                desc = "Restore sidescrolloff after leaving command-line mode",
                callback = function()
                    if saved_sidescrolloff then
                        vim.opt.sidescrolloff = saved_sidescrolloff
                    end
                end,
            })
        end,
        opts = {
            cmdline = {
                keymaps = { close = "<ESC>" },
                win_config = function()
                    return {
                        relative = "editor",
                        width = math.ceil(vim.o.columns / 3),
                        row = math.floor(vim.o.lines * 0.2),
                        col = math.floor(vim.o.columns / 3),
                        height = 1,
                        style = "minimal",
                        border = "single",
                        zindex = 200,
                    }
                end,
            },
        },
    },
    {
        "meznaric/key-analyzer.nvim",
        cmd = { "KeyAnalyzer" },
        opts = {},
    },
}
