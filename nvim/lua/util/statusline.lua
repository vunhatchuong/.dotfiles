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
    local space_pat = [[\v^ +]]
    local tab_pat = [[\v^\t+]]
    local space_indent = vim.fn.search(space_pat, "nwc")
    local tab_indent = vim.fn.search(tab_pat, "nwc")
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
        return "MI:" .. mixed_same_line
    end
    local space_indent_cnt =
        vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
    local tab_indent_cnt =
        vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
    if space_indent_cnt > tab_indent_cnt then
        return "MI:" .. tab_indent
    else
        return "MI:" .. space_indent
    end
end

return M
