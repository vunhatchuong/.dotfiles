local opt = vim.opt

---@class util.statusline
local M = {}

function M.indent_status()
    if not opt.expandtab:get() then
        return "Tab:" .. opt.tabstop:get() .. " "
    else
        local size = opt.shiftwidth:get()
        if size == 0 then
            size = opt.tabstop:get()
        end
        return "Spc:" .. size .. " "
    end
end

function M.mixed_indent()
    local space_pattern = [[\v^ +]]
    local tab_pattern = [[\v^\t+]]

    local space_indent = vim.fn.search(space_pattern, "nwc")
    local tab_indent = vim.fn.search(tab_pattern, "nwc")

    local mixed = (space_indent > 0 and tab_indent > 0)

    local mixed_same_line
    if not mixed then
        mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], "nwc")
        mixed = mixed_same_line > 0
    end

    if not mixed then
        return M.indent_status()
    end

    if mixed_same_line ~= nil and mixed_same_line > 0 then
        return "Mix:" .. mixed_same_line
    end

    local space_indent_cnt =
        vim.fn.searchcount({ pattern = space_pattern, max_count = 1e3 }).total
    local tab_indent_cnt =
        vim.fn.searchcount({ pattern = tab_pattern, max_count = 1e3 }).total

    if space_indent_cnt > tab_indent_cnt then
        return "Mix:" .. tab_indent
    end

    return "Mix:" .. space_indent
end

-- https://github.com/dgox16/dotfiles/blob/main/.config/nvim/lua/configs/lualine.lua#L92
function M.get_lsp_names()
    local bufnr = vim.api.nvim_get_current_buf()
    local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })
    if next(buf_clients) == nil then
        return "No servers"
    end

    local buf_client_names = {}
    for _, client in pairs(buf_clients) do
        if client.name ~= "typos_lsp" and client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

    local hash = {}
    local unique_client_names = {}

    for _, v in ipairs(buf_client_names) do
        if not hash[v] then
            unique_client_names[#unique_client_names + 1] = v
            hash[v] = true
        end
    end
    local language_servers = table.concat(unique_client_names, ", ")

    return language_servers
end

-- Credits to https://github.com/chrisgrieser/.config/blob/main/nvim/lua/plugins/lualine.lua#L4
local progress_text = ""
function M.lsp_progress()
    vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(ctx)
            ---@type {percentage: number, title?: string, kind: string, message?: string}
            local progress = ctx.data.params.value
            if not (progress and progress.title) then
                return
            end

            local icons = require("core.icons").misc.snipper_circle

            local idx = math.floor(#icons / 2)
            if progress.percentage == 0 then
                idx = 1
            end

            if progress.percentage and progress.percentage > 0 then
                idx = math.ceil(progress.percentage / 100 * #icons)
            end
            local firstWord = vim.split(progress.title, " ")[1]:lower()

            local lsp_names = table.concat({ icons[idx], firstWord }, " ")
            progress_text = progress.kind == "end" and "" or lsp_names
        end,
    })
    return progress_text
end

--- Returns a custom name of the mode
--- https://github.com/sschleemilch/slimline.nvim/blob/main/lua/slimline/utils.lua
---
---@return string name The custom name
function M.get_mode()
    local mode_map = {
        n = "NORMAL",
        i = "INSERT",
        v = "VISUAL",
        [""] = "VISUAL",
        V = "VISUAL",
        no = "OP-PENDING",
        s = "SELECT",
        S = "SELECT",
        [""] = "SELECT",
        ic = "INSERT",
        R = "REPLACE",
        Rv = "VIRT REPLACE",
        c = "COMMAND",
        cv = "VIM EX",
        ce = "EX",
        r = "PROMPT",
        rm = "MORE",
        ["r?"] = "CONFIRM",
        ["!"] = "SHELL",
        t = "TERMINAL",
    }
    -- https://github.com/rachartier/dotfiles/blob/main/.config/nvim/lua/plugins/ui/lualine.lua
    local kirby_default = "(>*-*)>"
    local mode_kirby = {
        n = "<(•ᴗ•)>",
        i = "<(•o•)>",
        v = "(v•-•)v",
        [""] = "(v•-•)>",
        V = "(>•-•)>",
        no = "<(•ᴗ•)>",
        s = kirby_default,
        S = kirby_default,
        [""] = kirby_default,
        ic = kirby_default,
        R = kirby_default,
        Rv = kirby_default,
        c = kirby_default,
        cv = "<(•ᴗ•)>",
        ce = "<(•ᴗ•)>",
        r = kirby_default,
        rm = kirby_default,
        ["r?"] = kirby_default,
        ["!"] = "<(•ᴗ•)>",
        t = "<(•ᴗ•)>",
    }

    return mode_kirby[vim.fn.mode()] or vim.api.nvim_get_mode().mode
end

--- Takes in a :highlight group name and return the foreground value
---
---@param group string The highlight group
---@return string fg The foreground value
function M.get_hl_color(group)
    local hl = vim.api.nvim_get_hl(0, { name = group })

    if hl.link then
        return M.get_hl_color(hl.link)
    end

    local fg = hl.fg and string.format("#%06x", hl.fg) or "none"

    return fg
end

return M
