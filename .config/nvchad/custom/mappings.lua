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
      ["<leader>e>"] = ""
  }
}

M.general = {
  n = {
    ["<leader>h"] = { "<C-w>h", "window left" },
    ["<leader>l"] = { "<C-w>l", "window right" },
    ["<leader>j"] = { "<C-w>j", "window down" },
    ["<leader>k"] = { "<C-w>k", "window up" },
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-u>"] = { "<C-u>zz", "Go up", opts = { nowait = true } },
    ["<C-d>"] = { "<C-d>zz", "Go down", opts = { nowait = true } },
    ["<leader>v"] = { ":vsplit<CR>", "Split screen", opts = { nowait = true } },
    ["<leader>gh"] = { ":GoReferrers<CR>", "Go to referrers", opts = { nowait = true } },
    ["<leader>gt"] = { ":GoAlternate<CR>", "Open test/main", opts = { nowait = true } },
    ["<leader>tf"] = { ":GoTestFunc<CR>", "Run Test Func", opts = { nowait = true } },
    ["<leader>t"] = { ":GoTest<CR>", "Run all tests", opts = { nowait = true } },
  },
}

-- more keybinds!

return M
