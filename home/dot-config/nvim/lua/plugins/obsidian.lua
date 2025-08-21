return {
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
        path = '~/second-brain/personal',
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
      folder = 'dailies/journal',
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = '%Y-%m-%d',
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = '%B %-d, %Y',
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = 'dailies/journal/template.md',
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
      img_folder = '_base/files/images',
    },
  },
}
