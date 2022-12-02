vim.cmd("colorscheme base16-gruvbox-dark-hard")

local status, _ = pcall(vim.cmd, "colorscheme base16-gruvbox-dark-hard")
if not status then 
 print("colorscheme not found!")
 return
end
