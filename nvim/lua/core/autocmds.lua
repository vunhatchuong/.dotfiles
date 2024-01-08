local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- General Settings
local general = augroup("General Settings", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {

    pattern = {
        "netrw",
        "help",
        "man",
        "lspinfo",
        "mason",
        "checkhealth",
        "harpoon",
        "lazy",
        "Trouble",
        "oil",
        "TelescopePrompt",
        "",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})
-- Don't auto add comments
autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.cmd "set formatoptions-=cro"
    end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = augroup('YankHighlight', {})

autocmd('TextYankPost', {
    group = highlight_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave", "BufWinEnter" }, {
    pattern = { "*" },
    callback = function()
        vim.cmd "checktime"
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

autocmd("FileType", {
    pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- wrap and check for spell in text filetypes
autocmd("FileType", {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Remove trailing whitespaces
autocmd({ "BufWritePre" }, {
    group = general,
    pattern = "*",
    callback = function()
        -- Replace Ctrl+M (^M)
        vim.cmd([[ %s/]] .. string.char(13) .. [[//ge ]])
        -- Remove trailing whitespaces
        vim.cmd([[ %s/\s\+$//e ]])
    end,
})

vim.cmd [[
command! -nargs=0 Slinefeed :%s/\r//g
command! -nargs=0 Slinefeed :s/^M$//:
command! -nargs=0 AddCarriage :%s/\r/\r/g
]]

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
