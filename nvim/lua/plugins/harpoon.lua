-- return {
--     "ThePrimeagen/harpoon",
--     event = "VeryLazy",
--     branch = "harpoon2",
--     dependencies = { "nvim-lua/plenary.nvim" },
--     config = function()
--         local harpoon = require("harpoon")
--         local keymap = vim.keymap.set
--         local function mark_file()
--             harpoon:list():append()
--             vim.notify("󱡁 Toggle mark")
--         end
--
--         harpoon:setup()
--
--         -- stylua: ignore start
--         keymap("n", "<leader>a", function() mark_file() end)
--         keymap("n", "<TAB>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
--
--         keymap("n", "<leader>1", function() harpoon:list():select(1) end)
--         keymap("n", "<leader>2", function() harpoon:list():select(2) end)
--         keymap("n", "<leader>3", function() harpoon:list():select(3) end)
--         keymap("n", "<leader>4", function() harpoon:list():select(4) end)
--         keymap("n", "<leader>5", function() harpoon:list():select(5) end)
--         -- stylua: ignore end
--     end,
-- }
return {
    "cbochs/grapple.nvim",
    event = "VeryLazy",
    config = function()
        local grapple = require("grapple")
        local keymap = vim.keymap.set
        local function mark_file()
            grapple.toggle()
            vim.notify("󱡁 Toggle mark")
        end

        grapple.setup()

        -- stylua: ignore start
        keymap("n", "<leader>a", function() mark_file() end)
        keymap("n", "<TAB>", function() grapple.toggle_tags() end)
        keymap("n", "<leader>1", function() grapple.select({ index = 1 }) end)
        keymap("n", "<leader>2", function() grapple.select({ index = 2 }) end)
        keymap("n", "<leader>3", function() grapple.select({ index = 3 }) end)
        keymap("n", "<leader>4", function() grapple.select({ index = 4 }) end)
        keymap("n", "<leader>5", function() grapple.select({ index = 5 }) end)
        -- stylua: ignore end
    end,
}
