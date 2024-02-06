local h = require("null-ls.helpers")
local log = require("null-ls.logger")
local methods = require("null-ls.methods")
local u = require("null-ls.utils")

local CODE_ACTION = methods.internal.CODE_ACTION

local treesitter_get_node_text = vim.treesitter.get_node_text

return h.make_builtin({
    name = "gotests",
    meta = {
        url = "https://github.com/cweill/gotests",
        description = "Generate Go tests",
    },
    method = CODE_ACTION,
    filetypes = { "go" },
    can_run = function()
        return u.is_executable("gotests")
    end,
    generator_opts = {
        command = "gotests",
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
                local exec = function(func_name)
                    local cmd_opts = vim.list_extend(
                        { opts.command },
                        opts.args or {} -- customizable common args
                    )
                    local file = vim.fn.expand("%")
                    if func_name == "all" then
                        vim.list_extend(cmd_opts, { "-w", "-all", file })
                    else
                        vim.list_extend(
                            cmd_opts,
                            { "-w", "-only", func_name, file }
                        )
                    end

                    local cmd = table.concat(cmd_opts, " ")
                    local output = vim.fn.system(cmd)

                    if vim.api.nvim_get_vvar("shell_error") ~= 0 then
                        log:error(output)
                    end
                end
                local generate_all_tests = function()
                    return {
                        title = "gotests: generate all tests",
                        action = function()
                            exec("all")
                        end,
                    }
                end
                local generate_tests = function(func_name)
                    return {
                        title = "gotests: generate tests",
                        action = function()
                            exec(func_name)
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

                table.insert(actions, generate_all_tests())
                if (tsnode:type()) == "identifier" then
                    func_name = treesitter_get_node_text(tsnode, 0)
                    if func_name == nil then
                        return
                    end

                    table.insert(actions, generate_tests(func_name))
                    return actions
                end
            end,
        }
    end,
})
