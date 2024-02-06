return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
        local icons = require("core.icons")
        local gs = require("gitsigns")
        gs.setup({
            signs = {
                add = { text = icons.ui.BoldLineMiddle },
                change = { text = icons.ui.BoldLineMiddle },
                delete = { text = icons.ui.TriangleShortArrowRight },
                topdelete = { text = icons.ui.TriangleShortArrowRight },
                changedelete = { text = icons.ui.BoldLineMiddle },
            },
            preview_config = {
                border = "rounded",
            },

            on_attach = function(buffer)
                local function is_open(id)
                    for _, winid in ipairs(vim.api.nvim_list_wins()) do
                        if vim.w[winid].gitsigns_preview == id then
                            return winid
                        end
                    end
                    return nil
                end

                local function map(modes, keys, func, desc)
                    if type(keys) == "string" then
                        keys = { keys }
                    end
                    if desc then
                        desc = "Gitsigns: " .. desc
                    end
                    for _, value in ipairs(keys) do
                        vim.keymap.set(modes, value, func, {
                            buffer = buffer,
                            desc = desc,
                        })
                    end
                end
                -- stylua: ignore start
                map("n",
                    "<leader>hn",
                    function()
                        if is_open("hunk") then
                            vim.schedule(function() gs.next_hunk() end)
                        end
                    end,
                    "Next hunk"
                )
                map("n",
                    "<leader>hh",
                    function()
                        if is_open("hunk") then
                            vim.schedule(function() gs.prev_hunk() end)
                        end
                    end,
                    "Prev hunk"
                )
                map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
                map("n", "<leader>hb", gs.toggle_current_line_blame, "Line blame")
                map("n", "<leader>hd", gs.diffthis, "Diff")
                -- stylua: ignore end
            end,
        })
    end,
}
