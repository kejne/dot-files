vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('i', 'jj', '<Esc><Esc>', { desc = 'To normal mode' })
vim.keymap.set('x', '<C-s>', '<Esc>:wa<CR>', { desc = 'Save all', noremap = true, silent = true })
vim.keymap.set('i', '<C-s>', '<Esc>:wa<CR>', { desc = 'Save all', noremap = true, silent = true })
vim.keymap.set('n', '<C-s>', ':wa<CR>', { desc = 'Save all', noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', ':Neotree toggle float<CR>', { desc = 'Toggle Explorer', noremap = true, silent = true })

vim.keymap.set('n', '-', ':Oil<CR>', { desc = 'Explore with Oil' })
-- Harpoon
vim.keymap.set('n', '<leader>m', ':lua require("harpoon.mark").add_file()<CR>', { desc = 'Mark Harpoon', noremap = true, silent = true })
vim.keymap.set('n', '<leader>mm', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { desc = 'Harpoon Menu', noremap = true, silent = true })
vim.keymap.set('n', '<Tab>', ':lua require("harpoon.ui").nav_next()<CR>', { desc = 'Prev Harpoon', noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':lua require("harpoon.ui").nav_prev()<CR>', { desc = 'Next Harpoon', noremap = true, silent = true })

vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { desc = 'Verical Split', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ba', ':%bd|e#|bd#<CR>', { desc = 'Close [B]uffer [A]ll', noremap = true, silent = true })
vim.keymap.set('n', '<leader>bb', ':bd<CR>', { desc = 'Close [BB]uffer', noremap = true, silent = true })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<leader>h', '<C-w><C-h>', { desc = 'Move focus to the left window', noremap = true, silent = true })
vim.keymap.set('n', '<leader>l', '<C-w><C-l>', { desc = 'Move focus to the right window', noremap = true, silent = true })
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower window', noremap = true, silent = true })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper window', noremap = true, silent = true })

vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to system clipboard', noremap = true, silent = true })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from system clipboard', noremap = true, silent = true })

vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Go up and center' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Go down and center' })

vim.keymap.set('n', '<leader>ra', ':lua require("spectre").toggle()<CR>', { desc = '[R]eplace [A]ll', noremap = true, silent = true })
vim.keymap.set('n', '<leader>rw', ':lua require("spectre").open_visual({select_word = true})<CR>', { desc = '[R]eplace [A]ll', noremap = true, silent = true })
vim.keymap.set('n', '<leader>rr', ':lua require("spectre").open_file_search({select_word = true})<CR>', { desc = '[R]eplace', noremap = true, silent = true })

vim.keymap.set('n', '<leader>xq', ':Trouble quickfix<CR>', { desc = '[X] Error [Q]uickfix', noremap = true, silent = true })
vim.keymap.set('n', '<leader>xx', ':Trouble diagnostics<CR>', { desc = '[X] Error E[X]plore', noremap = true, silent = true })

vim.keymap.set('n', 'gp', ':GoImports<CR>', { desc = '[G]o I[M]ports', noremap = true, silent = true })
vim.keymap.set('n', 'gav', ':GoAltV<CR>', { desc = '[G]o [A]lternate [V]split', noremap = true, silent = true })
vim.keymap.set('n', 'gaa', ':GoAlt<CR>', { desc = '[G]o [A]lternate', noremap = true, silent = true })
vim.keymap.set('n', 'gtf', ':GoTestFunc<CR>', { desc = '[G]o [T]est [F]unc', noremap = true, silent = true })
vim.keymap.set('n', 'gtt', ':GoTest<CR>', { desc = '[G]o [T]est', noremap = true, silent = true })
vim.keymap.set('n', 'gts', ':GoTestSubCase<CR>', { desc = '[G]o [T]est [S]ubcase', noremap = true, silent = true })
vim.keymap.set('n', 'gtc', ':GoCoverageToggle<CR>', { desc = '[G]o [T]est [C]overage', noremap = true, silent = true })
vim.keymap.set('n', 'gtd', ':GoDebug<CR>', { desc = '[G]o [T]est [D]ebug', noremap = true, silent = true })
vim.keymap.set('n', 'gtx', ':GoDebug --stop<CR>', { desc = '[Go] [T]est E[X]it', noremap = true, silent = true })

