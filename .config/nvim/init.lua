-- Config
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true 
--vim.wo.relativenumber = true
vim.wo.number = true

-- Plugins
require("imanero.config.lazy")
require("imanero.config.theme")
require("imanero.config.lualine")
require("imanero.config.telescope")
require("imanero.config.treesitter")
