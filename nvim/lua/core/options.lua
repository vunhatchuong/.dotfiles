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
opt.updatetime = 100                        -- faster completion
opt.timeoutlen = 250                        -- time to wait for a mapped sequence to complete (in milliseconds)
opt.swapfile = false                        -- creates a swapfile
opt.backup = false                          -- creates a backup file
opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
opt.undofile = true                         -- enable persistent undo
opt.undodir = vim.fn.stdpath("cache") .. "/undo"
opt.hidden = true                           -- required to keep multiple buffers and open multiple buffers
opt.guifont = "JetBrainsMono Nerd Font:h17" -- the font used in graphical neovim applications
opt.autowrite = true                        -- save when kinda change buffer?
opt.fileformat = "unix"
opt.confirm = true                          -- Confirm to save changes before exiting modified buffer

opt.mouse = "a"                             -- allow the mouse to be used in neovim
opt.clipboard = "unnamedplus"

opt.guicursor = ""
opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp

opt.splitbelow = false
opt.splitright = true

opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true  -- smart case

---  APPEARANCE  ---
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.cursorline = true    -- highlight the current line
opt.signcolumn = "yes"   -- always show the sign column otherwise it would shift the text each time
opt.colorcolumn = "80"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.number = true         -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.numberwidth = 4       -- set number column width to 2 {default 4}
opt.laststatus = 3        -- always show the last status {default 2}
opt.conceallevel = 3      -- Hide * markup for bold and italic
opt.pumblend = 10         -- Popup blend
opt.pumheight = 10        -- Maximum number of entries in a popup

---  INDENT  ---
opt.formatoptions = "tcnlj"
opt.list = true           -- Show some invisible characters (tabs...
opt.shiftround = true     -- Round indent
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

---  TABS  ---
opt.wrap = false                            -- display lines as one long line
opt.smartindent = true                      -- make indenting smarter again
opt.expandtab = true                        -- convert tabs to spaces
opt.softtabstop = 4
opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
opt.tabstop = 4                             -- insert 2 spaces for a tab
opt.foldmethod = "expr"                     -- folding set to "manual" for if no treesitter
opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "" if no treesitter
opt.foldlevel = 99
opt.foldlevelstart = 99

---  NETRW  ---
---vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0

---  OTHERS  ---
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.shortmess:append("Wci")        -- don't show redundant messages from ins-completion-menu
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

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
