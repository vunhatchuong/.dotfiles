local command = vim.api.nvim_create_user_command
local api = vim.api

local function learn_mode()
    vim.diagnostic.enable(_G.LearnMode)
    _G.LearnMode = not _G.LearnMode
end

command("LearnMode", function()
    learn_mode()
end, {})

command("DiffTemp", function(opts)
    local start_line, end_line = opts.line1, opts.line2

    local buf_ft =
        api.nvim_get_option_value("filetype", { buf = api.nvim_win_get_buf(0) })

    local pivot_win = api.nvim_get_current_win()
    for _, win in ipairs(api.nvim_list_wins()) do
        if win ~= pivot_win then
            api.nvim_win_close(win, true)
        end
    end

    local selection = api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local origin_buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_lines(origin_buf, 0, -1, false, selection)
    api.nvim_buf_set_name(origin_buf, "difftemp_origin")
    api.nvim_set_option_value("filetype", buf_ft, { buf = origin_buf })
    api.nvim_set_option_value("buftype", "acwrite", { buf = origin_buf })
    api.nvim_set_option_value("bufhidden", "hide", { buf = origin_buf })
    local origin_winid = api.nvim_open_win(origin_buf, false, {
        split = "right",
        win = 0,
    })

    local ref_buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_name(ref_buf, "difftemp_refactor")
    api.nvim_set_option_value("filetype", buf_ft, { buf = ref_buf })
    api.nvim_set_option_value("buftype", "acwrite", { buf = ref_buf })
    api.nvim_set_option_value("bufhidden", "hide", { buf = ref_buf })
    local ref_winid = api.nvim_open_win(ref_buf, false, {
        split = "right",
        win = 0,
    })

    api.nvim_win_close(pivot_win, true)

    vim.keymap.set("n", "q", function()
        -- https://github.com/NTBBloodbath/exemplum.nvim/blob/master/lua/exemplum/components/function.lua#L101
        -- local refactor_code = vim.api.nvim_buf_get_lines(ref_buf, 0, -1, false)
        -- vim.api.nvim_buf_set_lines(
        --     editor_buf,
        --     start_line - 1,
        --     end_line,
        --     false,
        --     refactor_code
        -- )

        api.nvim_set_option_value("diff", false, { win = origin_winid })
        api.nvim_set_option_value("diff", false, { win = ref_winid })
        api.nvim_buf_delete(origin_buf, { force = true })
        api.nvim_buf_delete(ref_buf, { force = true })
    end, { buffer = true })

    local group = api.nvim_create_augroup("DiffOnSave", { clear = true })

    api.nvim_create_autocmd({ "BufWriteCmd" }, {
        desc = "Enable diff mode on save",
        group = group,
        pattern = "difftemp_*",
        callback = function(event)
            if event.event == "BufWriteCmd" then
                api.nvim_set_option_value("diff", true, { win = origin_winid })
                api.nvim_set_option_value("diff", true, { win = ref_winid })
            end
        end,
    })
end, { nargs = 0, range = 2 })
