return {
    "windwp/nvim-autopairs",
    -- Won't apply ignore_next_char if enabled
    -- event = "InsertEnter",
    event = "VeryLazy",
    opts = {},
    config = function()
        require("nvim-autopairs").setup({
            map_char = {
                all = "(",
                tex = "{",
            },
            check_ts = true,
            ts_config = {
                lua = { "string", "source" },
                javascript = { "string", "template_string" },
                java = false,
            },
            disable_filetype = { "TelescopePrompt" },
            ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
        })
    end,
}
