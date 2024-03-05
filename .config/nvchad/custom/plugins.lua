local kind_icons = {
	Text = "",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰇽",
	Variable = "󰂡",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰅲",
}

local overrides = require("custom.configs.overrides")

local foldHandler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = (" 󰁂 %d "):format(endLnum - lnum)
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
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, "MoreMsg" })
	return newVirtText
end

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")

---@type NvPluginSpec[]
local plugins = {
	{
		"preservim/vim-pencil",
		event = "VeryLazy",
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		event = "VeryLazy",
	},
	{
		"nvim-pack/nvim-spectre",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
	},
	{
		"folke/zen-mode.nvim",
		event = "VeryLazy",
		opts = {
			window = {
				options = {
					signcolumn = "no", -- disable signcolumn
					number = false, -- disable number column
					relativenumber = false, -- disable relative numbers
				},
			},
		},
	},
	{
		"folke/twilight.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		event = "VeryLazy",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					hover = {
						enabled = false,
					},
					signature = {
						enabled = false,
					},
				},
				presets = {
					-- bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu togetherpl
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
	},
	{
		"lambdalisue/suda.vim",
		event = "VeryLazy",
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup()
		end,
	},
	{
		"leoluz/nvim-dap-go",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("dap-go").setup()
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{ "rafamadriz/friendly-snippets" },
	{ "hrsh7th/cmp-emoji", lazy = true },
	-- {"hrsh7th/nvim-cmp",
	--   event = "VeryLazy",
	--   dependencies = {
	--     "hrsh7th/cmp-emoji"
	--   },
	--   config = function ()
	--     local cmp = require("cmp")
	--     cmp.setup({
	--       formatting = {
	--         format = function(entry, vim_item)
	--           -- Kind icons
	--           vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
	--           -- Source
	--           vim_item.menu = ({
	--             buffer = "[Buffer]",
	--             nvim_lsp = "[LSP]",
	--             luasnip = "[LuaSnip]",
	--             nvim_lua = "[Lua]",
	--           })[entry.source.name]
	--           return vim_item
	--         end
	--       },
	--       matching = {
	--       },
	--       snippet = {
	--         expand = function(args)
	--           local luasnip = require("luasnip")
	--           if not luasnip then
	--             return
	--           end
	--           luasnip.lsp_expand(args.body)
	--         end,
	--       },
	--       completion = {
	--         keyword_length = 1,
	--       },
	--       mapping = {
	--         ["<Tab>"] = cmp.mapping(function(fallback)
	--           if cmp.visible() then
	--             cmp.select_next_item()
	--           elseif luasnip.expand_or_jumpable() then
	--             luasnip.expand_or_jump()
	--           elseif has_words_before() then
	--             cmp.complete()
	--           else
	--             fallback()
	--           end
	--         end, { "i", "s" }),
	--
	--         ["<S-Tab>"] = cmp.mapping(function(fallback)
	--           if cmp.visible() then
	--             cmp.select_prev_item()
	--           elseif luasnip.jumpable(-1) then
	--             luasnip.jump(-1)
	--           else
	--             fallback()
	--           end
	--         end, { "i", "s" }),
	--         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
	--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
	--         ['<C-Space>'] = cmp.mapping.complete(),
	--         ['<C-e>'] = cmp.mapping.abort(),
	--         ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	--       },
	--       sources = { -- different source for the completion
	--         {
	--           name = "nvim_lsp",
	--           max_item_count = 15,
	--         },
	--         {
	--           name = "luasnip",
	--           keyword_length = 2,
	--         },
	--         {
	--           name = "buffer",
	--           keyword_length = 2,
	--         },
	--         {
	--           name = "nvim_lua",
	--           keyword_length = 2,
	--         },
	--         {
	--           name = "obsidian",
	--         },
	--         {
	--           name = "obsidian_new",
	--         },
	--         {
	--           name = "emoji",
	--         },
	--       },
	--     })
	--     -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	--     -- cmp.setup.cmdline({ '/', '?' }, {
	--     --   mapping = cmp.mapping.preset.cmdline(),
	--     --   sources = {
	--     --     { name = 'buffer' }
	--     --   }
	--     -- })
	--     --
	--   end
	-- },
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		event = "VeryLazy",
		ft = "markdown",
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
			"nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			"hrsh7th/nvim-cmp",
		},
		opts = {
			workspaces = {
				{
					name = "team",
					path = "~/second-brain/team",
				},
				{
					name = "personal",
					path = "~/second-brain/personal",
				},
				{
					name = "default",
					path = "~/second-brain/default",
				},
			},
			mappings = {
				-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				-- Toggle check-boxes.
				["<leader>ch"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
			},
			daily_notes = {
				-- Optional, if you keep daily notes in a separate directory.
				folder = "dailies",
				-- Optional, if you want to change the date format for the ID of daily notes.
				date_format = "%Y-%m-%d",
				-- Optional, if you want to change the date format of the default alias of daily notes.
				alias_format = "%B %-d, %Y",
				-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
				template = nil,
			},
			note_id_func = function(title)
				if title == nil then
					local suffix = string.char(math.random(65, 90))
					return title:tostring(os.time()) .. "-" .. suffix
				end
				return title
			end,
			templates = {
				subdir = "templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
				-- A map for custom variables, the key should be the variable and the value a function
				substitutions = {},
			},
			notes_subdir = "zettelkasten",
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},
			attachments = {
				img_folder = "attachments",
			},
		},
	},
	{
		"stevearc/oil.nvim",
		event = "VeryLazy",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "godlygeek/tabular", event = "VeryLazy" },
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		requires = "kevinhwang91/promise-async",
		config = function()
			require("ufo").setup({
				fold_virt_text_handler = foldHandler,
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},
	{ "kevinhwang91/promise-async", lazy = true },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
		config = function()
			require("harpoon").setup({
				tabline = true,
				tabline_prefix = " %m ",
				tabline_suffix = " %m ",
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		keys = {
			{ "<leader>gg", ":Neogit kind=vsplit<CR>", desc = "Neogit split" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},
	{ "tpope/vim-fugitive", lazy = false },
	{
		"rest-nvim/rest.nvim",
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
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
				-- Jump to request line on run
				jump_to_request = false,
				env_file = ".env",
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},
	{ "fatih/vim-go", event = "VeryLazy" },
	{ "towolf/vim-helm", event = "VeryLazy" },
	{ "williamboman/mason.nvim", opts = overrides.mason },
	{ "nvim-treesitter/nvim-treesitter", opts = overrides.treesitter },
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = false,
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
		requires = "nvim-treesitter/nvim-treesitter",
		lazy = false,
		config = function()
			require("nvim-treesitter.configs").setup({
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
							["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
						selection_modes = {
							["@parameter.outer"] = "v",
							["@function.outer"] = "V",
							["@class.outer"] = "V",
						},
					},
				},
			})
		end,
	},
}

return plugins
