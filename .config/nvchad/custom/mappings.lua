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
  },
}

M.general = {
  i = {
    ["<C-s>"] = { "<ESC>:wa<CR>", "Save all", opts = { nowait = true } },
  },
  n = {
    ["<C-s>"]            = { ":wa<CR>", "Save all", opts                                                   = { nowait = true } },
   ["<leader>h"]        = { "<C-w>h", "window left" },
    ["<leader>l"]        = { "<C-w>l", "window right" },
    ["<leader>j"]        = { "<C-w>j", "window down" },
    ["<leader>k"]        = { "<C-w>k", "window up" },

    ["<C-u>"]      = { "<C-u>zz", "Go up", opts                                                      = { nowait = true } },
    ["<C-d>"]      = { "<C-d>zz", "Go down", opts                                                    = { nowait = true } },

    ['zR']         = {":lua require('ufo').openAllFolds()<CR>"},
    ['zM']         = {":lua require('ufo').closeAllFolds()<CR>"},
    ["<leader>e"]  = { ":Neotree toggle<CR>", "toggle explorer" },

    ["<leader>sa"]    = { ":lua require(\"spectre\").toggle()<CR>", "Toggle Spectre", opts           = { nowait = true } },
    ["<leader>sw"]    = { ":lua require(\"spectre\").open_visual({select_word=true})<CR>", "Search word", opts           = { nowait = true } },
    ["<leader>ss"]    = { ":lua require(\"spectre\").open_file_search({select_word=true})<CR>", "Toggle Spectre", opts           = { nowait = true } },

    ["x["]    = { ":lua vim.diagnostic.goto_prev()<CR>", "Prev Error", opts           = { nowait = true } },
    ["x]"]    = { ":lua vim.diagnostic.goto_next()<CR>", "Next Error", opts           = { nowait = true } },

    ["<leader>xq"]    = { ":lua require(\"trouble\").toggle(\"quickfix\")<CR>", "References", opts           = { nowait = true } },
    ["<leader>xx"]    = { ":lua require(\"trouble\").toggle()<CR>", "References", opts           = { nowait = true } },
    ["gr"]    = { ":lua require(\"trouble\").toggle(\"lsp_references\")<CR>", "References", opts           = { nowait = true } },

    ["<leader>m"]  = { ":lua require(\"harpoon.mark\").add_file()<CR>", "Add Harpoon" },
    ["<S-Tab>"]    = { ":lua require(\"harpoon.ui\").nav_prev()<CR>", "Prev Harpoon", opts           = { nowait = true } },
    ["<Tab>"]      = { ":lua require(\"harpoon.ui\").nav_next()<CR>" , "Next Harpoon", opts          = { nowait = true } },
    ["<leader>mm"] = { ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>" , "Harpoon menu", opts = { nowait = true } },

    ["<leader>v"]  = { ":vsplit<CR>", "Split screen", opts                                           = { nowait = true } },

    ["ga"]         = { ":GoAlternate<CR>", "Open test/main", opts                                    = { nowait = true } },
    ["<leader>tf"] = { ":GoTestFunc<CR>", "Run Test Func", opts                                      = { nowait = true } },
    ["<leader>tt"]  = { ":GoTest<CR>", "Run all tests", opts                                          = { nowait = true } },

    ["<leader><leader>"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>rt"]       = {"<Plug>RestNvim","Do Rest Call"},

    ["<leader>oz"]       = { ":ObsidianNew ", "New Zettel" },
    ["<leader>oj"]       = { ":ObsidianToday<CR>", "Journal" },
    ["<leader>gl"]       = { ":ObsidianFollowLink<CR>", "Follow link" },
    ["<leader>gb"]       = { ":ObsidianBacklinks<CR>", "Backlinks" },

    ["<leader>b"]       = { ":DapToggleBreakpoint<CR>", "Toggle Breakpoint" },
    ["<leader>dd"]       = { ":DapContinue<CR>", "Start Debugging" },
    ["<leader>dn"]       = { ":DapStepOver<CR>", "Debug Step Over" },

  },
  x = {
    ["<leader>sw"]    = { ":lua require(\"spectre\").open_visual()<CR>", "Search word", opts           = { nowait = true } },
    ["<leader>t"]  = { ":Tabularize /", "Tabularize" },
    ["<leader>ol"] = { ":ObsidianLink<CR>", "To Link" },
    ["<leader>on"] = { ":ObsidianLinkNew<CR>", "New Link" },
  }
}

-- more keybinds!

return M
