return {
    {
        "supermaven-inc/supermaven-nvim",
        build = ":SupermavenUseFree",
        event = "InsertEnter",
        cmd = "SupermavenToggle",
        opts = {
            log_level = "off",
            disable_keymaps = true,
            disable_inline_completion = true,
            ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
        },
    },
}
