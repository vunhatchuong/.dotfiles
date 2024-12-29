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

--- Returns a custom name of the mode
--- https://github.com/sschleemilch/slimline.nvim/blob/main/lua/slimline/utils.lua
---
---@return string name The custom name
function M.get_mode()
    -- Note that: \19 = ^S and \22 = ^V.
    local mode_map = {
        ["n"] = "NORMAL",
        ["no"] = "OP-PENDING",
        ["nov"] = "OP-PENDING",
        ["noV"] = "OP-PENDING",
        ["no\22"] = "OP-PENDING",
        ["niI"] = "NORMAL",
        ["niR"] = "NORMAL",
        ["niV"] = "NORMAL",
        ["nt"] = "NORMAL",
        ["ntT"] = "NORMAL",
        ["v"] = "VISUAL",
        ["vs"] = "VISUAL",
        ["V"] = "VISUAL",
        ["Vs"] = "VISUAL",
        ["\22"] = "VISUAL",
        ["\22s"] = "VISUAL",
        ["s"] = "SELECT",
        ["S"] = "SELECT",
        ["\19"] = "SELECT",
        ["i"] = "INSERT",
        ["ic"] = "INSERT",
        ["ix"] = "INSERT",
        ["R"] = "REPLACE",
        ["Rc"] = "REPLACE",
        ["Rx"] = "REPLACE",
        ["Rv"] = "VIRT REPLACE",
        ["Rvc"] = "VIRT REPLACE",
        ["Rvx"] = "VIRT REPLACE",
        ["c"] = "COMMAND",
        ["cv"] = "VIM EX",
        ["ce"] = "EX",
        ["r"] = "PROMPT",
        ["rm"] = "MORE",
        ["r?"] = "CONFIRM",
        ["!"] = "SHELL",
        ["t"] = "TERMINAL",
    }

    local mode = mode_map[vim.api.nvim_get_mode().mode] or "UNKNOWN"
    return mode
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
