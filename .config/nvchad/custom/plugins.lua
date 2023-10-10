local overrides = require("custom.configs.overrides")

local foldHandler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

---@type NvPluginSpec[]
local plugins = {
  {  'kevinhwang91/nvim-ufo',
    lazy = false,
    requires = 'kevinhwang91/promise-async',
    config = function()
      require('ufo').setup({
        fold_virt_text_handler = foldHandler,
        provider_selector = function(bufnr, filetype, buftype)
            return {'treesitter', 'indent'}
        end
       })
    end,
  },
  {    'kevinhwang91/promise-async',
    lazy = true,
  },
  {    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {  "ThePrimeagen/refactoring.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup({
        prompt_func_return_type = {
          go = true,
        },
        prompt_func_param_type = {
            go = true,
        },
      })
    end,
  },
  { "ThePrimeagen/harpoon",
    lazy = false,
    config = function()
      require("harpoon").setup({
        tabline = true,
        tabline_prefix = " %m ",
        tabline_suffix = " %m "
      })
    end
  },
  {    "NeogitOrg/neogit",
    keys = {
      { "<leader>gg", ":Neogit kind=vsplit<CR>", desc = "Neogit split" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  },
  {    "tpope/vim-fugitive",
    lazy = false
  },
  {    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>oi", ":Neorg index<CR>", desc = "Neorg index" },
      { "<leader>oj", ":Neorg journal today<CR>", desc = "Neorg journal" },
      { "<leader>ok", ":Neorg journal ", desc = "Neorg journal" },
    },
    -- ft = "norg",
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/second-brain",
                work = "~/work-brain",
              },
              default_workspace = "notes"
            },
          },
        },
      }
    end,
  },
  {    "rest-nvim/rest.nvim",
    keys = {
      { "<leader>rt", "<Plug>RestNvim", desc = "Rest Call" },
    },
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Keep the http file buffer above|left when split horizontal|vertical
        result_split_in_place = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Encode URL before making request
        encode_url = true,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          show_http_info = true,
          show_headers = true,
          -- executables or functions for formatting response body [optional]
          -- set them to false if you want to disable them
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
            end
          },
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end
  },
  {    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  {    "fatih/vim-go",
    ft = "go",
  },
  {    "towolf/vim-helm",
    ft = {"yml","yaml"},
  },
  {    "williamboman/mason.nvim",
    opts = overrides.mason
  },
  {    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  {      "nvim-neo-tree/neo-tree.nvim",
      lazy = false,
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      }
  },
  {    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = function()
      require'nvim-treesitter.configs'.setup {
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ii"] = "@conditional.inner",
              ["ai"] = "@conditional.outer",
              ["il"] = "@loop.inner",
              ["al"] = "@loop.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
          },
        },
      }
    end,
  }
}

return plugins
