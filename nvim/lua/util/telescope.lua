---@class util.telescope
local M = {}

-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/init.lua#L101

---@type table<string, string[]|boolean>?
M.kind_filter = {
    default = {
        "Class",
        "Constructor",
        "Enum",
        "Field",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Namespace",
        "Package",
        "Property",
        "Struct",
        "Trait",
    },
    markdown = false,
    help = false,
    -- you can specify a different filter for each filetype
    lua = {
        "Class",
        "Constructor",
        "Enum",
        "Field",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Namespace",
        -- "Package", -- remove package since luals uses it for control flow structures
        "Property",
        "Struct",
        "Trait",
    },
}

---@param buf? number
---@return string[]?
function M.get_kind_filter(buf)
    buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
    local ft = vim.bo[buf].filetype
    if M.kind_filter == false then
        return
    end
    if M.kind_filter[ft] == false then
        return
    end
    if type(M.kind_filter[ft]) == "table" then
        return M.kind_filter[ft]
    end
    ---@diagnostic disable-next-line: return-type-mismatch
    return type(M.kind_filter) == "table"
            and type(M.kind_filter.default) == "table"
            and M.kind_filter.default
        or nil
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
        path = clients[1].config.root_dir and clients[1].config.root_dir or path
        prompt_title = clients[1].name
    elseif Snacks.git.get_root() then
        path = Snacks.git.get_root()
        prompt_title = "Git root"
    end

    return path, prompt_title
end

--- Find and use the appropriate find command
--- Stole from: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/telescope.lua#L177
--- Same as default but ignore .git: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/telescope.lua#L177
--- Unfortunately no way to whitelist .env file when ignore .gitignore: https://github.com/BurntSushi/ripgrep/discussions/2428
---
-- stylua: ignore
---@return table command The find command
function M.find_command()
    if 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
    elseif 1 == vim.fn.executable("rg") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
    elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
    elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
    elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
    end
end

return M
