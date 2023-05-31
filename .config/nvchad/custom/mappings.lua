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
      ["<leader>l"] = "",
      ["<leader>e"] = "",
      ["<leader>fb"] = ""
  }
}

M.general = {
  n = {
    ["<leader>h"] = { "<C-w>h", "window left" },
    ["<leader>l"] = { "<C-w>l", "window right" },
    ["<leader>j"] = { "<C-w>j", "window down" },
    ["<leader>k"] = { "<C-w>k", "window up" },
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
    ["<leader>m"] = { ":lua require(\"harpoon.mark\").add_file()<CR>", "Add Harpoon", opts = { nowait = true } },
    ["<leader>u"] = { ":lua require(\"harpoon.ui\").nav_prev()<CR>", "Prev Harpoon", opts = { nowait = true } },
    ["<leader>d"] = { ":lua require(\"harpoon.ui\").nav_next()<CR>" , "Next Harpoon", opts = { nowait = true } },
    ["<leader>q"] = { ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>" , "Harpoon menu", opts = { nowait = true } },
    ["<C-u>"] = { "<C-u>zz", "Go up", opts = { nowait = true } },
    ["<C-d>"] = { "<C-d>zz", "Go down", opts = { nowait = true } },
    ["<leader>v"] = { ":vsplit<CR>", "Split screen", opts = { nowait = true } },
    ["<leader>gr"] = { ":GoReferrers<CR>", "Go to referrers", opts = { nowait = true } },
    ["<leader>gt"] = { ":GoAlternate<CR>", "Open test/main", opts = { nowait = true } },
    ["<leader>tf"] = { ":GoTestFunc<CR>", "Run Test Func", opts = { nowait = true } },
    ["<leader>t"] = { ":GoTest<CR>", "Run all tests", opts = { nowait = true } },
    ["<leader><leader>"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>rt"] = {"<Plug>RestNvim","Do Rest Call"},
    ["<leader>xx"] = {":%bd|e#<CR>","Close all other buffers"},
  },
}

-- more keybinds!

return M
