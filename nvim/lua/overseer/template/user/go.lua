return {
    name = "go run main.go",
    builder = function()
        return {
            cmd = { "go" },
            args = { "run", "main.go" },
            name = "run main.go",
        }
    end,
    priority = 1, -- Lower comes first.
    condition = {
        filetype = { "go", "templ" },
    },
}
