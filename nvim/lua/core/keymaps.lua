local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap("", "<Space>", "<Nop>", opts)
keymap("n", "Q", "<nop>", opts)
keymap("n", "<C-c>", "<nop>", opts)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Netrw
keymap("n", "<leader>e", vim.cmd.Ex)

-- Normal --
keymap({ "i", "n" }, "<Esc>", "<CMD>noh<CR><Esc>", { desc = "Escape and Clear hlsearch" })
keymap("n", "<leader>w", ":w<cr>", { desc = "Save", noremap = true, silent = true })
keymap("n", "<leader>q", ":q<cr>", { desc = "Quit", noremap = true, silent = true })
keymap("n", "c", '"_c', opts)
keymap("n", "C", '"_C', opts)
keymap("n", "x", '"_x', opts)
keymap("n", "zo", "za", opts)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- n always search forward and N backward
keymap("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
keymap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
keymap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
keymap("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

if
    vim.fn.has("win32") == 1
    or vim.fn.has("win64") == 1
    or vim.fn.has("wsl") == 1
then
    keymap({ "n", "x", "o" }, "<C-_>", "gcc", { remap = true })
else
    keymap({ "n", "x", "o" }, "<C-/>", "gcc", { remap = true })
end

-- Remap for dealing with word wrap
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })

-- Move to first, last line
keymap({ "n", "o", "x" }, "$", "^", opts)
keymap({ "n", "o", "x" }, "0", "g_", opts)

-- Centers cursor
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "p", '"_dP', opts)

-- Visual Block --
keymap("x", "<leader>p", [["_dP]], { desc = "Replace selected text with previously yanked text", noremap = true })

keymap("t", "<C-\\>", "<CMD>close<CR>", { desc = "Hide Terminal" })
-- keymap("t", "<Esc><Esc>", "<CMD>close<CR>", { desc = "Hide Terminal", noremap = true })

-- Others --
keymap("v", "<leader>s", [[:s///gI<Left><Left><Left><Left>]], { desc = "Replace in Visual" })
-- Tmux sessionizer
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux sessionizer" })

-- windows
keymap("n", "<leader>ww", "<C-W>w", { desc = "Switch to the next window", remap = true })
keymap("n", "<leader>wq", "<C-W>c", { desc = "Close the current window", remap = true })
keymap("n", "<leader>-", "<C-W>s", { desc = "Split window horizontally", remap = true })
keymap("n", "<leader>|", "<C-W>v", { desc = "Split window vertically", remap = true })

keymap("n", "dd", function()
    if vim.api.nvim_get_current_line():match("^%s*$") then
        return '"_dd'
    else
        return "dd"
    end
end, { noremap = true, expr = true })
