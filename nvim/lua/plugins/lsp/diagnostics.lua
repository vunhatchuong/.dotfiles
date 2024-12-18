local icons = require("core.icons")
local signs = {
    [vim.diagnostic.severity.ERROR] = icons.diagnostics.BoldError,
    [vim.diagnostic.severity.WARN] = icons.diagnostics.BoldWarning,
    [vim.diagnostic.severity.HINT] = icons.diagnostics.BoldHint,
    [vim.diagnostic.severity.INFO] = icons.diagnostics.BoldInformation,
}

-- options for vim.diagnostic.config()
--- @type vim.diagnostic.Opts
local config = {
    update_in_insert = false,
    virtual_text = false,
    severity_sort = true,
    float = { border = vim.g.bordor_style },
    signs = { text = signs },
}

vim.diagnostic.config(vim.deepcopy(config))
vim.lsp.diagnostics_config = config
