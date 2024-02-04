return {
    "ggandor/leap.nvim",
    dependencies = {
        {
            "/ggandor/flit.nvim",
            config = function()
                require("flit").setup({
                    -- A string like "nv", "nvo", "o", etc.
                    labeled_modes = "nv",
                })
            end,
        },
    },
    event = { "BufReadPost", "BufNewFile", "BufWritePre","VeryLazy"  },
    keys = {
        { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
        { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
    },
    config = function()
        local leap = require("leap")
        leap.add_default_mappings(true)
        -- Greying out the search area
        vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#777777" })
    end,
}
