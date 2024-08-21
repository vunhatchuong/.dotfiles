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
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle" },
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" },
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
    {
        "lewis6991/satellite.nvim",
        enabled = false,
        dependencies = { { "echasnovski/mini.diff" } },
        event = "VeryLazy",
        opts = {
            current_only = true,
            zindex = 1, -- below most stuff
            handlers = {
                cursor = { enable = false },
                -- gitsigns = { enable = false },
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
        "jinh0/eyeliner.nvim",
        keys = { "f", "F", "t", "T" },
        opts = { highlight_on_key = true, dim = true },
    },
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
    {
        "ej-shafran/compile-mode.nvim",
        cmd = { "Compile", "Recompile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>ox", "<cmd>Compile<cr>", desc = "Compile" },
            {
                "<leader>or",
                function()
                    vim.cmd("Recompile")
                    vim.cmd("wincmd k")
                end,
                desc = "Recompile",
            },
        },
        config = function()
            vim.g.compile_mode = {
                default_command = "",
                time_format = "%H:%M:%S",
                recompile_no_fail = true,
            }
        end,
    },
    {
        "vunhatchuong/compile-mode-test.nvim",
        dependencies = "ej-shafran/compile-mode.nvim",
        keys = {
            {
                "<leader>tl",
                "<CMD>CompileTestLine<CR>",
                desc = "[T]est Run [L]line",
            },
            {
                "<leader>tf",
                "<CMD>CompileTestFile<CR>",
                desc = "[T]est Run [F]ile",
            },
            {
                "<leader>td",
                "<CMD>CompileTestDir<CR>",
                desc = "[T]est Run [D]ir",
            },
            {
                "<leader>ta",
                "<CMD>CompileTestAll<CR>",
                desc = "[T]est Run [A]ll",
            },
        },
        config = function()
            require("compile-mode-test").setup({
                adapters = {
                    require("compile-mode-test.adapters.zig"),
                },
            })
        end,
    },
    {
        "psjay/buffer-closer.nvim",
        keys = { "q" },
        opts = {},
    },
    {
        "shortcuts/no-neck-pain.nvim",
        cmd = { "NoNeckPain" },
        keys = {
            { "<leader>zz", "<cmd>NoNeckPain<cr>", desc = "Toggle ZenMode" },
        },
        opts = {
            width = 120,
            disableOnLastBuffer = true,
            killAllBuffersOnDisable = true,
            fallbackOnBufferDelete = true,
            autocmds = {
                -- enableOnVimEnter = true,
                reloadOnColorSchemeChange = true,
                skipEnteringNoNeckPainBuffer = true,
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "UiEnter",
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        opts = function()
            -- PERF: we don't need this lualine require madness 🤷
            local lualine_require = require("lualine_require")
            lualine_require.require = require

            local icons = require("core.icons")

            vim.o.laststatus = vim.g.lualine_laststatus

            return {
                options = {
                    theme = {
                        normal = {
                            a = { fg = "fg", bg = "bg", gui = "bold" },
                            b = { fg = "fg", bg = "bg" },
                            c = { fg = "fg", bg = "bg" },
                        },
                    },
                    globalstatus = vim.o.laststatus == 3,
                    component_separators = "",
                    section_separators = "",
                },
                sections = {
                    lualine_a = {
                        { "mode" },
                        {
                            function()
                                return icons.ui.BoldLineMiddle
                            end,
                            color = { fg = "fg" },
                            padding = 0,
                        },
                    },
                    lualine_b = {
                        { "branch", color = { gui = "bold" } },
                        {
                            "diff",
                            diff_color = {
                                added = "Added",
                                modified = "Changed",
                                removed = "Removed",
                            },
                            symbols = {
                                added = icons.git.LineAdded,
                                modified = icons.git.LineModified,
                                removed = icons.git.LineRemoved,
                            },
                        },
                        {
                            function()
                                return icons.ui.BoldLineMiddle
                            end,
                            color = { fg = "fg" },
                            padding = 0,
                        },
                    },
                    lualine_c = {
                        {
                            "filetype",
                            icon_only = true,
                            padding = { left = 1, right = 0 },
                        },
                        { "filename", path = 1 },
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            symbols = {
                                error = icons.diagnostics.BoldError,
                                warn = icons.diagnostics.BoldWarning,
                                info = icons.diagnostics.BoldInformation,
                                hint = icons.diagnostics.BoldHint,
                            },
                        },
                    },
                    -- Right
                    lualine_x = {},
                    lualine_y = {
                        {
                            function()
                                local bufnr = vim.api.nvim_get_current_buf()
                                local buf_clients =
                                    vim.lsp.get_clients({ bufnr = bufnr })
                                local buf_ft = vim.bo.filetype
                                if next(buf_clients) == nil then
                                    return "No servers"
                                end
                                local buf_client_names = {}

                                for _, client in pairs(buf_clients) do
                                    if client.name ~= "null-ls" then
                                        table.insert(
                                            buf_client_names,
                                            client.name
                                        )
                                    end
                                end

                                local lint_s, lint = pcall(require, "lint")
                                if lint_s then
                                    for ft_k, ft_v in pairs(lint.linters_by_ft) do
                                        if type(ft_v) == "table" then
                                            for _, linter in ipairs(ft_v) do
                                                if buf_ft == ft_k then
                                                    table.insert(
                                                        buf_client_names,
                                                        linter
                                                    )
                                                end
                                            end
                                        elseif type(ft_v) == "string" then
                                            if buf_ft == ft_k then
                                                table.insert(
                                                    buf_client_names,
                                                    ft_v
                                                )
                                            end
                                        end
                                    end
                                end

                                local ok, conform = pcall(require, "conform")
                                local formatters = table.concat(
                                    conform.list_formatters_for_buffer(),
                                    " "
                                )
                                if ok then
                                    for formatter in formatters:gmatch("%w+") do
                                        if formatter then
                                            table.insert(
                                                buf_client_names,
                                                formatter
                                            )
                                        end
                                    end
                                end

                                local hash = {}
                                local unique_client_names = {}

                                for _, v in ipairs(buf_client_names) do
                                    if not hash[v] then
                                        unique_client_names[#unique_client_names + 1] =
                                            v
                                        hash[v] = true
                                    end
                                end
                                local language_servers =
                                    table.concat(unique_client_names, ", ")

                                return language_servers
                            end,
                            icon = icons.git.Octoface,
                            color = { gui = "bold" },
                        },
                    },
                    lualine_z = {
                        { "progress", padding = { left = 5, right = 0 } },
                        { "location" },
                    },
                },
                extensions = { "nvim-dap-ui", "oil", "quickfix", "trouble" },
            }
        end,
    },
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
}
