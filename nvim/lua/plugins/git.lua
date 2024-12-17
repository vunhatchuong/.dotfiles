return {
    {
        "echasnovski/mini.diff",
        event = "VeryLazy",
        config = function()
            local icons = require("core.icons")
            local mini_diff = require("mini.diff")
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
                    apply = "",
                    reset = "",
                    textobject = "",

                    goto_first = "",
                    goto_prev = "",
                    goto_next = "",
                    goto_last = "",
                },
            })
            local function is_open()
                local summary = mini_diff.get_buf_data(0)
                vim.notify("hunk range" .. summary.summary.n_ranges)
                if mini_diff.get_buf_data(0).hunks == 0 then
                    print("There are no hunks in this buffer.")
                    return false
                end
                return true
            end
            local function hunk_navigation(direction)
                if not is_open() then
                    return
                end
                if direction == "next" then
                    mini_diff.goto_hunk("next")
                elseif direction == "prev" then
                    mini_diff.goto_hunk("prev")
                end
            end
            local nmap = function(keys, func, desc)
                if desc then
                    desc = "MiniDiff: " .. desc
                end
                vim.keymap.set("n", keys, func, { desc = desc })
            end

        -- stylua: ignore start
        nmap("<leader>hh", function() mini_diff.toggle_overlay(0) end, "Toggle overlay")
        nmap("<leader>hn", function() hunk_navigation("next") end, "Next hunk")
        nmap("<leader>hp", function() hunk_navigation("prev") end, "Prev hunk")
            -- stylua: ignore end
        end,
    },
    {
        "akinsho/git-conflict.nvim",
        opts = {
            -- Use :GitConflictChoose{WHO}
            default_mappings = {
                ours = "o",
                theirs = "t",
                none = "0",
                both = "b",
                next = "n",
                prev = "p",
            },
            disable_diagnostics = true,
        },
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            {
                "<leader>hd",
                "<Cmd>DiffviewOpen<CR>",
                mode = "n",
                desc = "diffview: Open",
            },
            {
                "<leader>hf",
                [[:'<'>DiffviewFileHistory<CR>]],
                mode = "v",
                desc = "diffview: File history",
            },
            {
                "<leader>hf",
                "<Cmd>DiffviewFileHistory<CR>",
                mode = "n",
                desc = "diffview: File history",
            },
        },
        opts = {
            default_args = { DiffviewFileHistory = { "%" } },
            enhanced_diff_hl = true,
            hooks = {
                diff_buf_read = function()
                    local opt = vim.opt_local
                    opt.wrap, opt.list, opt.relativenumber = false, false, false
                    opt.colorcolumn = ""
                end,
            },
            file_panel = { win_config = { width = 30 } },
            keymaps = {
                view = {
                    q = "<Cmd>DiffviewClose<CR>",
                    {
                        "n",
                        "<leader>e",
                        function()
                            require("diffview.actions").toggle_files()
                        end,
                        { desc = "Toggle the file panel" },
                    },
                },
                file_panel = {
                    q = "<Cmd>DiffviewClose<CR>",
                    {
                        "n",
                        "<leader>e",
                        function()
                            require("diffview.actions").toggle_files()
                        end,
                        { desc = "Toggle the file panel" },
                    },
                },
                file_history_panel = {
                    q = "<Cmd>DiffviewClose<CR>",
                    {
                        "n",
                        "<leader>e",
                        function()
                            require("diffview.actions").toggle_files()
                        end,
                        { desc = "Toggle the file panel" },
                    },
                },
            },
        },
    },
    {
        "xavierchanth/arbor.nvim",
        cmd = { "Arbor" },
        ---@type arbor.config
        opts = {
            apply_recommended = false,
            worktree = {
                normal = { base = "relative_common", path = "../.." },
                bare = { base = "relative_common", path = "../.." },
            },
            actions = {
                add = {
                    ["add new branch"] = function(info)
                        require("arbor").actions.add_new_branch(info, {
                            path_style = function()
                                return vim.fs.basename(info.new_branch)
                            end,
                            branch_style = "prompt",
                        })
                    end,
                },
                pick = {
                    ["remove worktree"] = function()
                        require("arbor").remove()
                    end,
                },
            },
            hooks = {
                post_add = function(info)
                    return Util.worktree.arbor_post_add(info)
                end,
                post_pick = function(info)
                    return Util.worktree.arbor_post_switch(info)
                end,
                pre_remove = function(info)
                    return Util.worktree.arbor_pre_remove(info)
                end,
            },
        },
    },
}
