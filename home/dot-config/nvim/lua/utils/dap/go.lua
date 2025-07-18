local ts_utils = require 'nvim-treesitter.ts_utils'

local query = vim.treesitter.query.parse(
  'go',
  [[
	(call_expression
		(identifier) @testmethod
		(#match? @testmethod "^(It|Describe|Context)")
		(argument_list
			(interpreted_string_literal
				(interpreted_string_literal_content) @methodname
			)
		)
	)
]]
)

--- Get Ginkgo "^(It|Context|Describe)" test under the cursor
--- @return string | nil
local get_ginkgo_test_under_the_cursor = function()
  local node = ts_utils.get_node_at_cursor(0, true)
  while node do
    if node:type() ~= 'call_expression' then
      goto skip
    end

    for id, capture in query:iter_captures(node, 0) do
      if query.captures[id] == 'methodname' then
        return vim.treesitter.get_node_text(capture, 0)
      end
    end

    ::skip::
    node = node:parent()
  end
  vim.notify('No test method found!', vim.log.levels.WARN)
  return nil
end

--- Get all Ginkgo tests in the file
--- @return string | nil
local get_all_ginkgo_tests = function()
  local methods = {}
  local tree = vim.treesitter.get_parser():parse()[1]
  for _, match in query:iter_matches(tree:root(), 0) do
    local method = {}
    for _, nodes in pairs(match) do
      for _, node in ipairs(nodes) do
        table.insert(method, vim.treesitter.get_node_text(node, 0))
      end
    end
    table.insert(methods, method)
  end
  if not #methods then
    vim.notify('No test method found!', vim.log.levels.WARN)
    return nil
  end
  local result = nil
  vim.ui.select(methods, {
    prompt = 'Select ginkgo test for debbuging',
    format_item = function(item)
      return item[1] .. '("' .. item[2] .. '")'
    end,
  }, function(choice)
    if choice and #choice > 1 then
      result = choice[2]
    end
  end)
  return result
end

local function load_module(module_name)
  local ok, module = pcall(require, module_name)
  assert(ok, string.format('dap-go dependency error: %s not installed', module_name))
  return module
end

local ginkgo_config = function()
  return {
    setmetatable({
      type = 'go',
      name = 'Ginkgo All',
      request = 'launch',
      mode = 'test',
      program = './${relativeFileDirname}',
    }, {
      __call = function(config)
        local test_name = get_all_ginkgo_tests()
        if test_name then
          config.args = { '-ginkgo.v', '-ginkgo.focus', test_name }
        end
        return config
      end,
    }),
    setmetatable({
      type = 'go',
      name = "Ginkgo '^(It|Context|Describe)'",
      request = 'launch',
      mode = 'test',
      program = './${relativeFileDirname}',
    }, {
      __call = function(config)
        local test_name = get_ginkgo_test_under_the_cursor()
        if test_name then
          config.args = { '-ginkgo.v', '-ginkgo.focus', test_name }
        end
        return config
      end,
    }),
  }
end

local dap = require 'dap'
table.insert(dap.configurations.go, ginkgo_config)
