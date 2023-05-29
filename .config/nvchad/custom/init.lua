vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function ()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.expandtab = true
  end,
  })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tf",
  callback = function ()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.expandtab = true
  end,
  })
-- local cmd = vim.cmd
-- -- local autocmd = vim.api.nvim_create_autocmd
--
-- -- Auto resize panes when resizing nvim window
-- -- autocmd("VimResized", {
-- --   pattern = "*",
-- --   command = "tabdo wincmd =",
-- -- })
-- cmd([[
-- 	augroup CustomHI
-- 		autocmd!
-- 		autocmd VimEnter * NoMatchParen 
-- 	augroup END
-- ]])
