--- @diagnostic disable-next-line:deprecated
local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients

--- @param line string?
--- @param index integer
--- @param encoding string
--- @return integer
local function str_utfindex(line, index, encoding)
    if not line or #line < index then
        return index
    end

    if encoding == "utf-8" then
        return index
    end

    encoding = encoding or "utf-16"

    if encoding == "utf-16" or encoding == "utf-32" then
        local col32, col16 = vim.str_utfindex(line, index)
        return encoding == "utf-32" and col32 or col16
    end

    error("Invalid encoding: " .. vim.inspect(encoding))
end

--- @param bufnr integer
--- @param method string
--- @param params_fn fun(client: lsp.Client): table
--- @param handler fun(results: any[])
local function buf_request_all(bufnr, method, params_fn, handler)
    local results = {}
    local exp_reponses = 0
    local responses = 0

    for _, client in pairs(get_clients({ bufnr = bufnr })) do
        if client.supports_method(method, { bufnr = bufnr }) then
            exp_reponses = exp_reponses + 1
            client.request(method, params_fn(client), function(_, result)
                responses = responses + 1
                results[client] = result
                if responses >= exp_reponses then
                    handler(results)
                end
            end, bufnr)
        end
    end
end

--- @param bufnr integer
--- @param row integer
--- @param col integer
--- @return fun(client: lsp.Client): table
local function create_params(bufnr, row, col)
    return function(client)
        local offset_encoding = client.offset_encoding
        local ok, lines =
            pcall(vim.api.nvim_buf_get_lines, bufnr, row, row + 1, true)

        if not ok then
            print(
                debug.traceback(
                    string.format(
                        "ERROR: row %d is out of range: %s",
                        row,
                        lines
                    )
                )
            )
        end

        local ccol = lines and str_utfindex(lines[1], col, offset_encoding)
            or col

        return {
            textDocument = { uri = vim.uri_from_bufnr(bufnr) },
            position = {
                line = row,
                character = ccol,
            },
        }
    end
end

require("hover").register({
    name = "LSPSaga Hover Doc",
    priority = 1000,
    enabled = function(bufnr)
        for _, client in pairs(get_clients()) do
            if
                client.supports_method("textDocument/hover", { bufnr = bufnr })
            then
                return true
            end
        end
        return false
    end,
    execute = function()
        vim.cmd("Lspsaga hover_doc")
    end,
})
