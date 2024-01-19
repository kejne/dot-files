vim.cmd([[
:highlight ExtraWhitespace ctermbg=Gray guibg=Gray
:highlight TreesitterContext guibg=Black gui=underline guisp=Green
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
vim.opt.clipboard = "unnamedplus"

vim.g.maplocalleader = ","
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.cmd('set conceallevel=2')
vim.fn.sign_define('DapBreakpoint',{ text ='🔴', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='👉', texthl ='', linehl ='', numhl =''})
