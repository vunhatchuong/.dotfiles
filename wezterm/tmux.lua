local wezterm = require("wezterm")
local act = wezterm.action

local sessionizer = require("sessionizer")

local M = {}

M.apply = function(config)
    ---  LEADER   ---
    config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
    config.keys = {
        { key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "o", mods = "CTRL" }) },
        -- Client navigation --
        { key = "l", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(1) },
        { key = "h", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(-1) },

        -- PANE --
        { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
        { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
        { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
        { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
        { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
        { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
        { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

        -- TAB --
        { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
        { key = "w", mods = "LEADER", action = act.CloseCurrentTab({ confirm = false }) },

        { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
        { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
        { key = "l", mods = "LEADER|CTRL", action = act.ActivateTabRelative(1) },
        { key = "h", mods = "LEADER|CTRL", action = act.ActivateTabRelative(-1) },

        { key = "n", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },
        { key = "p", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },

        { key = "s", mods = "LEADER", action = act.ShowTabNavigator },
        { key = "i", mods = "LEADER", action = act.ActivateCopyMode },

        {
            key = ",",
            mods = "LEADER",
            action = wezterm.action.PromptInputLine({
                description = "Tab name",
                action = wezterm.action_callback(function(window, _, line)
                    if line then
                        window:active_tab():set_title(line)
                    end
                end),
            }),
        },
        {
            key = "f",
            mods = "LEADER",
            action = wezterm.action_callback(sessionizer.open),
        },
        {
            key = "e",
            mods = "LEADER",
            action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
        },
        {
            key = "p",
            mods = "CTRL",
            action = act.ShowLauncherArgs({ flags = "FUZZY|LAUNCH_MENU_ITEMS" }),
        },
    }

    for i = 1, 9 do
        table.insert(config.keys, {
            key = tostring(i),
            mods = "LEADER",
            action = act.ActivateTab(i - 1),
        })
    end
end

return M
