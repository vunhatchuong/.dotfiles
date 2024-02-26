return { -- when searching, search count is shown next to the cursor
    "kevinhwang91/nvim-hlslens",
    keys = {
        {
            "n",
            "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
            desc = "Increment",
        },
        {
            "N",
            "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
            desc = "Decrement",
        },
    },
    opts = {
        calm_down = true,
        nearest_only = true,
    },
}
