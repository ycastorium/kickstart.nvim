return {
  {
    'oskarnurm/koda.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'wtfox/jellybeans.nvim',
    lazy = false,
    priority = 1000,
  },
  { 'savq/melange-nvim', lazy = false, priority = 1000 },
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        theme = 'wave',
      }
    end,
  },
  {
    'killitar/obscure.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
  },
  {
    'Tsuzat/NeoSolarized.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('NeoSolarized').setup {
        style = 'light',
        transparent = false,
      }
    end,
  },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  {
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
  },
  {
    'zaldih/themery.nvim',
    lazy = false,
    cmd = { 'Themery' },
    config = function()
      require('themery').setup {
        themes = {
          'kanagawa',
          'catppuccin',
          'jellybeans',
          'gruvbox-material',
          'koda',
          'melange',
          'obscure',
          'bamboo',
          'NeoSolarized',
          'kanso',
          'rose-pine',
        },
      }
    end,
  },
}
