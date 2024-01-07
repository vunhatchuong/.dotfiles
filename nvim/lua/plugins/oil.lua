return {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup(
            {
                skip_confirm_for_simple_edits = true,
                -- Set to `false` to remove a keymap
                -- See :help oil-actions for a list of all available actions

                keymaps = {
                    ["l"] = "actions.select",
                    ["h"] = "actions.parent",
                    ["<C-s>"] = false,
                    ["<C-h>"] = false,
                    ["<C-t>"] = false,
                    ["<C-p>"] = "actions.preview",
                    ["q"] = "actions.close",
                    ["<C-l>"] = "actions.refresh",
                    ["_"] = "actions.open_cwd",
                    ["gs"] = false,
                    ["ge"] = "actions.open_external", -- If use WSL: https://github.com/wslutilities/wslu
                    ["."] = "actions.toggle_hidden"
                },
                view_options = {
                    show_hidden = true
                }
            }
        )
        vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
}

