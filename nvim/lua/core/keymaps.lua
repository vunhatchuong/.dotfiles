local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Netrw
keymap("n", "<leader>e", vim.cmd.Ex)
keymap("n", "Q", "<nop>")

-- Normal --
keymap("n", "<Esc>", ":nohl<cr>", opts)
keymap("n", "<leader>w", ":w<cr>", opts)
keymap("n", "<leader>q", ":q<cr>", opts)
keymap("n", "c", '"_c', opts)
keymap("n", "C", '"_C', opts)
keymap("n", "x", '"_x', opts)
keymap("n", "zo", "za", opts)

keymap({ "n", "x", "o" }, "<C-_>", "gcc", { remap = true })

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move to first, last line
keymap({ "n", "o", "x" }, "$", "^", opts)
keymap({ "n", "o", "x" }, "0", "g_", opts)

-- Centers cursor
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Move text up and down
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("n", "<A-j>", ":m .+1<CR>==", opts)

-- Append line below to current line and keep cursor position
keymap("n", "J", "mzJ`z", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move line up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<leader>p", [["_dP]], opts)

-- Others --
-- Replace the word that cursor is on
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Tmux sessionizer
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap(
    "n",
    "<leader>ge",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>",
    { silent = true }
)

-- windows
keymap("n", "<leader>ww", "<C-W>w", opts)
keymap("n", "<leader>wq", "<C-W>c", opts)
keymap("n", "<leader>-", "<C-W>s", opts)
keymap("n", "<leader>|", "<C-W>v", opts)

-- Smart dd: https://www.reddit.com/r/neovim/comments/w0jzzv/comment/igfjx5y/
keymap("n", "dd", function()
    if vim.api.nvim_get_current_line():match("^%s*$") then
        return '"_dd'
    else
        return "dd"
    end
end, { noremap = true, expr = true })
