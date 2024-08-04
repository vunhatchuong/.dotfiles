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
                require("hover.providers.lsp")
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
                desc = "Compile",
            },
        },
        opts = {
            default_command = "",
            time_format = "%H:%M:%S",
            recompile_no_fail = true,
        },
    },
    {
        "psjay/buffer-closer.nvim",
        keys = { "q" },
        opts = {},
    },
}
