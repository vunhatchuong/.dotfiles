return {
    {
        "cbochs/grapple.nvim",
        keys = function()
            local function mark_file()
                if require("grapple").exists() then
                    vim.notify("󱡁 Mark")
                else
                    vim.notify("󱡁 Unmark")
                end
                require("grapple").toggle()
            end

            -- stylua: ignore
            local keys = {
                { "<leader>a", function() mark_file() end },
                { "<leader>m", function() require("grapple").toggle_tags() end},
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
        "gbprod/substitute.nvim",
        keys = { { "s", mode = { "n", "x" } }, { "ss" } },
        opts = {
            preserve_cursor_position = true,
            highlight_substituted_text = { timer = 40 },
        },
        config = function(_, opts)
            require("substitute").setup(opts)

            -- stylua: ignore start
            vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
            vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
            vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
            -- stylua: ignore end

            vim.cmd("hi! link SubstituteSubstituted IncSearch")
        end,
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
            },
            { -- Doesn't work on Windows?
                "<C-CR>",
                function()
                    require("in-and-out").in_and_out()
                end,
                mode = "i",
            },
        },
        opts = { additional_targets = { "<", ">" } },
    },
    {
        "vunhatchuong/telescope-jumps.nvim",
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
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<CR>",
                mode = { "n", "x", "o" },
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
                desc = "Flash",
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
                    jump = {
                        autojump = true,
                    },
                },
            },
            remote_op = {
                restore = true,
                motion = true,
            },
        },
    },
}
