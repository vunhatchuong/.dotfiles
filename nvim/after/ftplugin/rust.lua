local bufnr = vim.api.nvim_get_current_buf()
local function desc(description)
    return { noremap = true, silent = true, buffer = bufnr, desc = description }
end

vim.keymap.set("v", "K", function()
    vim.cmd.RustLsp({ "hover", "range" })
end, desc("rust: hover range"))
vim.keymap.set("n", "K", function()
    vim.cmd.RustLsp({ "hover", "actions" })
end, desc("rust: hover range"))

vim.keymap.set("n", "<leader>ca", function()
    vim.cmd.RustLsp("codeAction")
end, desc("rust: code action"))

vim.keymap.set("n", "<C-k>", function()
    vim.cmd.RustLsp({ "renderDiagnostic", "current" })
end, desc("rust: [r]ender [d]iagnostic"))
