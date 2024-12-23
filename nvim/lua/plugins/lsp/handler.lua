local M = {}

function M.workspace_diagnostics(client, bufnr)
    require("workspace-diagnostics").populate_workspace_diagnostics(
        client,
        bufnr
    )
end

function M.setup() end

return M
