vim.keymap.set(
    "n",
    "<leader>ge",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>",
    { desc = "Insert go err", silent = true }
)
