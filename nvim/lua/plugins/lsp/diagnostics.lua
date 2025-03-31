local icons = require("core.icons")

local signs = {
    [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
    [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
    [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
    [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
}

local M = {}

--- @type vim.diagnostic.Opts
local config = {
    update_in_insert = false,
    virtual_text = false,
    severity_sort = true,
    float = {},
    signs = { text = signs },
}

function M.setup()
    vim.diagnostic.config(config)
    vim.lsp.diagnostics_config = config
end

return M
