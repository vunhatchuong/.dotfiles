return {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
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
            ["_"] = false,
            ["`"] = false,
            ["~"] = false,
            ["gs"] = false,
            ["ge"] = "actions.open_external",
            ["."] = "actions.toggle_hidden",
        },
        view_options = {
            show_hidden = true,
        },
        win_options = {
            number = false,
            relativenumber = false,
        },
    },
    config = function(_, opts)
        vim.keymap.set(
            "n",
            "<leader>e",
            "<CMD>Oil<CR>",
            { desc = "Open parent directory" }
        )
        require("oil").setup(opts)
    end,
}
