return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'rescript' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        rescriptls = {},
      },
    },
  },
}
