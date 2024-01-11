local size = function()
    return vim.o.columns * 0.5
end

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        open_mapping = [[<leader><cr>]],
        direction = "float",
        float_opts = {
            border = "rounded",
            winblend = 0,
        },
    },
    keys = {
        {
            "<leader><CR>",
            "<cmd>ToggleTerm size=" .. size() .. "<cr>",
            desc = "Toggle Terminal",
            mode = "n",
        },
        {
            "<leader><CR>",
            "<cmd>ToggleTerm<cr>",
            desc = "Toggle Terminal",
            mode = "t",
        },
    },
}
