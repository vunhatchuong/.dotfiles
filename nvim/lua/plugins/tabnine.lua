return {
    "tzachar/cmp-tabnine",
    event = "InsertEnter",
    build = function()
        if vim.loop.os_uname().sysname:find("Windows") then
            os.execute("pwsh -noni .\\install.ps1")
        else
            os.execute("./install.sh")
        end
        vim.cmd(":CmpTabnineHub")
    end,
    dependencies = "hrsh7th/nvim-cmp",
    opts = {
        max_num_results = 3,
    },
    config = function(_, opts)
        require("cmp_tabnine.config"):setup(opts)
    end,
}
