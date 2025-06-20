---@diagnostic disable-next-line: missing-fields
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
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
      incremental_selection = {
        enable = true,
        keymaps = {
          -- mappings for incremental selection (visual mappings)
          init_selection = 'gnn', -- maps in normal mode to init the node/scope selection
          node_incremental = 'grn', -- increment to the upper named parent
          scope_incremental = 'grc', -- increment to the upper scope (as defined in locals.scm)
          node_decremental = 'grm', -- decrement to the previous node
        },
      },

      textobjects = {
        -- syntax-aware textobjects
        enable = true,
        lsp_interop = {
          enable = true,
          peek_definition_code = {
            ['DF'] = '@function.outer',
          },
        },
        keymaps = {
          ['iL'] = {
            -- you can define your own textobjects directly here
            go = '(function_definition) @function',
          },
          -- or you use the queries from supported languages with textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['aC'] = '@class.outer',
          ['iC'] = '@class.inner',
          ['ac'] = '@conditional.outer',
          ['ic'] = '@conditional.inner',
          ['ae'] = '@block.outer',
          ['ie'] = '@block.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
          ['is'] = '@statement.inner',
          ['as'] = '@statement.outer',
          ['ad'] = '@comment.outer',
          ['am'] = '@call.outer',
          ['im'] = '@call.inner',
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']n'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']m'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        select = {
          enable = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    }
  end,
}
