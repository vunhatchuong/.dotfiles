-- 1:1 copy from: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/dial.lua
local M = {}

---@param increment boolean
---@param g? boolean
function M.dial(increment, g)
    local mode = vim.fn.mode(true)
    -- Use visual commands for VISUAL 'v', VISUAL LINE 'V' and VISUAL BLOCK '\22'
    local is_visual = mode == "v" or mode == "V" or mode == "\22"
    local func = (increment and "inc" or "dec")
        .. (g and "_g" or "_")
        .. (is_visual and "visual" or "normal")
    local group = vim.g.dials_by_ft[vim.bo.filetype] or "default"
    return require("dial.map")[func](group)
end

return {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
        { "<C-a>", function() return M.dial(true) end, expr = true, desc = "Increment", mode = {"n", "v"} },
        { "<C-x>", function() return M.dial(false) end, expr = true, desc = "Decrement", mode = {"n", "v"} },
    },
    opts = function()
        local augend = require("dial.augend")

        local logical_alias = augend.constant.new({
            elements = { "&&", "||" },
            word = false,
        })

        local ordinal_numbers = augend.constant.new({
            elements = {
                "first",
                "second",
                "third",
                "fourth",
                "fifth",
                "sixth",
                "seventh",
                "eighth",
                "ninth",
                "tenth",
            },
            word = false, -- Makes 'firstDate' work
        })

        local weekdays = augend.constant.new({
            elements = {
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday",
                "Sunday",
            },
        })

        local months = augend.constant.new({
            elements = {
                "January",
                "February",
                "March",
                "April",
                "May",
                "June",
                "July",
                "August",
                "September",
                "October",
                "November",
                "December",
            },
        })

        return {
            dials_by_ft = {
                lua = "lua",
                markdown = "markdown",
                json = "json",
                python = "python",
                css = "css",
                sass = "css",
                scss = "css",
                javascript = "typescript",
                typescript = "typescript",
                javascriptreact = "typescript",
                typescriptreact = "typescript",
                vue = "vue",
            },
            groups = {
                default = {
                    augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
                    augend.integer.alias.decimal_int, -- non(negative) decimal number
                    augend.date.alias["%Y/%m/%d"],
                    augend.date.alias["%Y-%m-%d"],
                    augend.date.alias["%m/%d"],
                    augend.date.alias["%H:%M"],
                    augend.constant.alias.bool,
                    augend.constant.new({ elements = { "True", "False" } }),
                    augend.constant.new({ elements = { "on", "off" } }),
                    ordinal_numbers,
                    weekdays,
                    months,
                    logical_alias,
                },
                lua = {
                    augend.constant.new({
                        elements = { "and", "or" },
                        word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                        cyclic = true, -- "or" is incremented into "and".
                    }),
                },
                markdown = {
                    augend.constant.new({
                        elements = { "[ ]", "[x]" },
                        word = false,
                        cyclic = true,
                    }),
                    augend.misc.alias.markdown_header,
                },
                json = {
                    augend.semver.alias.semver, -- versioning (v1.1.2)
                },
                python = {
                    augend.constant.new({
                        elements = { "and", "or" },
                    }),
                },
                css = {
                    augend.hexcolor.new({
                        case = "lower",
                    }),
                    augend.hexcolor.new({
                        case = "upper",
                    }),
                },
                typescript = {
                    augend.constant.new({ elements = { "let", "const" } }),
                },
                vue = {
                    augend.constant.new({ elements = { "let", "const" } }),
                    augend.hexcolor.new({ case = "lower" }),
                    augend.hexcolor.new({ case = "upper" }),
                },
            },
        }
    end,
    config = function(_, opts)
        -- copy defaults to each group
        for name, group in pairs(opts.groups) do
            if name ~= "default" then
                vim.list_extend(group, opts.groups.default)
            end
        end
        require("dial.config").augends:register_group(opts.groups)
        vim.g.dials_by_ft = opts.dials_by_ft
    end,
}
