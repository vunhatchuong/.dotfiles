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
keymap("n", "Q", "<Nop>", opts)
keymap("n", "<C-c>", "<Nop>", opts)
keymap("x", "m", "<Nop>", opts)
keymap("n", "<C-i>", "<Tab>")
keymap("i", "<C-n>", "<Nop>", { desc = "Disable default cmp menu" })

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<leader>e", vim.cmd.Ex)
keymap(
    "n",
    "<leader>w",
    "<CMD>w<CR>",
    { desc = "Save", noremap = true, silent = true }
)
keymap("n", "<leader>q", function()
    if Snacks.zen.win then
        Snacks.zen()
        vim.cmd("q")
        return
    end
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].filetype == "focus-bg" then
            local ok, focus = pcall(require, "focus")
            if ok and focus then
                focus.toggle({})
                break
            end
        end
    end

    vim.cmd("q")
end, { desc = "Quit", noremap = true, silent = true })

keymap("n", "c", '"_c', opts)
keymap("n", "C", '"_C', opts)
keymap("n", "x", '"_x', opts)
keymap("n", "zo", "za", opts)
keymap("v", "p", '"_dP', opts)

keymap("n", "U", "<C-r>")
keymap("i", "<C-p>", "<C-r>+", { desc = "Paste in insert mode" })
keymap("i", "<C-v>", "<C-r>+")

-- n always search forward and N backward
keymap("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true })
keymap({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true })
keymap("n", "N", "'nN'[v:searchforward].'zv'", { expr = true })
keymap({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true })

keymap({ "n", "x", "i" }, "<C-_>", "<C-/>", { remap = true })
keymap("n", "<C-/>", "gcc", { remap = true })
keymap("x", "<C-/>", "gc", { remap = true })
keymap("i", "<C-/>", function()
    vim.cmd.normal("gcc")
end, { remap = true })

-- Move to first, last line
keymap({ "n", "o", "x" }, "$", "^", opts)
keymap({ "n", "o", "x" }, "0", "g_", opts)
keymap({ "n", "o", "x" }, "H", "^", opts)
keymap({ "n", "o", "x" }, "L", "$", opts)

-- Centers cursor
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("t", "<C-\\>", "<CMD>close<CR>", { desc = "Hide Terminal" })
keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
-- keymap("t", "<Esc><Esc>", "<CMD>close<CR>", { desc = "Hide Terminal", noremap = true })

keymap("n", "dd", function()
    if vim.api.nvim_get_current_line():match("^%s*$") then
        return '"_dd'
    else
        return "dd"
    end
end, { noremap = true, expr = true })

keymap("x", "<leader>ym", function()
    local ft = vim.bo.filetype or ""
    local selection = Util.get_visual_selection_text()

    local markdown = string.format("```%s\n%s```", ft, selection)
    vim.fn.setreg("+", markdown)
end, { desc = "Yank selection as markdown code block" })

-- Others --
-- keymap("v", "<leader>s", [[:s///gI<Left><Left><Left><Left>]], { desc = "Replace in Visual" })
-- Tmux sessionizer
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Disable default mappings
pcall(del, "n", "grn")
pcall(del, "n", "grr")
pcall(del, "n", "gri")
pcall(del, { "n", "v" }, "gra")
pcall(del, "n", "<C-S>")
