local M = {}

local themify_last_change = vim.fn.stdpath("data") .. "/themify_last_change"

local function write_current_date()
    local today = os.date("%Y-%m-%d")
    vim.fn.writefile({ today }, themify_last_change)
end

local function get_last_change_date()
    return vim.fn.filereadable(themify_last_change) == 1
            and vim.fn.readfile(themify_last_change)[1]
        or nil
end

function M.randomize_theme()
    local Themify = require("themify.api")
    local Manager = Themify.Manager

    local current_theme_id = Themify.get_current().colorscheme_id
    local number_of_themes = #Manager.colorschemes

    math.randomseed(os.time())
    while true do
        local theme_id = Manager.colorschemes[math.random(number_of_themes)]

        if theme_id ~= current_theme_id then
            local theme = Themify.Manager.get(theme_id).themes
            local theme_name = theme[math.random(#theme)]

            Themify.set_current(theme_id, theme_name)
            vim.notify("Switched to " .. theme_name)
            return
        end
    end
end

local function setup_daily_theme()
    local last_date = get_last_change_date()
    local today = os.date("%Y-%m-%d")

    if last_date ~= today then
        vim.notify("Randomize theme for today")
        M.randomize_theme()
        write_current_date()
    end
end

function M.setup()
    setup_daily_theme()
    vim.api.nvim_create_user_command("RandomizeTheme", function()
        M.randomize_theme()
    end, {})
end

return M
