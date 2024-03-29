return {
    "echasnovski/mini.diff",
    event = "VeryLazy",
    config = function()
        local icons = require("core.icons")
        local mini_diff = require("mini.diff")
        local function is_open()
            local summary = mini_diff.get_buf_data(0)
            vim.notify("hunk range" .. summary.summary.n_ranges)
            if mini_diff.get_buf_data(0).hunks == 0 then
                print("There are no hunks in this buffer.")
                return false
            end
            return true
        end
        local nmap = function(keys, func, desc)
            if desc then
                desc = "MiniDiff: " .. desc
            end
            vim.keymap.set("n", keys, func, { buffer = true, desc = desc })
        end
        local function hunk_navigation(direction)
            if direction == "next" then
                mini_diff.goto_hunk("next")
            elseif direction == "prev" then
                mini_diff.goto_hunk("prev")
            end
        end
        mini_diff.setup({
            view = {
                style = "sign",
                signs = {
                    add = icons.ui.BoldLineMiddle,
                    change = icons.ui.BoldLineMiddle,
                    delete = icons.ui.TriangleShortArrowRight,
                },
            },
            mappings = {
                apply = "<leader>ha",
                reset = "<leader>hr",
                textobject = "<leader>ha",

                goto_first = "",
                goto_prev = "",
                goto_next = "",
                goto_last = "",
            },
        })
            -- stylua: ignore start
            nmap("<leader>hh", function() mini_diff.toggle_overlay(0) end, "Toggle mini.diff overlay")
            nmap("<leader>hn",
                function()
                    if is_open() then
                        hunk_navigation("next")
                    end
                end,
                "Next hunk"
            )
            nmap("<leader>hp",
                function()
                    if is_open() then
                        hunk_navigation("prev")
                    end
                end,
                "Prev hunk"
            )
        -- stylua: ignore end
    end,
}
