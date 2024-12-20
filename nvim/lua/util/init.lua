---@class util
---@field finder util.finder
---@field statusline util.statusline
---@field worktree util.worktree
local M = {}

setmetatable(M, {
    __index = function(t, k)
        t[k] = require("util." .. k)
        return t[k]
    end,
})

---@return boolean
function M.is_win()
    return vim.uv.os_uname().sysname:find("Windows") ~= nil
end

return M
