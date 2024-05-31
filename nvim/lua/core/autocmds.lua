local autocmd = vim.api.nvim_create_autocmd

autocmd({ "FileType" }, {
    desc = "Close with q",
    pattern = {
        "netrw",
        "help",
        "checkhealth",
        "lspinfo",
        "lazy",
        "mason",
        "oil",
        "trouble",
        "harpoon",
        "TelescopePrompt",
        "spectre_panel",
        "undotree",
        "grapple",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set(
            "n",
            "q",
            "<cmd>close<cr>",
            { buffer = event.buf, silent = true }
        )
    end,
})

autocmd({ "BufWinEnter" }, {
    desc = "Don't auto add comments",
    callback = function()
        vim.cmd("set formatoptions-=cro")
    end,
})

autocmd("TextYankPost", {
    desc = "Highlight when yank text",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            timeout = 40,
        })
    end,
})

autocmd({ "FocusGained", "TermClose", "TermLeave", "BufWinEnter" }, {
    desc = "Check if we need to reload the file when it changed",
    pattern = { "*" },
    callback = function()
        vim.cmd("checktime")
    end,
})

autocmd({ "VimResized" }, {
    desc = "Resize splits if window got resized",
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

autocmd("BufReadPost", {
    desc = "Go to last loc when opening a buffer",
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if
            vim.tbl_contains(exclude, vim.bo[buf].filetype)
            or vim.b[buf].lazyvim_last_loc
        then
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
    desc = "Wrap and check for spell in text filetypes",
    pattern = { "gitcommit", "markdown", "*.json" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

autocmd({ "BufWritePre" }, {
    desc = "Remove things when save",
    pattern = "*",
    callback = function()
        -- Remove Ctrl+M (^M)
        vim.cmd([[ %s/]] .. string.char(13) .. [[//ge ]])
        -- Remove trailing whitespaces
        vim.cmd([[ %s/\s\+$//e ]])
    end,
})

autocmd({ "BufWritePre" }, {
    desc = "Auto create dir when save a file",
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

autocmd({ "BufWinEnter" }, {
    desc = "Clear the last used search pattern",
    pattern = "*",
    callback = function()
        vim.cmd([[let @/ = '']])
    end,
})
