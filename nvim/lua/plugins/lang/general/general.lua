return {
    {
        "vidocqh/data-viewer.nvim",
        -- ft = { "csv", "tsv", "dat", "csv_pipe", "dbout" },
        cmd = { "DataViewer" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {},
    },
    {
        "fei6409/log-highlight.nvim",
        ft = { "log" },
        opts = {
            extension = "log",
            filename = {
                "messages",
                "logcat",
                "syslog",
                "chrome",
            },
            pattern = {
                "/var/log/.*",
                "messages%..*",
                "messages-.*",
                ".*%.LATEST",
                ".*%.PREVIOUS",
                ".*%.previous",
            },
        },
    },
}
