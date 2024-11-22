---@class util.worktree
local M = {}

local function is_valid_switch(info)
    return not (
        info.repo_type ~= "bare"
        and info.cwd == info.resolved_base
        and info.cwd == info.branch_info.new_path
    )
end

function M.arbor_post_add(info)
    info = require("arbor").actions.set_upstream(
        info,
        { push_if_from_local = false }
    ) or info
    M.arbor_post_switch(info)
end

function M.arbor_post_switch(info)
    if is_valid_switch(info) then
        if info.new_path then
            require("arbor").actions.cd_new_path(info)
        else
            require("arbor").actions.cd_existing_worktree(info)
        end
        vim.cmd("bufdo bd")
        vim.cmd("Oil")
    else
        vim.notify("Already on this worktree")
    end
end

function M.arbor_pre_remove(info)
    require("arbor").actions.pick_if_current(info, {})
end

return M
