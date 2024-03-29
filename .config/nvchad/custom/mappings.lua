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
    ["<C-s>"]            = { ":wa<CR>", "Save all", opts                                                    = { nowait                            = true } },
    ["<leader>h"]        = { "<C-w>h", "window left" },
    ["<leader>l"]        = { "<C-w>l", "window right" },
    ["<leader>j"]        = { "<C-w>j", "window down" },
    ["<leader>k"]        = { "<C-w>k", "window up" },

    ["<PageUp>"]         = { "<C-u>zz", "Go up", opts                                                       = { nowait                            = true } },
    ["<PageDown>"]       = { "<C-d>zz", "Go down", opts                                                       = { nowait                            = true } },
    ["<C-u>"]            = { "<C-u>zz", "Go up", opts                                                       = { nowait                            = true } },
    ["<C-d>"]            = { "<C-d>zz", "Go down", opts                                                     = { nowait                            = true } },

    ['zR']               = {":lua require('ufo').openAllFolds()<CR>"},
    ['zM']               = {":lua require('ufo').closeAllFolds()<CR>"},

    ["<leader>e"]        = { ":Neotree toggle<CR>", "toggle explorer" },

    ["<leader>sa"]       = { ":lua require(\"spectre\").toggle()<CR>", "Toggle Spectre", opts               = { nowait                            = true } },
    ["<leader>sw"] = { ":lua require(\"spectre\").open_visual({select_word = true})<CR>", "Search word", opts         = { nowait  = true } },
    ["<leader>ss"] = { ":lua require(\"spectre\").open_file_search({select_word = true})<CR>", "Toggle Spectre", opts = { nowait  = true } },

    ["z["]               = { ":lua vim.diagnostic.goto_prev()<CR>", "Prev Error", opts                      = { nowait                            = true } },
    ["z]"]               = { ":lua vim.diagnostic.goto_next()<CR>", "Next Error", opts                      = { nowait                            = true } },
    ["<leader>xq"]       = { ":lua require(\"trouble\").toggle(\"quickfix\")<CR>", "Errors quickfix", opts       = { nowait                            = true } },
    ["<leader>xx"]       = { ":lua require(\"trouble\").toggle()<CR>", "Errors", opts                   = { nowait                            = true } },

    ["<leader>m"]        = { ":lua require(\"harpoon.mark\").add_file()<CR>", "Add Harpoon" },
    ["<S-Tab>"]          = { ":lua require(\"harpoon.ui\").nav_prev()<CR>", "Prev Harpoon", opts            = { nowait                            = true } },
    ["<Tab>"]            = { ":lua require(\"harpoon.ui\").nav_next()<CR>" , "Next Harpoon", opts           = { nowait                            = true } },
    ["<leader>mm"]       = { ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>" , "Harpoon menu", opts  = { nowait                            = true } },

    ["<leader>v"]        = { ":vsplit<CR>", "Split screen", opts                                            = { nowait                            = true } },

    ["gr"]               = { ":lua require(\"trouble\").toggle(\"lsp_references\")<CR>", "References", opts = { nowait                            = true } },
    ["ga"]               = { ":GoAlternate<CR>", "Open test/main", opts                                     = { nowait                            = true } },

    ["<leader>tf"]       = { ":GoTestFunc<CR>", "Run Test Func", opts                                       = { nowait                            = true } },
    ["<leader>tc"]       = { ":GoCoverageToggle<CR>", "Toggle Coverage", opts                                       = { nowait                            = true } },
    ["<leader>tt"]       = { ":GoTest<CR>", "Run all tests", opts                                           = { nowait                            = true } },

    ["<leader><leader>"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>ba"] = { ":%bd|e#|bd#<CR>", "Close all buffers" },
    ["<leader>bb"] = { ":bd<CR>", "Close buffer" },

    ["<leader>rt"]       = {"<Plug>RestNvim","Do Rest Call"},

    ["<leader>n"]       = {":Noice dismiss<CR>","Dismiss messages"},

    ["<leader>oi"] = { ":ObsidianPasteImg<CR>", "Obsidian Paste Image" },
    ["<leader>owt"] = { ":ObsidianWorkspace team<CR>", "Obsidian Team Workspace" },
    ["<leader>owp"] = { ":ObsidianWorkspace personal<CR>", "Obsidian Personal Workspace" },
    ["<leader>owd"] = { ":ObsidianWorkspace default<CR>", "Obsidian Default Workspace" },
    ["<leader>oq"]  = { ":ObsidianQuickSwitch<CR>", "ObsidianQuickSwitch" },
    ["<leader>os"]  = { ":ObsidianSearch<CR>", "Obsidian Search" },
    ["<leader>opz"]  = { ":ObsidianWorkspace personal<CR>:ObsidianNew ", "New Personal Zettel" },
    ["<leader>otz"]  = { ":ObsidianWorkspace team<CR>:ObsidianNew ", "New Team Zettel" },
    ["<leader>oz"]  = { ":ObsidianNew ", "New Zettel" },
    ["<leader>oj"]  = { ":ObsidianToday<CR>", "Journal" },
    ["<leader>ob"]  = { ":ObsidianBacklinks<CR>", "Backlinks" },

    ["<leader>db"]  = { ":DapToggleBreakpoint<CR>", "Toggle Breakpoint" },
    ["<leader>ds"]  = { ":DapContinue<CR>", "Start Debugging" },
    ["<C-l>"]       = { ":DapStepInto<CR>", "Debug Step Into" },
    ["<C-j>"]       = { ":DapStepOver<CR>", "Debug Step Over" },
    ["<leader>dt"]  = { ":DapTerminate<CR>", "Debug Terminate" },
    ["<leader>de"]  = { ":lua require(\"dapui\").eval()<CR>", "Debug evaluate" },

  },
  x = {
    ["<leader>sw"] = { ":lua require(\"spectre\").open_visual()<CR>", "Search word", opts = { nowait = true } },
    ["<leader>t"]  = { ":Tabularize /", "Tabularize" },
    ["<leader>ol"] = { ":ObsidianLink<CR>", "To Link" },
    ["<leader>on"] = { ":ObsidianLinkNew<CR>", "New Link" },
    ["<leader>de"] = { ":lua require(\"dapui\").eval()<CR>", "Debug evaluate" },
  }
}

return M
