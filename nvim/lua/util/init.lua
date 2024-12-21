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

--- Retrieves the folder location for the given buffer.
--- If an LSP client is active, it uses the LSP root directory.
--- If a Git root is found, it uses the Git root.
--- Otherwise, it defaults to the current working directory.
---
---@return string path The resolved folder path.
---@return string prompt_title A title describing the source of the path.
function M.get_folder_location()
    local clients = vim.lsp.get_clients()

    local path = vim.fn.getcwd()
    local prompt_title = "Default"

    if #clients > 0 then
        for _, client in pairs(clients) do
            if client.name ~= "null-ls" then
                path = client.config.root_dir and client.config.root_dir or path
                prompt_title = client.name
                break
            end
        end
    elseif vim.fs.root(0, { ".git" }) ~= nil then
        path = vim.fs.root(0, { ".git" })
        prompt_title = "Git root"
    else
    end

    return path, prompt_title
end

return M
