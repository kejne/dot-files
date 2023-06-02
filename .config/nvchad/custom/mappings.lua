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
      ["<leader>fb"] = ""
  }
}

M.general = {
  i = {
    ["<C-s>"] = { "<ESC>:wa<CR>", "Save all", opts = { nowait = true } },
  },
  n = {
    ["<leader>h"] = { "<C-w>h", "window left" },
    ["<leader>l"] = { "<C-w>l", "window right" },
    ["<leader>j"] = { "<C-w>j", "window down" },
    ["<leader>k"] = { "<C-w>k", "window up" },
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
    ["<leader>m"] = { ":lua require(\"harpoon.mark\").add_file()<CR>", "Add Harpoon", opts = { nowait = true } },
    ["<S-Tab>"] = { ":lua require(\"harpoon.ui\").nav_prev()<CR>", "Prev Harpoon", opts = { nowait = true } },
    ["<Tab>"] = { ":lua require(\"harpoon.ui\").nav_next()<CR>" , "Next Harpoon", opts = { nowait = true } },
    ["<leader>q"] = { ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>" , "Harpoon menu", opts = { nowait = true } },
    ["<leader>1"] = { ":lua require(\"harpoon.ui\").nav_file(1)<CR>", "Harpoon 1", opts = { nowait = true } },
    ["<leader>2"] = { ":lua require(\"harpoon.ui\").nav_file(2)<CR>", "Harpoon 2", opts = { nowait = true } },
    ["<leader>3"] = { ":lua require(\"harpoon.ui\").nav_file(3)<CR>", "Harpoon 3", opts = { nowait = true } },
    ["<C-s>"] = { ":wa<CR>", "Save all", opts = { nowait = true } },
    ["<C-u>"] = { "<C-u>zz", "Go up", opts = { nowait = true } },
    ["<C-d>"] = { "<C-d>zz", "Go down", opts = { nowait = true } },
    ["<leader>v"] = { ":vsplit<CR>", "Split screen", opts = { nowait = true } },
    ["gr"] = { ":GoReferrers<CR>", "Go to referrers", opts = { nowait = true } },
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
