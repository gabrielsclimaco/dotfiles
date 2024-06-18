-----------------
-- General config
lvim.format_on_save.enabled = true
lvim.colorscheme = "catppuccin-macchiato"
vim.opt.clipboard = ""

-----------------
-- Keymappings
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<Tab>"] = "gt"
lvim.keys.normal_mode["<S-Tab>"] = "gT"
lvim.keys.normal_mode["<C-x>"] = ":BufferKill<CR>"
lvim.keys.normal_mode["<C-t>"] = ":ToggleTerm<CR>"

lvim.keys.insert_mode["kj"] = "<esc>"
lvim.keys.insert_mode["kk"] = "<esc>"
lvim.keys.insert_mode["jj"] = "<esc>"

lvim.keys.visual_mode["<C-c>"] = "\"+y<cr>"
lvim.keys.visual_mode["<C-x>"] = "\"+x<cr>"
-- Move selected line / block of text in visual mode
lvim.keys.visual_mode["<S-k>"] = ":move '<-2<CR>gv-gv"
lvim.keys.visual_mode["<S-j>"] = ":move '>+1<CR>gv-gv"


lvim.keys.insert_mode["<C-v>"] = "<esc>\"+pa"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

lvim.builtin.which_key.mappings["a"] = { "<cmd>LvimToggleFormatOnSave<CR>", "Toggle format on save" }
lvim.builtin.which_key.mappings["W"] = { "<cmd>set wrap!<CR>", "Toggle wrap" }

lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-----------------
-- Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    'AlphaTechnolog/pywal.nvim',
    name = 'pywal',
  },
  { 'terryma/vim-multiple-cursors' },
  { 'towolf/vim-helm' },
  { 'lukoshkin/trailing-whitespace' },
  { 'digitaltoad/vim-pug' },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "sass", "html", "javascript", "vue" }, {
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    'glepnir/zephyr-nvim',
  },
  {
    'mhartington/oceanic-next',
  },
  {
    'projekt0n/github-nvim-theme',
  },
  {
    'ellisonleao/gruvbox.nvim',
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({})
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  {
    'github/copilot.vim',
  },
}

-----------------
-- Plugins config
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.view.width = 50
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "go",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "java",
  "yaml",
}
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.context_commentstring.enable = true

-- generic LSP settings
require('lspconfig').yamlls.setup {
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
      },
    },
    yml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
      },
    },
  }
}

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "jsonls",
}

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    extra_args = {
      '--config-precedence=file-override',
      '--single-quote',
      '--trailing-comma=all',
    },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = {
      "lua",
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "css",
      "scss",
      "sass",
      "json",
      "markdown",
      "vue",
      "yaml",
      "html",
      "pug",
    },
  },
}
