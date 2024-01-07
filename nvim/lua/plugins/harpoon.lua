return {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        local keymap = vim.keymap.set
        local function mark_file()
            harpoon:list():append()
            vim.notify "󱡅  Marked file"
        end

        harpoon:setup()

        keymap("n", "<leader>a", function() mark_file() end)
        keymap("n", "<TAB>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        keymap("n", "<S-h>", function()
            harpoon:list():select(1)
        end)
        keymap("n", "<S-j>", function()
            harpoon:list():select(2)
        end)
        keymap("n", "<S-k>", function()
            harpoon:list():select(3)
        end)
        keymap("n", "<S-l>", function()
            harpoon:list():select(4)
        end)
    end,
}

