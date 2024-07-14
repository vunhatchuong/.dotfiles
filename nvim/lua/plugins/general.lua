return {
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
        dependencies = {
            {
                "echasnovski/mini.diff",
            },
        },
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
}
