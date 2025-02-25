return {
    {
        "echasnovski/mini.diff",
        keys = {
            {
                "<leader>hh",
                function()
                    require("mini.diff").enable(0)
                    require("mini.diff").toggle_overlay(0)
                end,
            },
        },
        opts = {
            mappings = {
                apply = "",
                reset = "",
                textobject = "",
            },
            options = { wrap_goto = true },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        enabled = false,
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {
            update_debounce = 3000,
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                -- stylua: ignore start
                map("n", "<leader>hh", gs.preview_hunk, "Preview Hunk Inline")

                map("n", "]h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gs.nav_hunk("next", { wrap = true, navigation_message = false })
                    end
                end, "Next Hunk")
                map("n", "[h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev", { wrap = true, navigation_message = false })
                    end
                end, "Prev Hunk")

                map("n", "<leader>hn", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gs.nav_hunk("next", { wrap = true, navigation_message = false })
                    end
                end, "Next Hunk")
                map("n", "<leader>hp", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev", { wrap = true, navigation_message = false })
                    end
                end, "Prev Hunk")

                map("n", "<leader>hb", function() gs.blame_line() end, "Blame Line")
                map("n", "<leader>hB", function() gs.blame() end, "Blame Buffer")
            end,
        },
    },
    {
        "akinsho/git-conflict.nvim",
        -- event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        cmd = "GitConflictRefresh",
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
                "<Cmd>DiffviewFileHistory<CR>",
                mode = "n",
                desc = "diffview: File history",
            },
            {
                "<leader>hf",
                [[:'<'>DiffviewFileHistory<CR>]],
                mode = "v",
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
            view = {
                default = {
                    -- layout = "diff1_inline",
                    disable_diagnostics = true,
                },
                merge_tool = { layout = "diff3_mixed" },
                file_history = {
                    -- layout = "diff1_inline",
                    disable_diagnostics = true,
                },
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
