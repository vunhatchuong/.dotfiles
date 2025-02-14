local opt = vim.opt

-- Set shell to PowerShell 7 if on Win32 or Win64
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    opt.shell = "pwsh -NoLogo"
    opt.shellcmdflag =
        "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
    opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    opt.shellquote = ""
    opt.shellxquote = ""
end

---  SYSTEM   ---
opt.guifont = "JetBrainsMono Nerd Font:h17" -- the font used in graphical neovim applications
opt.updatetime = 250 -- Faster completion
opt.timeoutlen = 250 -- Time to wait for a mapped sequence to complete (in milliseconds)
opt.ttimeoutlen = 10 -- Time to wait for a key code sequence to complete (in milliseconds)
opt.swapfile = false -- creates a swapfile
opt.backup = false -- creates a backup file
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
opt.undofile = true -- enable persistent undo
opt.undodir = vim.fn.stdpath("cache") .. "/undo"
opt.hidden = true -- required to keep multiple buffers and open multiple buffers
opt.autowrite = true -- save when kinda change buffer?
opt.fileformat = "unix"
opt.confirm = true -- Confirm to save changes before exiting modified buffer
-- opt.spell = true
opt.spelllang = { "en" }
opt.spelloptions:append({ "camel", "noplainbuffer" })
opt.smoothscroll = true
opt.jumpoptions = "view"
opt.startofline = true

opt.mouse = "a" -- allow the mouse to be used in neovim
vim.schedule(function() -- includes system call responsible for 40% startuptime!
    opt.clipboard = vim.env.SSH_TTY and "" or { "unnamed", "unnamedplus" }
end)

-- opt.guicursor = ""
opt.guicursor = {
    "n-v-c-i-ci-ve:block", -- Normal, visual, command-line: block cursor
    -- "i-ci-ve:ver25", -- Insert, command-line insert, visual-exclude: vertical bar cursor with 25% width
    "r-cr:hor20", -- Replace, command-line replace: horizontal bar cursor with 20% height
    "o:hor50", -- Operator-pending: horizontal bar cursor with 50% height
    -- "a:blinkwait700-blinkoff400-blinkon250", -- All modes: blinking settings
    -- "sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch: block cursor with specific blinking settings
}
opt.completeopt = "menu,menuone,preview,noselect,noinsert"
-- opt.completeopt = "menu,menuone,noselect"

opt.splitbelow = false
opt.splitright = true

opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true -- smart case

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

---  APPEARANCE  ---
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.showmode = false -- Already has lualine
opt.cursorline = true -- highlight the current line
opt.cursorlineopt = "number"
opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
-- opt.statuscolumn = "%s %3{v:relnum?v:relnum:v:lnum} %="
opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
opt.colorcolumn = "80"
opt.scrolloff = 8
opt.sidescrolloff = 20
opt.numberwidth = 4 -- set number column width to 2 {default 4}
opt.laststatus = 3 -- always show the last status {default 2}
opt.conceallevel = 2 -- Hide * markup for bold and italic
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.cmdheight = 0
opt.showcmd = false
opt.inccommand = "split"

---  INDENT  ---
opt.formatoptions = "12tcnlj"
opt.list = true -- Show some invisible characters (tabs...
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

opt.breakindent = true
opt.breakindentopt = "sbr"
opt.linebreak = true
opt.showbreak = [[↪ ]]

---  TABS  ---
opt.wrap = false -- display lines as one long line
opt.smartindent = true -- make indenting smarter again
opt.expandtab = true -- convert tabs to spaces
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
opt.tabstop = 4 -- insert 2 spaces for a tab
-- opt.foldmethod = "expr" -- folding set to "manual" for if no treesitter
-- opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- opt.foldlevel = 99
-- opt.foldlevelstart = 99

---  NETRW  ---
---vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0

---  OTHERS  ---
opt.wildmode = "longest:full,full" -- Command-line completion mode
-- opt.wildoptions = { "pum", "fuzzy" }
opt.wildignorecase = true -- Ignore case when completing file names and directories
opt.shortmess:append("tToOWIcsF") -- don't show redundant messages from ins-completion-menu
opt.fillchars = vim.opt.fillchars + "eob: "
opt.fillchars:append({
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
    stl = " ",
})

-- Disable language providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

local M = {}

M.two_space_indents = {
    "html",
    "xhtml",
    "xml",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",

    "query",
    "json",
    "yaml",
    "nix",
    "gleam",
}

return M
