return {
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle" },
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" },
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
        event = "BufReadPost",
        -- stylua: ignore
        keys = {
            { "<Left>", function() require("origami").h() end },
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
        keys = {
            { "K", function() require("hover").hover() end },
        },
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
        keys = { "ga" },
        config = function()
            require("textcase").setup({})
            require("telescope").load_extension("textcase")
            vim.keymap.set(
                { "n", "v" },
                "ga",
                "TextCaseOpenTelescope",
                { desc = "Change word case" }
            )
        end,
    },
    { "psjay/buffer-closer.nvim", keys = { "q" }, opts = {} },
    {
        "anuvyklack/windows.nvim",
        dependencies = { "anuvyklack/middleclass" },
        opts = {},
        keys = {
            {
                "<leader>wf",
                "<cmd>WindowsMaximize<cr>",
                desc = "Maximize window",
            },
        },
    },
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
            { "<leader>lb", function() require("chainsaw").beepLog() end, desc = "󰐪 Beep" },
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
                    zig = 'std.debug.print("%s %s: {}", .{%s});',
                },
                objectLog = {
                    zig = 'std.debug.print("%s %s: {}", .{%s});',
                },
                assertLog = {
                    zig = 'std.debug.assert(%s, "%s %s");',
                },
                typeLog = {
                    zig = 'std.debug.print("%s %s: type is {}", .{@TypeOf(%s)});',
                },
                beepLog = {
                    zig = 'std.debug.print("%s beep %s", .{});',
                },
                messageLog = {
                    zig = 'std.debug.print("%s ", .{});',
                },
                stacktraceLog = {
                    zig = "std.debug.dumpCurrentStackTrace(null);",
                },
                timeLogStart = {
                    zig = "const timelogStart = std.time.Timer.start(); // %s",
                },
                timeLogStop = {
                    zig = {
                        "const durationNanos: f64 = @floatFromInt(timelogStart.read()); // %s",
                        'std.debug.print("%s: {d:.3}ms", .{durationNanos / std.time.ns_per_ms});',
                    },
                },
            },
        },
    },
    { -- Keep cursor position when yank
        "svban/YankAssassin.nvim",
        event = "VeryLazy",
        opts = { auto_normal = true, auto_visual = true },
    },
}
