local lualine = require "lualine"
local lualine_mode = require("lualine.utils.mode").get_mode
local noice_mode = require("noice").api.statusline.mode.get

local colors = require "catppuccin.palettes.mocha"

-- Function to get the number of open buffers using the :ls command
local function get_buffer_count()
  local buffers = vim.fn.execute "ls"
  local count = 0

  -- Match only lines that represent buffers, typically starting with a number followed by a space
  for line in string.gmatch(buffers, "[^\r\n]+") do
    if string.match(line, "^%s*%d+") then
      count = count + 1
    end
  end

  return " " .. count
end

-- Integrates Nocice notifications with lua line mode
local get_mode = function()
  local mode = noice_mode()

  if mode then
    return mode
  else
    return lualine_mode()
  end
end

-- LSP clients attached to buffer
local get_clients_lsp = function()
  local bufnr = vim.api.nvim_get_current_buf()

  local clients = vim.lsp.buf_get_clients(bufnr)
  if next(clients) == nil then
    return ""
  end

  local c = {}
  for _, client in pairs(clients) do
    if client.name ~= "copilot" then
      table.insert(c, client.name)
    end
  end
  return table.concat(c, "  ")
end

lualine.setup {
  options = {
    theme = "catppuccin",
    globalstatus = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = "", right = "" },
    disabled_filetypes = { winbar = { "NvimTree", "alpha" } },
  },

  sections = {
    lualine_a = { get_mode },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {},
    lualine_x = {
      get_clients_lsp,
      {
        "lsp_progress",
        display_components = { "lsp_client_name", { "title", "percentage" } },
      },
    },

    lualine_y = { "filesize" },
    lualine_z = { "location" },
  },

  winbar = {
    lualine_a = {},
    lualine_b = {
      get_buffer_count,
    },
    lualine_c = {
      {

        "filetype",
        color = { fg = colors.blue },
      },
      {
        "filename",
        file_status = true,
        newfile_status = true,
        path = 1,
        color = { fg = colors.blue },
      },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },

  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        file_status = true,
        newfile_status = true,
        path = 1,
        color = { fg = colors.subtext1 },
      },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}
