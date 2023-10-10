---@type MappingsTable
local M = {}

M.disabled = {
  n = {
      ["<leader>h"] = "",
      ["<C-a>"] = "",
      ["<C-h>"] = "",
      ["<C-k>"] = "",
      ["<C-j>"] = "",
      ["<C-l>"] = "",
      ["<C-n>"] = "",
      ["<C-s>"] = "",
      ["<leader>l"] = "",
      ["<leader>e"] = "",
      ["<leader>fb"] = "",
      ["<Up>"] = {"<NOP>"},
      ["<Down>"]={"<NOP>"},
      ["<Right>"]={"<NOP>"},
      ["<Left>"]={"<NOP>"},
  },
  i = {
      ["<Up>"] = "",
      ["<Down>"]="",
      ["<Right>"]="",
      ["<Left>"]="",
  }
}

M.general = {
  i = {
    ["<C-s>"] = { "<ESC>:wa<CR>", "Save all", opts = { nowait = true } },
  },
  n = {
    ["<C-s>"] = { ":wa<CR>", "Save all", opts = { nowait = true } },

    ["<leader>h"] = { "<C-w>h", "window left" },
    ["<leader>l"] = { "<C-w>l", "window right" },
    ["<leader>j"] = { "<C-w>j", "window down" },
    ["<leader>k"] = { "<C-w>k", "window up" },

    ["<C-u>"] = { "<C-u>zz", "Go up", opts = { nowait = true } },
    ["<C-d>"] = { "<C-d>zz", "Go down", opts = { nowait = true } },

    ['zR'] = {":lua require('ufo').openAllFolds()<CR>"},
    ['zM'] = {":lua require('ufo').closeAllFolds()<CR>"},
    ["<leader>e"] = { ":Neotree toggle<CR>", "toggle explorer" },
    ["<leader>s"] = {":%s/","Substitute"},

    ["<leader>m"] = { ":lua require(\"harpoon.mark\").add_file()<CR>", "Add Harpoon", opts = { nowait = true } },
    ["<S-Tab>"] = { ":lua require(\"harpoon.ui\").nav_prev()<CR>", "Prev Harpoon", opts = { nowait = true } },
    ["<Tab>"] = { ":lua require(\"harpoon.ui\").nav_next()<CR>" , "Next Harpoon", opts = { nowait = true } },
    ["<leader>q"] = { ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>" , "Harpoon menu", opts = { nowait = true } },

    ["<leader>v"] = { ":vsplit<CR>", "Split screen", opts = { nowait = true } },

    ["gr"] = { ":GoReferrers<CR>", "Go to referrers", opts = { nowait = true } },
    ["ga"] = { ":GoAlternate<CR>", "Open test/main", opts = { nowait = true } },
    ["<leader>tf"] = { ":GoTestFunc<CR>", "Run Test Func", opts = { nowait = true } },
    ["<leader>t"] = { ":GoTest<CR>", "Run all tests", opts = { nowait = true } },

    ["<leader><leader>"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>rt"] = {"<Plug>RestNvim","Do Rest Call"},
    ["<leader>rr"] = {":lua require('refactoring').select_refactor()<CR>"},
    ["<leader>re"] = { ":Refactor extract<CR>", " Extract Function"},
    ["<leader>rv"] = { ":Refactor extract_var ", " Extract Variable"},

    ["<leader>o"] = { ":ObsidianQuickSwitch<CR>", "Obsidian quickswitch" },
    ["<leader>n"] = { ":ObsidianSearch<CR>", "Obsidian Search" },
    ["<leader>ta"] = { ":TDAdd<CR>", "Add MD task" },
    ["<leader>tt"] = { ":TDToggle<CR>", "Toggle MD task" },
  },
  x = {
    ["<leader>rr"] = {":lua require('refactoring').select_refactor()<CR>"},
    ["<leader>re"] = { ":Refactor extract<CR>", " Extract Function"},
    ["<leader>rv"] = { ":Refactor extract_var ", " Extract Variable"}
  }
}

-- more keybinds!

return M
