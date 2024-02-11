local h = require("null-ls.helpers")
local log = require("null-ls.logger")
local methods = require("null-ls.methods")
local u = require("null-ls.utils")
local vfn = vim.fn

local CODE_ACTION = methods.internal.CODE_ACTION

local treesitter_get_node_text = vim.treesitter.get_node_text

return h.make_builtin({
    name = "iferr",
    meta = {
        url = "https://github.com/koron/iferr",
        description = "Generate If err block",
    },
    method = CODE_ACTION,
    filetypes = { "go" },
    can_run = function()
        return u.is_executable("iferr")
    end,
    generator_opts = {
        command = "iferr",
        args = { "" },
    },
    factory = function(opts)
        return {
            fn = function(params)
                -- Global vars
                local bufnr = params.bufnr
                local row = params.range.row
                local col = params.range.col

                -- Execution helpers
                local exec = function(cursor_bytes)
                    local cmd_opts = vim.list_extend(
                        { opts.command },
                        opts.args or {} -- customizable common args
                    )

                    local cursor_pos = tostring(cursor_bytes)
                    vim.list_extend(cmd_opts, { "-pos", cursor_pos })
                    local cmd = table.concat(cmd_opts, " ")

                    local data = vfn.systemlist(cmd, bufnr)

                    if vim.api.nvim_get_vvar("shell_error") ~= 0 then
                        log:error(data)
                    end
                    local pos = vfn.getcurpos()[2]
                    vfn.append(pos, data)
                    vim.cmd("silent normal! j=2j")
                    vfn.setpos(".", pos)
                    vim.cmd("silent normal! 4j")
                end
                local generate_iferr = function(cursor_bytes)
                    return {
                        title = "iferr: generate If err block",
                        action = function()
                            exec(cursor_bytes)
                        end,
                    }
                end
                -- End of Execution helpers

                -- Main
                local tsnode = vim.treesitter.get_node({
                    bufnr = bufnr,
                    row = row - 1,
                    col = col - 1,
                })
                local actions = {}
                local func_name

                if tsnode == nil then
                    return actions
                end

                if (tsnode:type()) == "identifier" then
                    func_name = treesitter_get_node_text(tsnode, 0)
                    if func_name == nil then
                        return
                    end

                    local byte_offset = vfn.wordcount().cursor_bytes
                    table.insert(actions, generate_iferr(byte_offset))
                    return actions
                end
            end,
        }
    end,
})
