vim.cmd([[
:highlight ExtraWhitespace ctermbg=Gray guibg=Gray
:match ExtraWhitespace /\s\+$/
]])
vim.cmd("let g:go_addtags_transform = 'camelcase'")
vim.cmd([[
	augroup CustomHI
		autocmd!
		autocmd VimEnter * NoMatchParen
	augroup END
]])
vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! TabLineFill guibg=NONE guifg=#303030')
vim.wo.relativenumber = true
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
vim.api.nvim_set_option("clipboard","unnamed")
