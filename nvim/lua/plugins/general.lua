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
        -- Origin repo is unmaintained: anuvyklack/fold-preview.nvim
        "cosmicbuffalo/fold-preview.nvim",
        branch = "fix-eventignore",
        dependencies = {
            "neovim/nvim-lspconfig",
            "anuvyklack/keymap-amend.nvim",
        },
        event = "VeryLazy",
        opts = {
            auto = 400,
            default_keybindings = false,
        },
        keys = {
            -- Doesn't work
            {
                "K",
                function()
                    require("fold-preview").show_preview()
                end,
                desc = "Show fold preview",
            },
        },
        config = function(_, opts)
            local keymap = vim.keymap
            local map = require("fold-preview").mapping
            keymap.amend = require("keymap-amend")

            require("fold-preview").setup(opts)

            keymap.amend("n", "l", map.close_preview)
            keymap.amend("n", "<Right>", map.close_preview)
        end,
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
    { -- paste with proper indentation
        "sickill/vim-pasta",
        event = "VeryLazy",
        config = function()
            vim.g.pasta_disabled_filetypes = {
                "gitcommit",
                "gitrebase",
                "svn",
                "fugitive",
                "fugitiveblame",
                "qf",
                "help",
            }
        end,
    },
    {
        "shortcuts/no-neck-pain.nvim",
        cmd = { "NoNeckPain" },
        opts = {
            buffers = {
                scratchPad = {
                    -- set to `false` to
                    -- disable auto-saving
                    enabled = true,
                    -- set to `nil` to default
                    -- to current working directory
                    pathToFile = "",
                },
                bo = {
                    filetype = "md",
                },
            },
        },
        config = function(_, opts)
            -- Same location as flote config in ./notes.lua
            -- Needs better way to sync between them
            -- Doesn't work well if you open Flote after open NoNeckPain
            local dir = vim.fn.stdpath("cache") .. "/flote"
            local cwd = require("lspconfig").util.find_git_ancestor(
                vim.fs.normalize(vim.api.nvim_buf_get_name(0))
            )
            local base_name = vim.fs.basename(cwd)
            local parent_base_name = vim.fs.basename(vim.fs.dirname(cwd))
            local file_name = parent_base_name .. "_" .. base_name .. ".md"

            opts.buffers.scratchPad.pathToFile =
                vim.fs.normalize(dir .. "/" .. file_name)

            require("no-neck-pain").setup(opts)
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
    { "bogado/file-line", event = "BufNewFile" },
    {
        "stevearc/overseer.nvim",
        -- stylua: ignore
        keys = {
            { "<leader>oo", "<cmd>OverseerToggle<cr>",      desc = "Task list" },
            { "<leader>or", "<cmd>OverseerRun<cr>",         desc = "Run task" },
            { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
            -- { "<leader>of", "<cmd>OverseerQuickAction open float<cr>", desc = "Open in float" },
            { "<leader>oi", "<cmd>OverseerInfo<cr>",        desc = "Overseer Info" },
        },
        opts = {
            templates = { "builtin", "user" },
            strategy = "toggleterm",
            dap = false,
            task_list = {
                default_detail = 2,
                bindings = {
                    ["<C-h>"] = false,
                    ["<C-j>"] = false,
                    ["<C-k>"] = false,
                    ["<C-l>"] = false,
                },
            },
            actions = {
                save = false,
                dispose = false,
                edit = false,
                retain = false,
                open = false,
                ["open hsplit"] = false,
                ["open vsplit"] = false,
                ["open tab"] = false,
                ["set quickfix diagnostics"] = false,
                ["set loclist diagnostics"] = false,
                ["open output in quickfix"] = false,
            },
        },
    },
    {
        "jinh0/eyeliner.nvim",
        keys = { "f", "F", "t", "T" },
        opts = { highlight_on_key = true, dim = true },
    },
}
