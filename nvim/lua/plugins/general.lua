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
        opts = {},
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
    { -- Upper: u, Lower: l, Snake: s, Dash: d, Const: n, Camel: c, Pascal: p
        -- Usage: ga{u} to change cursor word to upper
        -- gao to turn into motion mode. Ex: gaouw means change a word to upper
        "johmsalas/text-case.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        keys = {
            { "ga" },
            {
                "ga.",
                ":TextCaseOpenTelescope<CR>",
                mode = { "n", "x" },
                desc = "Change word case",
            },
        },
        config = function()
            require("textcase").setup({})
            require("telescope").load_extension("textcase")
        end,
    },
    { "psjay/buffer-closer.nvim", keys = { "q" }, opts = {} },
    {
        "chrisgrieser/nvim-chainsaw",
        cmd = "ChainSaw",
        -- stylua: ignore
        keys = {
            { "<leader>ll", function() require("chainsaw").variableLog() end, mode = { "n", "x" }, desc = "󰐪 Var" },
            { "<leader>lo", function() require("chainsaw").objectLog() end, mode = { "n", "x" }, desc = "󰐪 Object" },
            { "<leader>la", function() require("chainsaw").assertLog() end, mode = { "n", "x" }, desc = "󰐪 Assert" },
            { "<leader>lt", function() require("chainsaw").typeLog() end, mode = { "n", "x" }, desc = "󰐪 Type" },
            { "<leader>lm", function() require("chainsaw").messageLog() end, desc = "󰐪 Message" },
            { "<leader>l1", function() require("chainsaw").timeLog() end, desc = "󰐪 Time" },
            { "<leader>ld", function() require("chainsaw").debugLog() end, desc = "󰐪 Debugger" },
            { "<leader>ls", function() require("chainsaw").stacktraceLog() end, desc = "󰐪 Stacktrace" },
            { "<leader>lk", function() require("chainsaw").clearLog() end, desc = "󰐪 Clear" },

            { "<leader>lr", function() require("chainsaw").removeLogs() end, desc = "󰐪 󰅗 Remove logs" },
        },
        opts = {
            marker = ".>",
            logHighlightGroup = false,
            logStatements = {
                variableLog = {
                    zig = 'std.debug.print("{{marker}} {{var}}: {}", .{{{var}}});',
                },
                objectLog = {
                    zig = 'std.debug.print("{{marker}} {{var}}: {}", .{{{var}}});',
                },
                assertLog = {
                    zig = 'std.debug.assert({{var}}, "{{marker}} {{var}}");',
                },
                typeLog = {
                    zig = 'std.debug.print("{{marker}} {{var}}: type is {}", .{@TypeOf({{var}})});',
                },
                messageLog = {
                    zig = 'std.debug.print("{{marker}} ", .{});',
                },
                stacktraceLog = {
                    zig = "std.debug.dumpCurrentStackTrace(null);",
                },
                timeLogStart = {
                    zig = "const timelogStart{{index}} = std.time.Timer.start(); // {{marker}}",
                },
                timeLogStop = {
                    zig = {
                        "const durationNanos: f64 = @floatFromInt(timelogStart{{index}}.read()); // %s",
                        'std.debug.print("{{marker}}: {d:.3}ms", .{durationNanos / std.time.ns_per_ms});',
                    },
                },
            },
        },
    },
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
            { "<leader>xs", ":CodeSnap<CR>", mode = { "n", "x" } },
            { "<leader>xS", ":CodeSnapSave<CR>", mode = { "n", "x" } },
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
        "glepnir/template.nvim",
        cmd = { "Template" },
        opts = {
            temp_dir = vim.fn.stdpath("config") .. "/template",
            author = "Vu Nhat Chuong",
            email = "ronnyvu321@gmail.com",
        },
    },
    {
        "vunhatchuong/browse.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        -- stylua: ignore
        keys = {
            { "<leader>b",  ":Browse<CR>" },
            { "<leader>bi", ":BrowseInputSearch<CR>" },
            { "<leader>bb", ":BrowseBookmarks<CR>" },
            { "<leader>bd", ":BrowseDevdocsSearch<CR>" },
            { "<leader>bf", ":BrowseDevdocsFiletypeSearch<CR>" },
            { "<leader>bm", ":BrowseMdnSearch<CR>" }
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
        "AckslD/nvim-neoclip.lua",
        dependencies = { { "nvim-telescope/telescope.nvim" } },
        keys = { { "<leader>y", ":Telescope neoclip<CR>" } },
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
        "jaimecgomezz/here.term",
        enabled = false,
        keys = { { "<C-\\>" }, { "<C-S-\\>" } },
        opts = {
            mappings = {
                toggle = "<C-\\>",
                kill = "<C-S-\\>",
            },
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
    {
        "xavierchanth/arbor.nvim",
        cmd = { "Arbor" },
        ---@type arbor.config
        opts = {
            apply_recommended = false,
            worktree = {
                normal = { base = "relative_common", path = "../.." },
                bare = { base = "relative_common", path = "../.." },
            },
            actions = {
                add = {
                    ["add new branch"] = function(info)
                        require("arbor").actions.add_new_branch(info, {
                            path_style = function()
                                return vim.fs.basename(info.new_branch)
                            end,
                            branch_style = "prompt",
                        })
                    end,
                },
                pick = {
                    ["remove worktree"] = function()
                        require("arbor").remove()
                    end,
                },
            },
            hooks = {
                post_add = function(info)
                    return Util.worktree.arbor_post_add(info)
                end,
                post_pick = function(info)
                    return Util.worktree.arbor_post_switch(info)
                end,
                pre_remove = function(info)
                    return Util.worktree.arbor_pre_remove(info)
                end,
            },
        },
    },
    {
        "vunhatchuong/guess-indent.nvim",
        branch = "feat/auto-retab",
        cmd = { "GuessIndent" },
        opts = { auto_cmd = false },
    },
}
