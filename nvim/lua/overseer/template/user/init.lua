-- List of template file names (without the .lua extension)
local template_files = {
    "go",
}

local templates = {}
for i = 1, #template_files do
    templates[i] = "user." .. template_files[i]
end

return templates
