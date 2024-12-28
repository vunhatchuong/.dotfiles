local command = vim.api.nvim_create_user_command

local function learn_mode()
    _G.LearnMode = true
end

command("LearnMode", function()
    learn_mode()
end, {})

command("Pet", function(opts)
    local ms = opts.fargs[1] or 1800000 -- 30mins
    -- stylua: ignore
    local pets = { "🦆", "ඞ", "🦀", "🐈", "🦖", "🐤", "🐁", "🐇", "🐢", "🦭" }

    vim.fn.timer_start(ms, function()
        math.randomseed(os.time())
        require("duck").hatch(pets[math.random(#pets)])
    end, { ["repeat"] = -1 })
end, { nargs = "*" })
