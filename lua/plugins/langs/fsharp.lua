return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'fsharp' } },
  },
  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'fantomas', 'netcoredbg' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        fsautocomplete = {
          settings = {
            FSharp = {
              keywordsAutocomplete = true,
              ExternalAutocomplete = false,
              Linter = true,
              UnionCaseStubGeneration = true,
              UnionCaseStubGenerationBody = 'failwith "Not Implemented"',
              RecordStubGeneration = true,
              RecordStubGenerationBody = 'failwith "Not Implemented"',
              InterfaceStubGeneration = true,
              InterfaceStubGenerationObjectIdentifier = 'this',
              InterfaceStubGenerationMethodBody = 'failwith "Not Implemented"',
              UnusedOpensAnalyzer = true,
              UnusedDeclarationsAnalyzer = true,
              UseSdkScripts = true,
              SimplifyNameAnalyzer = true,
              ResolveNamespaces = true,
              EnableAnalyzers = true,
              EnableReferenceCodeLens = true,
            },
          },
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = { fsharp = { 'fantomas' } },
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
      dap.configurations.fsharp = {
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
