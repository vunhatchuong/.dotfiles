return {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    opts = {
        scope = "line",
        show_borders = true,
        format = function(diagnostic)
            return diagnostic.message
        end,
    },
}

-- return {
--     "RaafatTurki/corn.nvim",
--     event = "LspAttach",
--     opts = {
--         border_style = "rounded",
--         on_toggle = function(is_hidden)
--             vim.diagnostic.config({
--                 virtual_text = not vim.diagnostic.config().virtual_text,
--             })
--         end,
--         item_preprocess_func = function(item)
--             return item
--         end,
--     },
--     config = function(_, opts)
--         local corn = require("corn")
--         -- ensure virtual_text diags are disabled
--         vim.diagnostic.config({ virtual_text = false })
--         corn.setup(opts)
--     end,
-- }
