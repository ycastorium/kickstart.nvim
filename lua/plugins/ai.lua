return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        copilot = {},
      },
    },
  },
  {
    'folke/sidekick.nvim',
    opts = {
      cli = {
        mux = {
          backend = 'zellij',
          enabled = true,
        },
      },
    },
    keys = {
      {
        '<c-.>',
        function()
          require('sidekick.cli').focus()
        end,
        mode = { 'n', 'x', 'i', 't' },
        desc = 'Sidekick Switch Focus',
      },
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle { focus = true }
        end,
        desc = 'Sidekick Toggle CLI',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').prompt()
        end,
        desc = 'Sidekick Ask Prompt',
        mode = { 'n', 'v' },
      },
      {
        '<leader>snu',
        function()
          require('sidekick.nes').update()
        end,
        desc = 'Sidekick Update NES Suggestions',
        mode = { 'n', 'v' },
      },
      {
        '<leader>snj',
        function()
          require('sidekick.nes').jump()
        end,
        desc = 'Sidekick Jump NES Suggestions',
        mode = { 'n', 'v' },
      },
      {
        '<leader>sna',
        function()
          require('sidekick.nes').apply()
        end,
        desc = 'Sidekick Apply NES Suggestions',
        mode = { 'n', 'v' },
      },
    },
  },
  {
    'saghen/blink.cmp',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        ['<Tab>'] = {
          'snippet_forward',
          function() -- sidekick next edit suggestion
            return require('sidekick').nes_jump_or_apply()
          end,
          function() -- if you are using Neovim's native inline completions
            return vim.lsp.inline_completion.get()
          end,
          'fallback',
        },
      },
    },
  },
}
