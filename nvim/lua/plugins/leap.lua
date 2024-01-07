return {
    "ggandor/leap.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
        { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
    },
    config = function()
        local leap = require("leap")
        leap.add_default_mappings(true)
    end,
}

