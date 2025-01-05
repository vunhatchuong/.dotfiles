return {
    {
        "cbochs/grapple.nvim",
        keys = function()
            local function mark_file()
                if require("grapple").exists() then
                    vim.notify("󱡁 Unmark")
                else
                    vim.notify("󱡁 Mark")
                end
                require("grapple").toggle()
            end

            -- stylua: ignore
            local keys = {
                { "<leader>a", function() mark_file() end, desc = "Grapple: Toggle mark" },
                { "<leader>m", function() require("grapple").toggle_tags() end, desc = "Grapple: Toggle UI" },
            }
            for i = 1, 5 do
                keys[#keys + 1] = {
                    "<leader>" .. i,
                    function()
                        require("grapple").select({ index = i })
                    end,
                    desc = "Grapple " .. i,
                }
            end

            return keys
        end,
        opts = {},
    },
    {
        "echasnovski/mini.move",
        enabled = false,
        keys = { { "<A-j>" }, { "<A-h>" } },
        opts = {},
    },
    {
        "glepnir/flybuf.nvim",
        keys = { { "<leader>j", "<CMD>FlyBuf<CR>", desc = "Open buffer menu" } },
        opts = { border = vim.g.border_style },
    },
    { -- Move in and out of brackets
        "vunhatchuong/in-and-out.nvim",
        branch = "fix/nvim-v0.10.1-compatibility",
        keys = {
            {
                "<TAB>",
                function()
                    require("in-and-out").in_and_out()
                end,
                mode = "n",
                desc = "In and out",
            },
        },
        opts = { additional_targets = { "<", ">" } },
    },
    {
        "vunhatchuong/telescope-jumps.nvim",
        enabled = false,
        dependencies = { { "nvim-telescope/telescope.nvim" } },
        keys = { { "<C-o>", "<CMD>Telescope jumps jumpbuff<CR>" } },
        opts = {
            extensions = {
                jumps = {
                    -- max_results = 5,
                    line_distance = 3,
                },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("jumps")
        end,
    },
    {
        "vunhatchuong/fzf-lua-jumplist.nvim",
        dependencies = { "ibhagwan/fzf-lua" },
        keys = {
            {
                "<C-o>",
                function()
                    require("fzf-lua-jumplist").jumplist()
                end,
            },
        },
        opts = {
            start_of_line = false,
            -- max_result = 5,
            line_distance_threshold = 3,
        },
    },
    {
        "folke/flash.nvim",
        keys = {
            { "f", "t" },
            {
                "<CR>",
                mode = { "n", "x", "o" },
                desc = "Flash",
                function()
                    local Flash = require("flash")

                    ---@param opts Flash.Format
                    local function format(opts)
                        -- always show first and second label
                        return {
                            { opts.match.label1, "FlashMatch" },
                            { opts.match.label2, "FlashLabel" },
                        }
                    end

                    --- @diagnostic disable: missing-fields
                    Flash.jump({
                        search = { mode = "search" },
                        label = {
                            after = false,
                            before = { 0, 0 },
                            uppercase = false,
                            format = format,
                        },
                        pattern = [[\<]],
                        action = function(match, state)
                            state:hide()
                            Flash.jump({
                                search = { max_length = 0 },
                                highlight = { matches = false },
                                label = { format = format },
                                matcher = function(win)
                                    -- limit matches to the current label
                                    return vim.tbl_filter(function(m)
                                        return m.label == match.label
                                            and m.win == win
                                    end, state.results)
                                end,
                                labeler = function(matches)
                                    for _, m in ipairs(matches) do
                                        m.label = m.label2 -- use the second label
                                    end
                                end,
                            })
                        end,
                        labeler = function(matches, state)
                            local labels = state:labels()
                            for m, match in ipairs(matches) do
                                match.label1 =
                                    labels[math.floor((m - 1) / #labels) + 1]
                                match.label2 = labels[(m - 1) % #labels + 1]
                                match.label = match.label1
                            end
                        end,
                    })
                end,
            },
            { -- Use a label, or ; and , to increase/decrease the selection
                "R",
                mode = { "n", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            { -- Do things remotely: drf[label][motion]
                "r",
                mode = "o",
                desc = "Remote Flash",
                function()
                    require("flash").remote()
                end,
            },
        },
        ---@type Flash.Config
        opts = {
            search = { multi_window = false },
            modes = {
                char = {
                    jump_labels = true,
                    multi_line = false,
                    search = { wrap = true },
                    jump = { autojump = true },
                    keys = { "f", "t" },
                },
                treesitter = {
                    label = { before = true, after = true, style = "inline" },
                },
            },
            remote_op = {
                restore = true,
                motion = true,
            },
        },
        config = function(_, opts)
            require("flash").setup(opts)

            --[[ Fix motion doesn't work like vanilla
                https://github.com/folke/flash.nvim/discussions/263 ]]
            vim.api.nvim_del_keymap("o", "t")
            vim.api.nvim_del_keymap("o", "f")
        end,
    },
    {
        "saghen/blink.nvim",
        lazy = false, -- all modules handle lazy loading internally
        keys = {
            {
                ";",
                function()
                    require("blink.chartoggle").toggle_char_eol(";")
                end,
                mode = { "n" },
                desc = "Toggle ; at eol",
            },
            {
                "<C-;>",
                function()
                    require("blink.chartoggle").toggle_char_eol(";")
                end,
                mode = { "i", "n" },
                desc = "Toggle ; at eol",
            },
            {
                ",",
                function()
                    require("blink.chartoggle").toggle_char_eol(",")
                end,
                mode = { "n" },
                desc = "Toggle , at eol",
            },
            {
                "<C-,>",
                function()
                    require("blink.chartoggle").toggle_char_eol(",")
                end,
                mode = "i",
                desc = "Toggle , at eol",
            },
        },
        opts = {
            chartoggle = { enabled = true },
            select = {
                enabled = true,
            },
        },
    },
    {
        "mizlan/iswap.nvim",
        cmd = { "ISwapWithLeft", "ISwapWithRight" },
        -- stylua: ignore
        keys = {
            { "<leader>ii", "<CMD>ISwap<CR>",          desc = "iswap" },
            { "<leader>in", "<CMD>ISwapNode<CR>",      desc = "swap-nodes" },
            { "<leader>iw", "<CMD>ISwapWith<CR>",      desc = "swap-with" },
            { "<leader>il", "<CMD>ISwapWithLeft<CR>",  desc = "swap-with-left" },
            { "<leader>ir", "<CMD>ISwapWithRight<CR>", desc = "swap-with-right" },

            { "<A-S-h>", "<CMD>ISwapWithLeft<CR>",  desc = "swap-with-left" },
            { "<A-S-l>", "<CMD>ISwapWithRight<CR>", desc = "swap-with-right" },
        },
        opts = {
            flash_style = "simultaneous",
            autoswap = true,
        },
    },
    {
        "aaronik/treewalker.nvim",
        cmd = "Treewalker",
        keys = {
            { "<A-k>", "<CMD>Treewalker Up<CR>zz", mode = { "n", "v" } },
            { "<A-j>", "<CMD>Treewalker Down<CR>zz", mode = { "n", "v" } },
            { "<A-h>", "<CMD>Treewalker Left<CR>zz", mode = { "n", "v" } },
            { "<A-l>", "<CMD>Treewalker Right<CR>zz", mode = { "n", "v" } },

            { "<A-S-k>", "<CMD>Treewalker SwapUp<CR>" },
            { "<A-S-j>", "<CMD>Treewalker SwapDown<CR>" },
            -- { "<A-S-h>", "<CMD>Treewalker SwapLeft<CR>" },
            -- { "<A-S-l>", "<CMD>Treewalker SwapRight<CR>" },
        },
        opts = {
            highlight = false, -- Highlight breaks Hydra
            highlight_duration = 150,
            highlight_group = "Visual",
        },
    },
    {
        "mschlumpp/quick-switch.nvim",
        keys = {
            {
                "<leader>.",
                function()
                    require("quick-switch").start_switch()
                end,
                desc = "Buffer quick switch",
            },
        },
        opts = {},
    },
}
