---@diagnostic disable: undefined-global

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd "let g:go_addtags_transform = 'camelcase'"
vim.cmd 'highlight! HarpoonInactive guibg=NONE guifg=#63698c'
vim.cmd 'highlight! HarpoonActive guibg=NONE guifg=white'
vim.cmd 'highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7'
vim.cmd 'highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7'
vim.cmd 'highlight! TabLineFill guibg=NONE guifg=#303030'
vim.o.foldcolumn = '0' -- '0' is not bad
-- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.cmd 'set conceallevel=2'
vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'
-- Don't show the mode, since it's already in status line

vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.listchars = { tab = '  ', trail = '@', nbsp = '␣' }
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'
-- Show which line your cursor is on
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

vim.opt.tabstop = 4
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('wrap_spell', { clear = true }),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    -- vim.opt_local.textwidth = 120
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'helm',
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.expandtab = true
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'yaml',
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.expandtab = true
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.expandtab = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'tf',
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.expandtab = true
  end,
})

require 'mappings'
require 'plugins'
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--[[ 
    Function to handle folding of text with virtual text.
    Parameters:
      - virtText: table containing the text to be folded
      - lnum: starting line number
      - endLnum: ending line number
      - width: width of the virtual text
      - truncate: function to truncate text if it exceeds the width
    Returns:
      - newVirtText: table containing the modified virtual text
  --]]

