-- Bootstrap --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
        { import = "plugins.lang.general" },
        { import = "core.lang" },
    },
    defaults = {
        lazy = true,
    },
    install = { colorscheme = { "default" } },
    checker = { enabled = true },
    change_detection = {
        enabled = false,
        notify = false,
    },
    performance = {
        rtp = {
            -- https://github.com/vim/vim/blob/master/runtime
            disabled_plugins = {
                "gzip",
                "tar",
                "tarPlugin",
                "zip",
                "zipPlugin",
                "vimball",
                "vimballPlugin",
                "matchit",
                "matchparen",
                "rrhelper",
                "logiPat",
                "getscript",
                "getscriptPlugin",
                "2html_plugin",
                "tohtml",
                "tutor",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "remote_plugins",
                "man",
                "rplugin",
            },
        },
    },
})
