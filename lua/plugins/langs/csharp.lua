return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'c_sharp' } },
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.registries = opts.registries or { 'github:mason-org/mason-registry' }
      if not vim.tbl_contains(opts.registries, 'github:Crashdummyy/mason-registry') then
        table.insert(opts.registries, 'github:Crashdummyy/mason-registry')
      end
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'csharpier', 'netcoredbg', 'roslyn' })
    end,
  },
  {
    'seblyng/roslyn.nvim',
    ft = { 'cs' },
    opts = {},
  },
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = { cs = { 'csharpier' } },
    },
  },
  {
    'mfussenegger/nvim-dap',
    optional = true,
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = { ensure_installed = { 'netcoredbg' } },
      },
    },
    opts = function()
      local dap = require 'dap'
      if not dap.adapters.coreclr then
        dap.adapters.coreclr = {
          type = 'executable',
          command = vim.fn.exepath 'netcoredbg',
          args = { '--interpreter=vscode' },
        }
      end
      dap.configurations.cs = {
        {
          type = 'coreclr',
          name = 'Launch - netcoredbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
          end,
        },
      }
    end,
  },
}
