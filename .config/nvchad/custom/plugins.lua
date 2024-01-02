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
  {
    "huynle/ogpt.nvim",
    event = "VeryLazy",
    config = function()
      require("ogpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {"mfussenegger/nvim-dap"},
    config = function ()
      require("dapui").setup()
    end
  },
  {
    "leoluz/nvim-dap-go",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap"
    },
    config = function ()
     require("dap-go").setup()
    end
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },
  { "unamatasanatarai/nvim-md-todo-toggle",
    event = "VeryLazy",
	  ft = "md",
    config = function ()
     require("nvim-md-todo-toggle").setup()
    end
  },
  {"hrsh7th/cmp-emoji",
    lazy = true
  },
  {"hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-emoji"
    },
    config = function ()
      local cmp = require("cmp")
      cmp.setup({
        matching = {
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        completion = {
          keyword_length = 1,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = { -- different source for the completion
          {
            name = "nvim_lsp",
            max_item_count = 15,
          },
          {
            name = "luasnip",
            keyword_length = 2,
          },
          {
            name = "buffer",
            keyword_length = 2,
          },
          {
            name = "nvim_lua",
            keyword_length = 2,
          },
          {
            name = "obsidian",
          },
          {
            name = "obsidian_new",
          },
          {
            name = "emoji",
          },
        },
      })
      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

    end
  },
  {  "epwalsh/obsidian.nvim",
    keys = {
      { "<leader>o", ":ObsidianQuickSwitch<CR>", desc = "Obsidian quickswitch" },
      { "<leader>n", ":ObsidianSearch<CR>", desc = "Obsidian Search" },
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- optional
      -- "hrsh7th/nvim-cmp",
      -- see below for full list of optional dependencies 👇
    },
    opts = {
      dir = "~/second-brain",
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "private/dailies",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil,
      },

      notes_subdir = "private/zettelkasten",
      note_id_func = function(title)
        if title ~= nil then
          title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        end
        return title
      end,
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        -- vim.fn.jobstart({"open", url})  -- Mac OS
        vim.fn.jobstart({"browse", url})  -- linux
      end,
      -- Optional, completion.
      completion = {
        -- If using nvim-cmp, otherwise set to false
        nvim_cmp = true,
        -- Trigger completion at 2 chars
        min_chars = 2,
        -- Where to put new notes created from completion. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "notes_subdir",

        -- Whether to add the output of the node_id_func to new notes in autocompletion.
        -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
        prepend_note_id = true
      },
      overwrite_mappings = true
    },
  },
  {  'godlygeek/tabular',
    lazy = false
  },
  {  'plasticboy/vim-markdown',
    branch = 'master',
    require = {'godlygeek/tabular'},
    ft = "md"
  },
  {    'kevinhwang91/nvim-ufo',
    event = "VeryLazy",
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
    event = "VeryLazy",
  },
  {    "towolf/vim-helm",
    event = "VeryLazy",
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
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" }, },
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
