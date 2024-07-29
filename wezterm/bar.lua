local wezterm = require("wezterm")

local username = os.getenv("USER") or os.getenv("LOGNAME") or os.getenv("USERNAME")
local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

local module = {}

local basename = function(path) -- get filename from path
    if type(path) ~= "string" then
        return nil
    end
    local file = ""
    if is_windows then
        file = path:gsub("(.*[/\\])(.*)", "%2") -- replace (path/ or path\)(file) with (file)
    else
        file = path:gsub("(.*/)(.*)", "%2") -- replace (path/)(file) with (file)
    end
    -- remove extension
    file = file:gsub("(%..+)$", "")
    return file
end

local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return basename(tab_info.active_pane.title)
end

module.apply = function(config)
    wezterm.on("format-tab-title", function(tab, _, _, _, hover)
        local background = config.colors.brights[1]
        local foreground = config.colors.foreground

        if tab.is_active then
            background = config.colors.brights[7]
            foreground = config.colors.background
        elseif hover then
            background = config.colors.brights[8]
            foreground = config.colors.background
        end
        local title = tostring(tab.tab_index + 1) .. ":" .. tab_title(tab)
        return {
            { Foreground = { Color = background } },
            { Text = "█" },
            { Background = { Color = background } },
            { Foreground = { Color = foreground } },
            { Text = title },
            { Foreground = { Color = background } },
            { Text = "█" },
        }
    end)
    wezterm.on("update-right-status", function(window, _)
        local date = wezterm.strftime(" %d-%m-%Y %H:%M")
        window:set_right_status(wezterm.format({
            { Text = "  " .. window:active_workspace() .. " |" },
            { Text = "  " .. username .. " |" },
            { Text = " " .. date },
        }))
    end)
end

return module
