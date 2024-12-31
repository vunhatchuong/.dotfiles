return {
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle" },
        keys = {
            { "<leader>u", "<CMD>UndotreeToggle<CR>", desc = "Undo Tree" },
        },
    },
    {
        "chrisgrieser/nvim-early-retirement",
        event = "BufAdd",
        opts = {
            -- retirementAgeMins = 20,
            notificationOnAutoClose = true,
            deleteBufferWhenFileDeleted = true,
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
                require("hover.providers.man")
                require("hover.providers.dictionary")
            end,
            preview_opts = { border = vim.g.border_style },
        },
    },
    { "psjay/buffer-closer.nvim", keys = { "q" }, opts = {} },
    { -- Keep cursor position when yank
        "svban/YankAssassin.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = { auto_normal = true, auto_visual = true },
    },
    {
        "rlychrisg/truncateline.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {
            -- Note: Make it less than sidescrolloff
            line_start_length = 15,
        },
    },
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = { "ibhagwan/fzf-lua" },
        keys = {
            "y",
            "d",
            {
                "<leader>y",
                "<CMD>lua require('neoclip.fzf')()<CR>",
                desc = "Neoclip",
            },
        },
        opts = {
            history = 10,
            enable_macro_history = false,
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
        "philosofonusus/ecolog.nvim",
        event = "BufRead",
        keys = {
            {
                "<leader>fe",
                "<CMD>Telescope ecolog env<CR>",
                desc = "Ecolog: [F]ind [E]nvironment",
            },
        },
        opts = {
            path = Util.get_folder_location(),
            -- preferred_environment = "local",
            types = true,
            integrations = {
                lspsaga = true,
                blink_cmp = true,
                fzf = true,
            },
            shelter = {
                configuration = {
                    partial_mode = true,
                    mask_char = "•",
                },
                modules = {
                    files = true,
                    peek = true,
                    telescope = true,
                    cmp = true,
                    fzf = true,
                },
            },
        },
    },
    {
        "nacro90/numb.nvim",
        event = { "CmdlineEnter" },
        opts = {},
    },
    {
        "psliwka/vim-dirtytalk",
        lazy = false,
        build = ":DirtytalkUpdate",
        config = function()
            vim.opt.spelllang:append("programming")
        end,
    },
    { -- https://code.visualstudio.com/docs/editor/userdefinedsnippets#_variables

        "chrisgrieser/nvim-scissors",
        dependencies = "ibhagwan/fzf-lua",
        keys = {
            {
                "<leader>na",
                function()
                    require("scissors").addNewSnippet()
                end,
                mode = { "n", "x" },
                desc = "󰩫 Add",
            },
            {
                "<leader>nn",
                function()
                    require("scissors").editSnippet()
                end,
                desc = "󰩫 Edit",
            },
        },
        opts = {
            jsonFormatter = "jq",
        },
    },
}
