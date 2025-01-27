---@class util
---@field finder util.finder
---@field lazy util.lazy
---@field statusline util.statusline
---@field tool_installer util.tool_installer
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
            if client.name ~= "typos_lsp" and client.name ~= "null-ls" then
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

-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/builtin/__files.lua#L192
-- https://github.com/Wansmer/nvim-config/blob/main/lua/utils.lua#L92
--- Get the visual selection
---
--- @return string? selection The string from visual selection
function M.get_visual_selection()
    local saved_reg = vim.fn.getreg("v") -- Change to '"' register if doesn't work
    vim.cmd([[noautocmd sil norm "vy]])
    local selection = vim.fn.getreg("v")
    vim.fn.setreg("v", saved_reg)

    if selection == "" then
        vim.notify("Nothing selected!")
        return
    end

    return selection
end

return M
