-- Credits to https://github.com/chrisgrieser/.config/blob/main/nvim/lua/plugins/lualine.lua#L4
local progressText = ""
local function lspProgress()
    return progressText
end

vim.api.nvim_create_autocmd("LspProgress", {
    callback = function(ctx)
        local progress = ctx.data.params.value ---@type {percentage: number, title?: string, kind: string, message?: string}
        if not (progress and progress.title) then
            return
        end

        local icons = { "󰫃", "󰫄", "󰫅", "󰫆", "󰫇", "󰫈" }
        local idx = math.floor(#icons / 2)
        if progress.percentage == 0 then
            idx = 1
        end
        if progress.percentage and progress.percentage > 0 then
            idx = math.ceil(progress.percentage / 100 * #icons)
        end
        local firstWord = vim.split(progress.title, " ")[1]:lower()

        local text = table.concat({ icons[idx], firstWord }, " ")
        progressText = progress.kind == "end" and "" or text
    end,
})

-- https://github.com/dgox16/dotfiles/blob/main/.config/nvim/lua/configs/lualine.lua#L92
local function getLspName()
    local bufnr = vim.api.nvim_get_current_buf()
    local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })
    local buf_ft = vim.bo.filetype
    if next(buf_clients) == nil then
        return "No servers"
    end
    local buf_client_names = {}

    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

    -- local lint_s, lint = pcall(require, "lint")
    -- if lint_s then
    --     for ft_k, ft_v in pairs(lint.linters_by_ft) do
    --         if type(ft_v) == "table" then
    --             for _, linter in ipairs(ft_v) do
    --                 if buf_ft == ft_k then
    --                     table.insert(buf_client_names, linter)
    --                 end
    --             end
    --         elseif type(ft_v) == "string" then
    --             if buf_ft == ft_k then
    --                 table.insert(buf_client_names, ft_v)
    --             end
    --         end
    --     end
    -- end

    -- local ok, conform = pcall(require, "conform")
    -- if ok then
    --     local formatters =
    --         table.concat(conform.list_formatters_for_buffer(), " ")
    --     for formatter in formatters:gmatch("%w+") do
    --         if formatter then
    --             table.insert(buf_client_names, formatter)
    --         end
    --     end
    -- end

    local hash = {}
    local unique_client_names = {}

    for _, v in ipairs(buf_client_names) do
        if not hash[v] then
            unique_client_names[#unique_client_names + 1] = v
            hash[v] = true
        end
    end
    local language_servers = table.concat(unique_client_names, ", ")

    return language_servers
end

return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        opts = function()
            -- PERF: we don't need this lualine require madness 🤷
            local lualine_require = require("lualine_require")
            lualine_require.require = require

            local icons = require("core.icons")

            vim.o.laststatus = vim.g.lualine_laststatus

            return {
                options = {
                    theme = {
                        normal = {
                            a = { fg = "fg", bg = "bg", gui = "bold" },
                            b = { fg = "fg", bg = "bg" },
                            c = { fg = "fg", bg = "bg" },
                        },
                    },
                    globalstatus = vim.o.laststatus == 3,
                    component_separators = "",
                    section_separators = "",
                },
                sections = {
                    lualine_a = {
                        { "mode" },
                        {
                            function()
                                return icons.ui.BoldLineMiddle
                            end,
                            color = { fg = "fg" },
                            padding = 0,
                        },
                    },
                    lualine_b = {
                        { "branch", color = { gui = "bold" } },
                        {
                            "diff",
                            diff_color = {
                                added = "Added",
                                modified = "Changed",
                                removed = "Removed",
                            },
                            symbols = {
                                added = icons.git.LineAdded,
                                modified = icons.git.LineModified,
                                removed = icons.git.LineRemoved,
                            },
                        },
                        {
                            function()
                                return icons.ui.BoldLineMiddle
                            end,
                            color = { fg = "fg" },
                            padding = 0,
                        },
                    },
                    lualine_c = {
                        {
                            "filetype",
                            icon_only = true,
                            padding = { left = 1, right = 0 },
                        },
                        { "filename", path = 1 },
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            symbols = {
                                error = icons.diagnostics.BoldError,
                                warn = icons.diagnostics.BoldWarning,
                                info = icons.diagnostics.BoldInformation,
                                hint = icons.diagnostics.BoldHint,
                            },
                        },
                        -- {
                        --     require("dr-lsp").lspCount,
                        --     fmt = function(str)
                        --         return str:gsub("R", "impls")
                        --             :gsub("D", "defs")
                        --             :gsub("LSP:", "")
                        --     end,
                        -- },
                    },
                    -- Right
                    lualine_x = {},
                    lualine_y = {
                        {
                            lspProgress,
                        },
                        {
                            getLspName,
                            icon = icons.git.Octoface,
                            color = { gui = "bold" },
                        },
                    },
                    lualine_z = {
                        { "progress", padding = { left = 5, right = 0 } },
                        { "location" },
                    },
                },
                extensions = { "nvim-dap-ui", "oil", "quickfix", "trouble" },
            }
        end,
    },
    -- { -- lsp definitions & references count in the status line
    --     "chrisgrieser/nvim-dr-lsp",
    --     event = "LspAttach",
    --     opts = {},
    -- },
}
