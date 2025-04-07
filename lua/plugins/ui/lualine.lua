-- stylua: ignore
local colors = {
  fg1    = '#282828',
  color2 = '#504945',
  fg2    = '#ddc7a1',
  color3 = '#32302f',
  color4 = '#a89984',
  color5 = '#7daea3',
  color6 = '#a9b665',
  color7 = '#d8a657',
  color8 = '#d3869b',
  color9 = '#ea6962',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.color9, bg = colors.fg1, gui = 'bold' },
    b = { fg = colors.fg2, bg = colors.color2 },
    c = { fg = colors.fg2 },
  },
  visual = { a = { fg = colors.fg1, bg = colors.color9, gui = 'bold' } },
  command = { a = { fg = colors.fg1, bg = colors.color9, gui = 'bold' } },
  inactive = { a = { fg = colors.fg1, bg = colors.color9, gui = 'bold' } },
  insert = { a = { fg = colors.fg1, bg = colors.color9, gui = 'bold' } },
  replace = { a = { fg = colors.fg1, bg = colors.color9, gui = 'bold' } },
  terminal = { a = { fg = colors.fg1, bg = colors.color9, gui = 'bold' } },
  -- command = { a = { fg = gruv_material.fg1, bg = gruv_material.color5, gui = 'bold' } },
  -- inactive = { a = { fg = gruv_material.fg2, bg = gruv_material.color2 } },
  -- insert = { a = { fg = gruv_material.fg1, bg = gruv_material.color6, gui = 'bold' } },
  -- replace = { a = { fg = gruv_material.fg1, bg = gruv_material.color7, gui = 'bold' } },
  -- terminal = { a = { fg = gruv_material.fg1, bg = gruv_material.color8, gui = 'bold' } },
}

local function get_mode(mode)
  local mode_map = {
    ['NORMAL'] = 'N',
    ['INSERT'] = 'I',
    ['VISUAL'] = 'V',
    ['V-LINE'] = 'VL',
    ['V-BLOCK'] = 'VB',
    ['COMMAND'] = 'C',
    ['REPLACE'] = 'R',
    ['SELECT'] = 'S',
  }

  return mode_map[mode] or mode:sub(1,1)
end

--TODO: This function is run 1/s so parsing strings each time is wasteful. Look
--      into only parsing strings if the buffer list changes
local function add_buf_buddy_section()
  local buf_buddy = require("BufBuddy")
  local buffers = {}
  -- print("bufbuddy list" .. vim.inspect(buf_buddy.list))
  local truncated = buf_buddy.get_truncated_paths(buf_buddy:get_list())
  for i, buf in ipairs(buf_buddy:get_list()) do
    if i > 5 then
      break
    end
    if vim.api.nvim_buf_is_loaded(buf.id) then
      local buffer_name = vim.fn.fnamemodify(buf.name, ":t")
      local status_line_str = truncated[buf.name]
      if vim.api.nvim_get_current_buf() == buf.id then
        status_line_str = string.format(
          "*%s*",
          truncated[buf.name]
        )

        -- local hl = "%#BufBuddyStatusLineActive#"
        -- local sep_hl = "%#BufBuddyStatusLineActiveSeparator#"
        -- status_line_str = string.format(
        -- "%s%s%s%s%s",
        -- sep_hl, hl, truncated[buf.name], sep_hl,"%#Normal#")
      end

      table.insert(buffers, status_line_str)
    end
  end
  return string.format("%s", table.concat(buffers, " | "))
end

return {
	"nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
        theme = bubbles_theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
			},
      -- Most of these are the defaults - just listed for clarity
			sections = {
        lualine_a = {{ 'mode', fmt = function(mode) return get_mode(mode) end}},
        -- lualine_b = {"branch", "diagnostics"},
        lualine_b = { function() return add_buf_buddy_section() end},
				lualine_c = {  },
				-- lualine_c = { {"filename", path = 1}},
        -- lualine_c = { function() return add_buf_buddy_section() end },
        lualine_x = {"fileformat", "diagnostics"},
        -- lualine_x = {},
        lualine_y = {"progress", "branch"}, -- default "pogress"
        lualine_z = {"location"},
			}
		})
	end,
}
