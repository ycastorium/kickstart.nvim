return {
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    keys = {
      -- Debug keymaps
      { '<leader>db', '<cmd>DapToggleBreakpoint<cr>', desc = 'Toggle Breakpoint' },
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Conditional Breakpoint',
      },
      {
        '<leader>dl',
        function()
          require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
        end,
        desc = 'Logpoint',
      },
      { '<leader>dc', '<cmd>DapContinue<cr>', desc = 'Continue' },
      { '<leader>di', '<cmd>DapStepInto<cr>', desc = 'Step Into' },
      { '<leader>do', '<cmd>DapStepOver<cr>', desc = 'Step Over' },
      { '<leader>dO', '<cmd>DapStepOut<cr>', desc = 'Step Out' },
      { '<leader>dr', '<cmd>DapToggleRepl<cr>', desc = 'Toggle REPL' },
      { '<leader>dq', '<cmd>DapTerminate<cr>', desc = 'Terminate' },
      {
        '<leader>dR',
        function()
          require('dap').restart()
        end,
        desc = 'Restart',
      },
    },
    config = function()
      vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '🟡', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = 'DapLogPoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '▶️', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '⭕', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })

      -- Set up DAP commands with user-friendly names
      vim.api.nvim_create_user_command('DapToggleBreakpoint', function()
        require('dap').toggle_breakpoint()
      end, {})
      vim.api.nvim_create_user_command('DapContinue', function()
        require('dap').continue()
      end, {})
      vim.api.nvim_create_user_command('DapStepInto', function()
        require('dap').step_into()
      end, {})
      vim.api.nvim_create_user_command('DapStepOver', function()
        require('dap').step_over()
      end, {})
      vim.api.nvim_create_user_command('DapStepOut', function()
        require('dap').step_out()
      end, {})
      vim.api.nvim_create_user_command('DapToggleRepl', function()
        require('dap').repl.toggle()
      end, {})
      vim.api.nvim_create_user_command('DapTerminate', function()
        require('dap').terminate()
      end, {})
    end,
  },
  {
    'igorlfs/nvim-dap-view',
    lazy = false,
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
  },
}
