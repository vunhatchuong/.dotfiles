return {
    -- open file given a line, Ex in terminal: nvim general.lua:20
    { "lewis6991/fileline.nvim", event = "BufNewFile" },
    { -- Ask when try to open a disambiguate file: nvim gener
        "vunhatchuong/actually.nvim",
        branch = "fix/nested-autocmd",
        event = "BufNewFile",
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
            { "<Right>", function() require("origami").l() end },
            { "l", function() require("origami").l() end },
        },
        opts = {
            -- This breaks fileline.nvim and actually.nvim
            keepFoldsAcrossSessions = false,
            foldKeymaps = { setup = false },
        },
        config = function(_, opts)
            require("origami").setup(opts)

            -- Modified version of
            -- https://github.com/chrisgrieser/nvim-origami/blob/main/lua/origami/fold-keymaps.lua
            local function normal(cmdStr)
                vim.cmd.normal({ cmdStr, bang = true })
            end

            local function h()
                local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                local onIndentOrFirstNonBlank =
                    vim.api.nvim_get_current_line():sub(1, col):match("^%s*$")

                -- HACK: After async Snacks.scope changes this will call twice
                -- So use var to prevents this.
                local executed = false

                local count = vim.v.count1 -- count needs to be saved due to `normal` affecting it
                for _ = 1, count, 1 do
                    Snacks.scope.get(function(scope)
                        if executed then
                            return
                        end
                        executed = true

                        if
                            onIndentOrFirstNonBlank
                            and (row == scope.from or row == scope.to)
                        then
                            local wasFolded = pcall(normal, "zc")
                            if not wasFolded then
                                normal("h")
                            end
                        else
                            normal("h")
                        end
                    end)
                end
            end

            vim.keymap.set("n", "h", function()
                h()
            end, { desc = "Origami h" })
            vim.keymap.set("n", "<Left>", function()
                h()
            end, { desc = "Origami left" })
        end,
    },
    {
        "lewis6991/hover.nvim",
        -- stylua: ignore
        keys = {
            { "K", function() require("hover").hover() end },
            { "gK", function() require("hover").hover_select() end },
        },
        opts = {
            init = function()
                -- require("plugins.lsp.lspsaga-hover")
                require("plugins.lsp.pretty-hover")
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
                "<CMD>EcologFzf<CR>",
                desc = "Ecolog: [F]ind [E]nvironment",
            },
        },
        opts = {
            path = Util.get_folder_location(),
            -- preferred_environment = "local",
            types = true,
            integrations = {
                lspsaga = false,
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
    {
        "NTBBloodbath/exemplum.nvim",
        cmd = "Exemplum",
        dependencies = { "NTBBloodbath/logging.nvim" },
    },
    { -- https://github.com/nikolaeu/numi/wiki
        "josephburgess/nvumi",
        dependencies = { "folke/snacks.nvim" },
        cmd = "Nvumi",
        opts = {
            virtual_text = "inline",
            keys = {
                run = "<CR>",
                reset = "R",
            },
        },
    },
    {
        "OXY2DEV/patterns.nvim",
        cmd = "Patterns",
        opts = {},
    },
}
