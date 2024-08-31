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
        "brenoprata10/nvim-highlight-colors",
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        opts = {},
    },
    {
        "echasnovski/mini.indentscope",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {
            symbol = "│",
            options = { indent_at_cursor = true, try_as_border = true },
            draw = {
                animation = function()
                    return 0
                end,
            },
        },
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
        "shortcuts/no-neck-pain.nvim",
        cmd = { "NoNeckPain" },
        keys = {
            { "<leader>zz", ":NoNeckPain<CR>", desc = "Toggle ZenMode" },
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
}
