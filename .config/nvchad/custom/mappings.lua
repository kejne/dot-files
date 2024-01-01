---@type MappingsTable
local M = {}

M.disabled = {
  n = {
      ["<leader>h"]  = "",
      ["<C-a>"]      = "",
      ["<C-h>"]      = "",
      ["<C-k>"]      = "",
      ["<C-j>"]      = "",
      ["<C-l>"]      = "",
      ["<C-n>"]      = "",
      ["<C-s>"]      = "",
      ["<leader>l"]  = "",
      ["<leader>e"]  = "",
      ["<leader>fb"] = "",
      ["<leader>ma"] = "",
      ["jj"] = "",
  },
}

M.general = {
  i = {
    ["hh"] = { "<ESC>", "Quick esc", opts = { nowait = true } },
    ["<C-s>"] = { "<ESC>:wa<CR>", "Save all", opts = { nowait = true } },
  },
  n = {
    ["<C-s>"]            = { ":wa<CR>", "Save all", opts                                                   = { nowait = true } },

    ["<leader>m"]  = { "<C-w>h", "window left" , opts                                                = { nowait = true }},
    ["<leader>i"]  = { "<C-w>l", "window right", opts                                                = { nowait = true } },
    ["<leader>n"]  = { "<C-w>j", "window down", opts                                                 = { nowait = true } },
    ["<leader>e"]  = { "<C-w>k", "window up", opts                                                   = { nowait = true } },

    ["<C-u>"]      = { "<C-u>zz", "Go up", opts                                                      = { nowait = true } },
    ["<C-d>"]      = { "<C-d>zz", "Go down", opts                                                    = { nowait = true } },

    ['zR']         = {":lua require('ufo').openAllFolds()<CR>"},
    ['zM']         = {":lua require('ufo').closeAllFolds()<CR>"},
    ["<leader>o"]  = { ":Neotree toggle<CR>", "toggle explorer" },
    ["<leader>s"]  = {":%s/","Substitute"},

    ["<leader>h"]  = { ":lua require(\"harpoon.mark\").add_file()<CR>", "Add Harpoon" },
    ["<S-Tab>"]    = { ":lua require(\"harpoon.ui\").nav_prev()<CR>", "Prev Harpoon", opts           = { nowait = true } },
    ["<Tab>"]      = { ":lua require(\"harpoon.ui\").nav_next()<CR>" , "Next Harpoon", opts          = { nowait = true } },
    ["<leader>hm"] = { ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>" , "Harpoon menu", opts = { nowait = true } },

    ["<leader>v"]  = { ":vsplit<CR>", "Split screen", opts                                           = { nowait = true } },

    ["gr"]         = { ":GoReferrers<CR>", "Go to referrers", opts                                   = { nowait = true } },
    ["ga"]         = { ":GoAlternate<CR>", "Open test/main", opts                                    = { nowait = true } },
    ["<leader>tf"] = { ":GoTestFunc<CR>", "Run Test Func", opts                                      = { nowait = true } },
    ["<leader>t"]  = { ":GoTest<CR>", "Run all tests", opts                                          = { nowait = true } },

    ["<leader><leader>"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>rt"]       = {"<Plug>RestNvim","Do Rest Call"},

    ["<leader>jz"]       = { ":ObsidianNew ", "New Zettel" },
    ["<leader>jj"]       = { ":ObsidianToday<CR>", "Journal" },
    ["<leader>gl"]       = { ":ObsidianFollowLink<CR>", "Follow link" },
    ["<leader>gb"]       = { ":ObsidianBacklinks<CR>", "Backlinks" },
    ["<leader>ta"]       = { ":TDAdd<CR>", "Add MD task" },
    ["<leader>tt"]       = { ":TDToggle<CR>", "Toggle MD task" },
  },
  x = {
    ["<leader>t"]  = { ":Tabularize /", "Tabularize" },
    ["<leader>ol"] = { ":ObsidianLink<CR>", "To Link" },
    ["<leader>on"] = { ":ObsidianLinkNew<CR>", "New Link" },
  }
}

-- more keybinds!

return M
