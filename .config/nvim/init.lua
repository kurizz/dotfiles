for _, source in ipairs {
  "astronvim.bootstrap",
  "astronvim.options",
  "astronvim.lazy",
  "astronvim.autocmds",
  "astronvim.mappings",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end

require("astronvim.utils").conditional_func(astronvim.user_opts("polish", nil, false), true)

local config = {
  -- colorscheme
  vim.cmd [[
    colorscheme tokyonight
  ]],

  -- Default theme configuration
  -- default_theme = {
  --  diagnostics_style = { italic = true },
  --  -- Modify the color table
  --  colors = { fg = "#abb2bf" },
  --  -- Modify the highlight groups
  --  highlights = function(highlights)
  --    local C = require "default_theme.colors"
  --    highlights.Normal = { fg = C.fg, bg = C.bg }
  --    return highlights
  --  end,
  --},

  -- Disable default plugins
  enabled = {
    bufferline = true,
    neo_tree = true,
    lualine = true,
    gitsigns = true,
    colorizer = true,
    toggle_term = true,
    comment = true,
    symbols_outline = true,
    indent_blankline = true,
    dashboard = true,
    which_key = true,
    neoscroll = true,
    ts_rainbow = true,
    ts_autotag = true,
  },

  -- Disable AstroNvim ui feature
  --ui = { nui_input = true, telescope_select = true },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = { virtual_text = true, underline = true },

  -- telescope
  require("telescope").setup {
    extensions = {
      file_browser = {
        hijack_netrw = true,
        mappings = {
          ["i"] = {
            -- your custom insert mode mappings
          },
          ["n"] = {
            -- your custom normal mode mappings
          },
        },
      },
    },
  },
  require("telescope").load_extension "file_browser",

  vim.api.nvim_set_keymap(
    "n",
    "<space>fb",
    ":Telescope file_browser path=%:p:h select_buffer=true",
    { noremap = true }
  ),

  -- transparent
  require("transparent").setup({
    extra_groups = {
      "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
      "TelescopeNormal",
      "NeoTreeNormal" -- NvimTree
    }
  }),

}

return config