vim.keymap.set('n', '<leader>oi', ':ObsidianPasteImg<CR>', { desc = 'Obsidian Paste Image', noremap = true, silent = true })
vim.keymap.set('n', '<leader>owp', ':ObsidianWorkspace personal<CR>', { desc = 'Obsidian Personal Workspace', noremap = true, silent = true })
vim.keymap.set('n', '<leader>owd', ':ObsidianWorkspace default<CR>', { desc = 'Obsidian Default Workspace', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ot', ':ObsidianQuickSwitch todo<CR>', { desc = 'Open TODO notes', noremap = true, silent = true })
vim.keymap.set('n', '<leader>oq', ':ObsidianQuickSwitch<CR>', { desc = 'ObsidianQuickSwitch', noremap = true, silent = true })
vim.keymap.set('n', '<leader>os', ':ObsidianSearch<CR>', { desc = 'Obsidian Search', noremap = true, silent = true })
vim.keymap.set('n', '<leader>opz', ':ObsidianWorkspace personal<CR>:ObsidianNew ', { desc = 'New Personal Zettel' })
vim.keymap.set('n', '<leader>odz', ':ObsidianWorkspace default<CR>:ObsidianNew ', { desc = 'New Default Zettel' })
vim.keymap.set('n', '<leader>oz', ':ObsidianNew ', { desc = 'New Zettel' })
vim.keymap.set('n', '<leader>oj', ':ObsidianToday<CR>', { desc = 'Journal', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ob', ':ObsidianBacklinks<CR>', { desc = 'Backlinks', noremap = true, silent = true })
-- Debugging
vim.keymap.set('n', '<leader>db', ':DapToggleBreakpoint<CR>', { desc = 'Toggle Breakpoint', noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', ':DapStepInto<CR>', { desc = 'Debug Step Into', noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', ':DapStepOver<CR>', { desc = 'Debug Step Over', noremap = true, silent = true })
vim.keymap.set('n', '<leader>dn', ':DapNew<CR>', { desc = 'Debug New', noremap = true, silent = true })
vim.keymap.set('n', '<leader>dt', ':DapTerminate<CR>', { desc = 'Debug Terminate', noremap = true, silent = true })
vim.keymap.set('n', '<leader>de', ':lua require("dapui").eval()<CR>', { desc = 'Debug evaluate', noremap = true, silent = true })
vim.keymap.set('x', '<leader>de', ':lua require("dapui").eval()<CR>', { desc = 'Debug evaluate', noremap = true, silent = true })
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste and keep buffer', noremap = true, silent = true })
vim.keymap.set('x', '<leader>y', '"+y', { desc = 'Copy to system clipboard', noremap = true, silent = true })

vim.keymap.set('n', '<leader>zp', ':ZenMode | Pencil<CR>', { desc = '[Z]en mode', noremap = true, silent = true })
vim.keymap.set('n', '<leader>zz', ':ZenMode<CR>', { desc = '[Z]en mode', noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>tw', ':Twilight<CR>', { desc = '[T]oggle T[W]ilight', noremap = true, silent = true })
vim.keymap.set('n', '<leader>gd', ':DiffviewfileHistory %<CR>', { desc = '[G]it [D]iff History', noremap = true, silent = true })
vim.keymap.set('n', '<leader>gc', ':ChatGPT<CR>', { desc = 'Chat[G]pt [C]hat', noremap = true, silent = true })
vim.keymap.set('n', '<leader>gr', ':ChatGPTRun ', { desc = 'Chat[G]pt [R]un' })
vim.keymap.set('v', '<leader>gr', ':ChatGPTRun ', { desc = 'Chat[G]pt [R]un' })
vim.keymap.set('v', '<leader>ge', ':ChatGPTEditWithInstructions<CR>', { desc = 'Chat[G]pt [E]dit With Instructions' })

vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move highlighted line up', silent = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move highlighted line down', silent = true })

vim.keymap.set('n', '<leader>cc', ':CopilotChat<CR>', { desc = '[C]opilot [C]hat' })
vim.keymap.set('x', '<leader>cc', ':CopilotChat<CR>', { desc = '[C]opilot [C]hat' })
vim.keymap.set('x', '<leader>cq', function()
  local input = vim.fn.input 'Quick Chat: '
  if input ~= '' then
    require('CopilotChat').ask(input .. '. No explainations.', { selection = require('CopilotChat.select').visual })
  end
end, { desc = 'CopilotChat - Quick chat' })
