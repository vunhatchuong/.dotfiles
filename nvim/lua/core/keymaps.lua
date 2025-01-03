local keymap = vim.keymap.set
local del = vim.keymap.del
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
keymap("x", "m", "<nop>", opts)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<leader>e", vim.cmd.Ex)
keymap({ "i", "n" }, "<Esc>", "<CMD>noh<CR><Esc>", { desc = "Escape and Clear hlsearch" })
keymap("n", "<leader>w", "<CMD>w<CR>", { desc = "Save", noremap = true, silent = true })
keymap("n", "<leader>q", "<CMD>q<CR>", { desc = "Quit", noremap = true, silent = true })

keymap("n", "c", '"_c', opts)
keymap("n", "C", '"_C', opts)
keymap("n", "x", '"_x', opts)
keymap("n", "zo", "za", opts)
keymap("v", "p", '"_dP', opts)

keymap("n", "U", "<C-r>")  -- Redo with U
keymap("i", "<C-v>", "<C-r>+") -- Paste with C-v from Insert

-- buffers
keymap("n", "[b", "<CMD>bprev<CR>", { desc = "Prev buffer" })
keymap("n", "]b", "<CMD>bnext<CR>", { desc = "Next buffer" })
-- quickfix
keymap("n", "[q", "<CMD>cprev<CR>", { desc = "Prev qf item" })
keymap("n", "]q", "<CMD>cnext<CR>", { desc = "Next qf item" })

-- n always search forward and N backward
keymap("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
keymap({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
keymap({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

keymap({ "n", "x", "o" }, "<C-_>", "<C-/>", { remap = true })
keymap({ "n", "x", "o" }, "<C-/>", "gcc", { remap = true })

-- Move to first, last line
keymap({ "n", "o", "x" }, "$", "^", opts)
keymap({ "n", "o", "x" }, "0", "g_", opts)

-- Centers cursor
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("t", "<C-\\>", "<CMD>close<CR>", { desc = "Hide Terminal" })
-- keymap("t", "<Esc><Esc>", "<CMD>close<CR>", { desc = "Hide Terminal", noremap = true })

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

-- Others --
keymap("v", "<leader>s", [[:s///gI<Left><Left><Left><Left>]], { desc = "Replace in Visual" })
-- Tmux sessionizer
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux sessionizer" })

-- Disable default LSP mappings
pcall(del, "n", "grn")
pcall(del, "n", "gra")
pcall(del, "n", "grr")
pcall(del, "n", "gri")
