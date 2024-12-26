-- Don't show errors on another split
vim.g.zig_fmt_parse_errors = 0

vim.keymap.set({ "n", "x", "o" }, "<C-/>", "gcc", { remap = true })