require('lazy').setup {
  rocks = {
    hererocks = true,
  },
  {
    'rest-nvim/rest.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, 'http')
      end,
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default', ['<C-k>'] = { 'select_prev', 'fallback' }, ['<C-j>'] = { 'select_next', 'fallback' } },
      signature = { enabled = true },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      snippets = { preset = 'default' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
  { 'sindrets/diffview.nvim' },
  { 'subnut/nvim-ghost.nvim' },
  -- {
  --   'pwntester/octo.nvim',
  --   event = 'VeryLazy',
  --   priority = 1,
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     -- 'nvim-telescope/telescope.nvim',
  --     'folke/snacks.nvim',
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   config = function()
  --     require('octo').setup()
  --   end,
  -- },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },
  'JoosepAlviste/nvim-ts-context-commentstring',
  -- {
  --   'zbirenbaum/copilot.lua',
  --   event = 'VeryLazy',
  --   config = function()
  --     require('copilot').setup {
  --       suggestion = {
  --         enabled = false,
  --         keymap = {
  --           accept = '<C-y>',
  --           next = '<C-j>',
  --           prev = '<C-k>',
  --           dismiss = '<C-c>',
  --         },
  --       },
  --       panel = { enabled = false },
  --       filetypes = {
  --         yaml = true,
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   'zbirenbaum/copilot-cmp',
  --   event = 'VeryLazy',
  --   config = function()
  --     require('copilot_cmp').setup()
  --   end,
  -- },
  {
    'zbirenbaum/copilot.lua',
    lazy = true,
    config = function()
      require('copilot').setup()
    end,
    opts = {
      copilot_model = 'claude-3-7-sonnet',
    },
  },
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   version = '*',
  --   event = 'VeryLazy',
  --   dependencies = {
  --     { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
  --     { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log wrapper
  --   },
  --   build = 'make tiktoken', -- Only on MacOS or Linux
  --   opts = {
  --     model = 'claude-3-7-sonnet', -- Default model to use, see ':CopilotChatModels' for available models (can be specified manually in prompt via $).
  --     agent = 'copilot',
  --     -- debug = true, -- Enable debugging
  --     context = 'buffers',
  --     -- See Configuration section for rest
  --   },
  --   -- See Commands section for default commands if you want to lazy load on them
  -- },
  'towolf/vim-helm',
  'xiyaowong/transparent.nvim',
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-fugitive',
  -- {
  --   'jackMort/ChatGPT.nvim',
  --   event = 'VeryLazy',
  --   config = function()
  --     require('chatgpt').setup {
  --       api_key_cmd = 'pass show openai',
  --       openai_params = {
  --         model = 'gpt-3.5-turbo',
  --       },
  --     }
  --   end,
  --   dependencies = {
  --     'MunifTanjim/nui.nvim',
  --     'nvim-lua/plenary.nvim',
  --     'folke/trouble.nvim',
  --     'nvim-telescope/telescope.nvim',
  --   },
  -- },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
  },
  {
    'ray-x/guihua.lua',
    lazy = true,
  },
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup {
        tag_transform = 'camelcase',
      }
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      require('dapui').setup()
    end,
  },
  {
    'leoluz/nvim-dap-go',
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('dap-go').setup()
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    event = 'VeryLazy',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
  },
  { 'numToStr/Comment.nvim', event = 'VeryLazy', opts = {} },
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      -- require('which-key').register {
      --   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      --   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      --   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      --   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      --   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      -- }
    end,
  },
  -- { -- Fuzzy Finder (files, lsp, etc)
  --   'nvim-telescope/telescope.nvim',
  --   event = 'VimEnter',
  --   branch = '0.1.x',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     { -- If encountering errors, see telescope-fzf-native README for install instructions
  --       'nvim-telescope/telescope-fzf-native.nvim',
  --
  --       -- `build` is used to run some command when the plugin is installed/updated.
  --       -- This is only run then, not every time Neovim starts up.
  --       build = 'make',
  --
  --       -- `cond` is a condition used to determine whether this plugin should be
  --       -- installed and loaded.
  --       cond = function()
  --         return vim.fn.executable 'make' == 1
  --       end,
  --     },
  --     { 'nvim-telescope/telescope-ui-select.nvim' },
  --
  --     -- Useful for getting pretty icons, but requires special font.
  --     --  If you already have a Nerd Font, or terminal set up with fallback fonts
  --     --  you can enable this
  --     -- { 'nvim-tree/nvim-web-devicons' }
  --   },
  --   config = function()
  --     require('telescope').setup {
  --       -- You can put your default mappings / updates / etc. in here
  --       --  All the info you're looking for is in `:help telescope.setup()`
  --       --
  --       -- defaults = {
  --       --   mappings = {
  --       --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
  --       --   },
  --       -- },
  --       -- pickers = {}
  --       defaults = {
  --         mappings = {
  --           i = {
  --             ['<C-j>'] = require('telescope.actions').move_selection_next,
  --             ['<C-k>'] = require('telescope.actions').move_selection_previous,
  --             ['<C-y>'] = require('telescope.actions').select_default,
  --           },
  --         },
  --       },
  --       pickers = {
  --         find_files = {
  --           find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
  --         },
  --       },
  --       extensions = {
  --         ['ui-select'] = {
  --           require('telescope.themes').get_dropdown(),
  --         },
  --       },
  --     }
  --
  --     -- Enable telescope extensions, if they are installed
  --     pcall(require('telescope').load_extension, 'fzf')
  --     pcall(require('telescope').load_extension, 'ui-select')
  --
  --     -- See `:help telescope.builtin`
  --     local builtin = require 'telescope.builtin'
  --     vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  --     vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  --     vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  --     vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  --     vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  --     vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  --     vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  --     vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  --     vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  --     vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
  --
  --     -- Slightly advanced example of overriding default behavior and theme
  --     vim.keymap.set('n', '<leader>/', function()
  --       -- You can pass additional configuration to telescope to change theme, layout, etc.
  --       builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
  --         winblend = 10,
  --         previewer = false,
  --       })
  --     end, { desc = '[/] Fuzzily search in current buffer' })
  --
  --     -- Also possible to pass additional configuration options.
  --     --  See `:help telescope.builtin.live_grep()` for information about particular keys
  --     vim.keymap.set('n', '<leader>s/', function()
  --       builtin.live_grep {
  --         grep_open_files = true,
  --         prompt_title = 'Live Grep in Open Files',
  --       }
  --     end, { desc = '[S]earch [/] in Open Files' })
  --
  --     -- Shortcut for searching your neovim configuration files
  --     vim.keymap.set('n', '<leader>sn', function()
  --       builtin.find_files { cwd = vim.fn.stdpath 'config' }
  --     end, { desc = '[S]earch [N]eovim files' })
  --   end,
  -- },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-T>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        -- clangd = {},
        gopls = {},
        terraformls = {},
        helm_ls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'terraform-ls',
        'gopls',
        'helm-ls',
        'golangci-lint',
        'tflint',
        'bash-language-server',
        'buf',
        'jsonlint',
        'delve',
        'tailwindcss-language-server',
        'templ',
        'html-lsp',
        'htmx-lsp',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = 'VeryLazy',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    event = 'VeryLazy',
    ft = 'markdown',
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',
      'nvim-treesitter',
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
    },
    opts = {
      ui = {
        enable = false,
      },
      workspaces = {
        {
          name = 'personal',
          path = '~/second-brain',
        },
      },
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ['gf'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ['<leader>ch'] = {
          action = function()
            return require('obsidian').util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
      },
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = 'dailies',
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = '%Y-%m-%d',
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = '%B %-d, %Y',
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil,
      },
      note_id_func = function(title)
        if title == nil then
          local suffix = string.char(math.random(65, 90))
          return title:tostring(os.time()) .. '-' .. suffix
        end
        return title
      end,
      notes_subdir = 'zettelkasten',
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      attachments = {
        img_folder = 'attachments',
      },
    },
  },
  {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        prompt_save_on_select_new_entry = false,
        view_options = {
          show_hidden = true,
          natural_order = true,
          is_always_hidden = function(name, _)
            return name == '..' or name == '.git'
          end,
        },
      }
    end,
  },
  { 'godlygeek/tabular', event = 'VeryLazy' },
  -- {
  --   'kevinhwang91/nvim-ufo',
  --   event = 'VeryLazy',
  --   requires = 'kevinhwang91/promise-async',
  --   config = function()
  --     require('ufo').setup {
  --       fold_virt_text_handler = foldHandler,
  --       provider_selector = function(bufnr, filetype, buftype)
  --         return { 'treesitter', 'indent' }
  --       end,
  --     }
  --   end,
  -- },
  { 'kevinhwang91/promise-async', lazy = true },
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'ThePrimeagen/harpoon',
    event = 'VeryLazy',
    config = function()
      require('harpoon').setup {
        tabline = true,
        tabline_prefix = ' %m ',
        tabline_suffix = ' %m ',
      }
    end,
  },
  -- {
  --   'NeogitOrg/neogit',
  --   keys = {
  --     { '<leader>gg', ':Neogit<CR>', desc = 'Neogit' },
  --   },
  --   dependencies = {
  --     'nvim-lua/plenary.nvim', -- required
  --     'nvim-telescope/telescope.nvim', -- optional
  --     'sindrets/diffview.nvim', -- optional
  --     'ibhagwan/fzf-lua', -- optional
  --   },
  --   config = true,
  -- },
  -- { -- Autocompletion
  --   'hrsh7th/nvim-cmp',
  --   event = 'InsertEnter',
  --   dependencies = {
  --     {
  --       'L3MON4D3/LuaSnip',
  --       build = (function()
  --         -- Build Step is needed for regex support in snippets
  --         -- This step is not supported in many windows environments
  --         -- Remove the below condition to re-enable on windows
  --         if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
  --           return
  --         end
  --         return 'make install_jsregexp'
  --       end)(),
  --     },
  --     'saadparwaiz1/cmp_luasnip',
  --
  --     -- Adds other completion capabilities.
  --     --  nvim-cmp does not ship with all sources by default. They are split
  --     --  into multiple repos for maintenance purposes.
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-path',
  --     'hrsh7th/cmp-buffer',
  --     'rafamadriz/friendly-snippets',
  --     -- If you want to add a bunch of pre-configured snippets,
  --     --    you can use this plugin to help you. It even has snippets
  --     --    for various frameworks/libraries/etc. but you will have to
  --     --    set up the ones that are useful for you.
  --   },
  --   config = function()
  --     -- See `:help cmp`
  --     local cmp = require 'cmp'
  --     local luasnip = require 'luasnip'
  --     luasnip.config.setup {}
  --
  --     cmp.setup {
  --       sorting = {
  --         priority_weight = 2,
  --         comparators = {
  --           -- Below is the default comparitor list and order for nvim-cmp
  --           cmp.config.compare.offset,
  --           -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
  --           cmp.config.compare.exact,
  --           cmp.config.compare.score,
  --           cmp.config.compare.recently_used,
  --           cmp.config.compare.locality,
  --           cmp.config.compare.kind,
  --           cmp.config.compare.sort_text,
  --           cmp.config.compare.length,
  --           cmp.config.compare.order,
  --         },
  --       },
  --       snippet = {
  --         expand = function(args)
  --           luasnip.lsp_expand(args.body)
  --         end,
  --       },
  --       completion = { completeopt = 'menu,menuone,noinsert' },
  --
  --       -- For an understanding of why these mappings were
  --       -- chosen, you will need to read `:help ins-completion`
  --       --
  --       -- No, but seriously. Please read `:help ins-completion`, it is really good!
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered(),
  --       },
  --       mapping = cmp.mapping.preset.insert {
  --         -- Select the [n]ext item
  --         ['<C-j>'] = cmp.mapping.select_next_item(),
  --         -- Select the [p]revious item
  --         ['<C-k>'] = cmp.mapping.select_prev_item(),
  --
  --         -- Accept ([y]es) the completion.
  --         --  This will auto-import if your LSP supports it.
  --         --  This will expand snippets if the LSP sent a snippet.
  --         ['<C-y>'] = cmp.mapping.confirm { select = true },
  --
  --         -- Manually trigger a completion from nvim-cmp.
  --         --  Generally you don't need this, because nvim-cmp will display
  --         --  completions whenever it has completion options available.
  --         ['<C-Space>'] = cmp.mapping.complete {},
  --
  --         -- Think of <c-l> as moving to the right of your snippet expansion.
  --         --  So if you have a snippet that's like:
  --         --  function $name($args)
  --         --    $body
  --         --  end
  --         --
  --         -- <c-l> will move you to the right of each of the expansion locations.
  --         -- <c-h> is similar, except moving you backwards.
  --         ['<C-l>'] = cmp.mapping(function()
  --           if luasnip.expand_or_locally_jumpable() then
  --             luasnip.expand_or_jump()
  --           end
  --         end, { 'i', 's' }),
  --         ['<C-h>'] = cmp.mapping(function()
  --           if luasnip.locally_jumpable(-1) then
  --             luasnip.jump(-1)
  --           end
  --         end, { 'i', 's' }),
  --       },
  --       sources = {
  --         { name = 'copilot', group_index = 2 },
  --         { name = 'nvim_lsp' },
  --         { name = 'luasnip' },
  --         { name = 'path' },
  --         { name = 'buffer' },
  --       },
  --     }
  --   end,
  -- },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
    'ellisonleao/gruvbox.nvim',
    -- 'folke/tokyonight.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Load the colorscheme here
      -- vim.o.background = 'dark'
      -- vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like
      -- vim.cmd.hi 'Comment gui=none'
      require('gruvbox').setup {
        -- terminal_colors = true, -- add neovim terminal colors
        -- undercurl = true,
        -- underline = true,
        -- bold = true,
        -- italic = {
        --   strings = true,
        --   emphasis = true,
        --   comments = true,
        --   operators = false,
        --   folds = true,
        -- },
        -- strikethrough = true,
        -- invert_selection = false,
        -- invert_signs = false,
        -- invert_tabline = false,
        -- inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = 'hard', -- can be "hard", "soft" or empty string
        -- palette_overrides = {},
        -- overrides = {},
        -- dim_inactive = false,
        -- transparent_mode = false,
      }
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    version = '*',
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      explorer = {
        enabled = true,
      },
      -- indent = { enabled = true },
      input = { enabled = true },
      picker = {
        files = {
          show_hidden = true,
        },
        enabled = true,
        formatters = {
          file = {
            truncate = 80,
          },
        },
      },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      -- Top Pickers & Explorer
      {
        '<leader><space>',
        function()
          Snacks.picker.smart()
        end,
        desc = 'Smart Find Files',
      },
      {
        '<leader>,',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>/',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>:',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      {
        '<leader>n',
        function()
          Snacks.picker.notifications()
        end,
        desc = 'Notification History',
      },
      {
        '<leader>e',
        function()
          Snacks.explorer()
        end,
        desc = 'File Explorer',
      },
      -- find
      {
        '<leader>fb',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>fc',
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = 'Find Config File',
      },
      {
        '<leader>ff',
        function()
          Snacks.picker.files()
        end,
        desc = 'Find Files',
      },
      {
        '<leader>fg',
        function()
          Snacks.picker.git_files()
        end,
        desc = 'Find Git Files',
      },
      {
        '<leader>fp',
        function()
          Snacks.picker.projects()
        end,
        desc = 'Projects',
      },
      {
        '<leader>fr',
        function()
          Snacks.picker.recent()
        end,
        desc = 'Recent',
      },
      -- git
      {
        '<leader>gb',
        function()
          Snacks.picker.git_branches()
        end,
        desc = 'Git Branches',
      },
      {
        '<leader>gl',
        function()
          Snacks.picker.git_log()
        end,
        desc = 'Git Log',
      },
      {
        '<leader>gL',
        function()
          Snacks.picker.git_log_line()
        end,
        desc = 'Git Log Line',
      },
      {
        '<leader>gs',
        function()
          Snacks.picker.git_status()
        end,
        desc = 'Git Status',
      },
      {
        '<leader>gS',
        function()
          Snacks.picker.git_stash()
        end,
        desc = 'Git Stash',
      },
      {
        '<leader>gd',
        function()
          Snacks.picker.git_diff()
        end,
        desc = 'Git Diff (Hunks)',
      },
      {
        '<leader>gf',
        function()
          Snacks.picker.git_log_file()
        end,
        desc = 'Git Log File',
      },
      -- Grep
      {
        '<leader>sb',
        function()
          Snacks.picker.lines()
        end,
        desc = 'Buffer Lines',
      },
      {
        '<leader>sB',
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = 'Grep Open Buffers',
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        desc = 'Visual selection or word',
        mode = { 'n', 'x' },
      },
      -- search
      {
        '<leader>s"',
        function()
          Snacks.picker.registers()
        end,
        desc = 'Registers',
      },
      {
        '<leader>s/',
        function()
          Snacks.picker.search_history()
        end,
        desc = 'Search History',
      },
      {
        '<leader>sa',
        function()
          Snacks.picker.autocmds()
        end,
        desc = 'Autocmds',
      },
      {
        '<leader>sb',
        function()
          Snacks.picker.lines()
        end,
        desc = 'Buffer Lines',
      },
      {
        '<leader>sc',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      {
        '<leader>sC',
        function()
          Snacks.picker.commands()
        end,
        desc = 'Commands',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = 'Diagnostics',
      },
      {
        '<leader>sD',
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = 'Buffer Diagnostics',
      },
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = 'Help Pages',
      },
      {
        '<leader>sH',
        function()
          Snacks.picker.highlights()
        end,
        desc = 'Highlights',
      },
      {
        '<leader>si',
        function()
          Snacks.picker.icons()
        end,
        desc = 'Icons',
      },
      {
        '<leader>sj',
        function()
          Snacks.picker.jumps()
        end,
        desc = 'Jumps',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = 'Keymaps',
      },
      {
        '<leader>sl',
        function()
          Snacks.picker.loclist()
        end,
        desc = 'Location List',
      },
      {
        '<leader>sm',
        function()
          Snacks.picker.marks()
        end,
        desc = 'Marks',
      },
      {
        '<leader>sM',
        function()
          Snacks.picker.man()
        end,
        desc = 'Man Pages',
      },
      {
        '<leader>sp',
        function()
          Snacks.picker.lazy()
        end,
        desc = 'Search for Plugin Spec',
      },
      {
        '<leader>sq',
        function()
          Snacks.picker.qflist()
        end,
        desc = 'Quickfix List',
      },
      {
        '<leader>sR',
        function()
          Snacks.picker.resume()
        end,
        desc = 'Resume',
      },
      {
        '<leader>su',
        function()
          Snacks.picker.undo()
        end,
        desc = 'Undo History',
      },
      {
        '<leader>uC',
        function()
          Snacks.picker.colorschemes()
        end,
        desc = 'Colorschemes',
      },
      -- LSP
      {
        'gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        'gD',
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = 'Goto Declaration',
      },
      {
        'gr',
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = 'References',
      },
      {
        'gI',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        'gy',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = 'LSP Symbols',
      },
      {
        '<leader>sS',
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = 'LSP Workspace Symbols',
      },
      -- Other
      {
        '<leader>z',
        function()
          Snacks.zen()
        end,
        desc = 'Toggle Zen Mode',
      },
      {
        '<leader>Z',
        function()
          Snacks.zen.zoom()
        end,
        desc = 'Toggle Zoom',
      },
      {
        '<leader>.',
        function()
          Snacks.scratch()
        end,
        desc = 'Toggle Scratch Buffer',
      },
      {
        '<leader>S',
        function()
          Snacks.scratch.select()
        end,
        desc = 'Select Scratch Buffer',
      },
      {
        '<leader>n',
        function()
          Snacks.notifier.show_history()
        end,
        desc = 'Notification History',
      },
      {
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>cR',
        function()
          Snacks.rename.rename_file()
        end,
        desc = 'Rename File',
      },
      {
        '<leader>gB',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Git Browse',
        mode = { 'n', 'v' },
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>un',
        function()
          Snacks.notifier.hide()
        end,
        desc = 'Dismiss All Notifications',
      },
      {
        '<c-/>',
        function()
          Snacks.terminal()
        end,
        desc = 'Toggle Terminal',
      },
      {
        '<c-_>',
        function()
          Snacks.terminal()
        end,
        desc = 'which_key_ignore',
      },
      {
        ']]',
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = 'Next Reference',
        mode = { 'n', 't' },
      },
      {
        '[[',
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = 'Prev Reference',
        mode = { 'n', 't' },
      },
      {
        '<leader>N',
        desc = 'Neovim News',
        function()
          Snacks.win {
            file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = 'yes',
              statuscolumn = ' ',
              conceallevel = 3,
            },
          }
        end,
      },
    },
  },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = 'copilot',
      -- provider = 'claude',
      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-3-5-haiku-20241022',
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 8096,
          },
        },
        openai = {
          endpoint = 'https://api.openai.com/v1',
          model = 'gpt-4o', -- your desired model (or use gpt-4o, etc.)
          timeout = 30000, -- timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 8096,
          },
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'echasnovski/mini.pick', -- for file_selector provider mini.pick
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'ibhagwan/fzf-lua', -- for file_selector provider fzf
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }
      require('mini.operators').setup()

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      statusline.setup()
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'c',
          'html',
          'lua',
          'markdown',
          'markdown_inline',
          'vim',
          'vimdoc',
          'go',
          'proto',
          'yaml',
          'terraform',
          'json',
          'java',
          'dockerfile',
          'templ',
          'helm',
          'http',
        },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        -- indent = { enable = true },
      }

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'VeryLazy',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- put them in the right spots if you want.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for kickstart
  --
  --  Here are some example plugins that I've included in the kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}

require 'lsp'
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
