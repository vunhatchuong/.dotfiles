require("hover").register({
    name = "Ecolog Saga Hover",
    priority = 1000,
    enabled = function()
        local ok, _ = pcall(require, "ecolog")
        if not ok then
            return false
        end

        return true
    end,
    execute = function()
        vim.cmd("EcologSagaHover")
    end,
})
