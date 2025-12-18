return {
  recommended = {
    ft = 'gleam',
    root = 'gleam.toml',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'gleam' } },
  },
  {
    'conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        gleam = { 'gleam' },
      },
    },
  },
}
