return {
    "kylechui/nvim-surround",
    keys = {
        { "ys", desc = "󰅪 Add Surround Operator" },
        { "S", mode = "x", desc = "󰅪 Add Surround Operator" },
        { "ds", desc = "󰅪 Delete Surround Operator" },
        { "cs", desc = "󰅪 Change Surround Operator" },
    },
    opts = {
        move_cursor = false,
        keymaps = {
            visual = "S",
            normal_line = false,
            normal_cur_line = false,
            visual_line = false,
            insert_line = false,
            insert = false,
        },
    },
    config = function(_, opts)
        require("nvim-surround").setup(opts)
    end,
}
