local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd({ "FileType" }, {
    desc = "Close with q",
    pattern = {
        "netrw",
        "help",
        "checkhealth",
        "lspinfo",
        "lazy",
        "mason",
        "grug-far",
        "undotree",
        "quicktest-output",
        "outputpanel",
        "bmessages",
        "snacks_dashboard",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Close buffer",
            })
        end)
    end,
})

autocmd({ "FileType" }, {
    desc = "Quit with q",
    pattern = {
        "oil",
        "snacks_dashboard",
    },
    callback = function(event)
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("quit")
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
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
        (vim.hl or vim.highlight).on_yank({ timeout = 40 })
    end,
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    desc = "Check if we need to reload the file when it changed",
    pattern = { "*" },
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
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
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown", "*.json" },
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
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- autocmd({ "BufWinEnter" }, {
--     desc = "Clear the last used search pattern",
--     pattern = "*",
--     callback = function()
--         vim.api.nvim_feedkeys(
--             vim.api.nvim_replace_termcodes("<Cmd>noh<CR>", true, false, true),
--             "n",
--             false
--         )
--     end,
-- })

autocmd({"InsertEnter", "CmdlineEnter"}, {
    desc = "Remove hl search when enter Insert",
    callback = vim.schedule_wrap(function()
        vim.cmd.nohlsearch()
    end),
})

autocmd("ColorScheme", {
    group = augroup("OverrideTheme", { clear = true }),
    callback = function()
        -- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
        -- https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/native_lsp.lua
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
})
