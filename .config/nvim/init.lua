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

if astronvim.default_colorscheme then
  if not pcall(vim.cmd.colorscheme, astronvim.default_colorscheme) then
    require("astronvim.utils").notify(
      "Error setting up colorscheme: " .. astronvim.default_colorscheme,
      vim.log.levels.ERROR
    )
  end
end

require("astronvim.utils").conditional_func(astronvim.user_opts("polish", nil, false), true)

local config = {
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

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = { virtual_text = true, underline = true },

  -- telescope
  require("telescope").setup {
    extensions = {
      file_browser = {
        hijack_netrw = true,
        mappings = {
          ["i"] = {}, -- your custom insert mode mappings
          ["n"] = {}, -- your custom normal mode mappings
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

  -- lsp
  require'lspconfig'.pylsp.setup{
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            maxLineLength = 120
          }
        }
      }
    }
  },

  -- colorscheme
  vim.cmd [[
    colorscheme tokyonight
  ]],
  require("transparent").setup({
    extra_groups = {
      "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
      "TelescopeNormal",
      "NeoTreeNormal"
    }
  }),

}

return config
