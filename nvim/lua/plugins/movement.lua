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
        keys = { { "<M-j>" }, { "<M-h>" } },
        opts = {},
    },
    {
        "glepnir/flybuf.nvim",
        keys = { { "gb", ":FlyBuf<CR>", desc = "Open buffer menu" } },
        opts = {},
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
            { -- Doesn't work on Windows?
                "<C-CR>",
                function()
                    require("in-and-out").in_and_out()
                end,
                mode = "i",
                desc = "In and out",
            },
        },
        opts = { additional_targets = { "<", ">" } },
    },
    {
        "vunhatchuong/telescope-jumps.nvim",
        enabled = false,
        dependencies = { { "nvim-telescope/telescope.nvim" } },
        keys = { { "<C-o>", ":Telescope jumps jumpbuff<CR>" } },
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
        event = "VeryLazy",
        keys = {
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
            {
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
            vim.api.nvim_del_keymap("o", "T")
            vim.api.nvim_del_keymap("o", "F")
        end,
    },
}
