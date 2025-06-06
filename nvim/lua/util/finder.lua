---@class util.finder
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

--- fzf-lua version of lsp symbols filter
---
---@return boolean
function M.symbols_filter(entry, ctx)
    if ctx.symbols_filter == nil then
        ctx.symbols_filter = Util.finder.get_kind_filter(ctx.bufnr) or false
    end
    if ctx.symbols_filter == false then
        return true
    end
    return vim.tbl_contains(ctx.symbols_filter, entry.kind)
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

--- Fzf-lua: Retrieves a list of cmds to use for view image
---
---@return string[]? img_previewer List of cmds to preview image
function M.image_previewer()
    local img_previewer ---@type string[]?
    for _, v in ipairs({
        { cmd = "ueberzug", args = {} },
        { cmd = "chafa", args = { "{file}", "--format=symbols" } },
        { cmd = "viu", args = { "-b" } },
    }) do
        if vim.fn.executable(v.cmd) == 1 then
            img_previewer = vim.list_extend({ v.cmd }, v.args)
            break
        end
    end
    return img_previewer
end
return M
