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
    if next(buf_clients) == nil then
        return "No servers"
    end
    local buf_client_names = {}

    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

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

-- https://github.com/sschleemilch/slimline.nvim/blob/main/lua/slimline/utils.lua
--- @return string
local function get_mode()
    -- Note that: \19 = ^S and \22 = ^V.
    local mode_map = {
        ["n"] = "NORMAL",
        ["no"] = "OP-PENDING",
        ["nov"] = "OP-PENDING",
        ["noV"] = "OP-PENDING",
        ["no\22"] = "OP-PENDING",
        ["niI"] = "NORMAL",
        ["niR"] = "NORMAL",
        ["niV"] = "NORMAL",
        ["nt"] = "NORMAL",
        ["ntT"] = "NORMAL",
        ["v"] = "VISUAL",
        ["vs"] = "VISUAL",
        ["V"] = "VISUAL",
        ["Vs"] = "VISUAL",
        ["\22"] = "VISUAL",
        ["\22s"] = "VISUAL",
        ["s"] = "SELECT",
        ["S"] = "SELECT",
        ["\19"] = "SELECT",
        ["i"] = "INSERT",
        ["ic"] = "INSERT",
        ["ix"] = "INSERT",
        ["R"] = "REPLACE",
        ["Rc"] = "REPLACE",
        ["Rx"] = "REPLACE",
        ["Rv"] = "VIRT REPLACE",
        ["Rvc"] = "VIRT REPLACE",
        ["Rvx"] = "VIRT REPLACE",
        ["c"] = "COMMAND",
        ["cv"] = "VIM EX",
        ["ce"] = "EX",
        ["r"] = "PROMPT",
        ["rm"] = "MORE",
        ["r?"] = "CONFIRM",
        ["!"] = "SHELL",
        ["t"] = "TERMINAL",
    }

    local mode = mode_map[vim.api.nvim_get_mode().mode] or "UNKNOWN"
    return mode
end
local function get_hl_color(group)
    local hl = vim.api.nvim_get_hl(0, { name = group })

    if hl.link then
        return get_hl_color(hl.link)
    end

    local fg = hl.fg and string.format("#%06x", hl.fg) or "none"

    return fg
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
                            a = { fg = get_hl_color("Type"), bg = "bg" },
                            b = { fg = "fg", bg = "bg" },
                            c = { fg = "fg", bg = "bg" },
                        },
                        insert = {
                            a = { fg = get_hl_color("Function"), bg = "bg" },
                            b = { fg = "fg", bg = "bg" },
                            c = { fg = "fg", bg = "bg" },
                        },
                        visual = {
                            a = { fg = get_hl_color("Keyword"), bg = "bg" },
                            b = { fg = "fg", bg = "bg" },
                            c = { fg = "fg", bg = "bg" },
                        },
                        replace = {
                            a = { fg = get_hl_color("Boolean"), bg = "bg" },
                            b = { fg = "fg", bg = "bg" },
                            c = { fg = "fg", bg = "bg" },
                        },
                        command = {
                            a = { fg = get_hl_color("String"), bg = "bg" },
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
                        { -- mode
                            function()
                                return string.sub(get_mode(), 1, 1)
                            end,
                            padding = 2,
                        },
                    },
                    lualine_b = {
                        { "branch", icon = icons.git.Branch },
                        {
                            "diff",
                            diff_color = {
                                added = "Comment",
                                modified = "Comment",
                                removed = "Comment",
                            },
                            padding = { right = 2 },
                        },
                    },
                    lualine_c = {
                        {
                            "filetype",
                            icon_only = true,
                            padding = { left = 1 },
                        },
                        {
                            "filename",
                            path = 1,
                            color = "Comment",
                            symbols = { modified = "", readonly = "" },
                            padding = {},
                        },
                        {
                            "grapple",
                            inactive = "%s",
                            padding = { left = 1, right = 5 },
                        },
                        -- {
                        --     function()
                        --         return require("grapple").name_or_index()
                        --     end,
                        --     cond = function()
                        --         return package.loaded["grapple"]
                        --             and require("grapple").exists()
                        --     end,
                        -- },
                    },
                    -- Right
                    lualine_x = {},
                    lualine_y = {
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            symbols = {
                                error = icons.diagnostics.BoldError,
                                warn = icons.diagnostics.BoldWarning,
                                info = icons.diagnostics.BoldInformation,
                                hint = icons.diagnostics.Hint,
                            },
                        },
                        { lspProgress },
                        {
                            getLspName,
                            icon = icons.git.Octoface,
                            color = "Comment",
                        },
                    },
                    lualine_z = {
                        {
                            "progress",
                            icon = icons.ui.Text,
                            padding = { left = 3, right = 0 },
                        },
                        { "location", icon = "/" },
                    },
                },
                extensions = { "nvim-dap-ui", "oil", "quickfix", "trouble" },
            }
        end,
    },
}
