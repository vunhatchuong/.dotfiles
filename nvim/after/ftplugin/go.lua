vim.keymap.set(
    "n",
    "<leader>ge",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>",
    { silent = true }
)
