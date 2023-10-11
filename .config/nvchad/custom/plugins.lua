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
  { "unamatasanatarai/nvim-md-todo-toggle",
    lazy = false,
	  ft = "md",
    config = function ()
     require("nvim-md-todo-toggle").setup()
    end
  },
  {"hrsh7th/nvim-cmp",
    config = function ()
      local border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
      local cmp = require("cmp")
      cmp.setup({
        matching = {
          -- disallow_fuzzy_matching = false,
          -- disallow_fullfuzzy_matching = true,
          -- disallow_partial_fuzzy_matching = true,
          -- disallow_partial_matching = true,
          -- disallow_prefix_unmatching = false,
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        completion = {
          keyword_length = 1,
        },
        window = {
          documentation = {
            border = border,
            max_width = 80,
            max_hight = 30,
            winhighlight = "NormalFloat:NormalFloat,NonText:NonText,Special:Constant",
          },
          completion = {
            border = border,
            col_offset = 30,
            side_padding = 0,
            winhighlight = "NormalFloat:NormalFloat",
          },
        },
        experimental = { ghost_text = true },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            -- load lspkind icons
            vim_item.menu = ({
              nvim_lsp = "(LSP)",
              emoji = "(Emoji)",
              path = "(Path)",
              calc = "(Calc)",
              vsnip = "(Snippet)",
              luasnip = "(Snippet)",
              buffer = "(Buffer)",
            })[entry.source.name]

            return vim_item
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-2),
          ["<C-d>"] = cmp.mapping.scroll_docs(2),
          -- ["<C-l>"] = cmp.mapping.complete(),
          ["<C-x>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
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
        },
        sources = { -- different source for the completion
          {
            name = "nvim_lsp",
            max_item_count = 15,
          },
          {
            name = "neorg",
            keyword_length = 2,
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
      "hrsh7th/nvim-cmp",
      -- see below for full list of optional dependencies 👇
    },
    opts = {
      dir = "~/second-brain",
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "notes/dailies",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil,
      },

      -- Optional, completion.
      completion = {
        -- If using nvim-cmp, otherwise set to false
        nvim_cmp = true,
        -- Trigger completion at 2 chars
        min_chars = 2,
        -- Where to put new notes created from completion. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "current_dir",

        -- Whether to add the output of the node_id_func to new notes in autocompletion.
        -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
        prepend_note_id = true
      },     -- see below for full list of options 👇
      overwrite_mappings = true
    },
  },
  {  'godlygeek/tabular',
    lazy = false
  },
  {  'plasticboy/vim-markdown',
    branch = 'master',
    require = {'godlygeek/tabular'},
    lazy = false,
    ft = "md"
  },
  {    'kevinhwang91/nvim-ufo',
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
    ft = {"go","mod","sum"},
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
