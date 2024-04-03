return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio', -- Required dependency for nvim-dap-ui

    -- language-specific debuggers configurations
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F9>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F8>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<S-F8>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })
    vim.keymap.set('n', '<Leader>dl', dap.run_last, { desc = 'Debug: Run Last' })
    vim.keymap.set('n', '<Leader>df', function()
      ---@diagnostic disable-next-line: missing-fields
      require('dapui').float_element('scopes', { enter = true })
    end)

    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      ---@diagnostic disable-next-line: missing-fields
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }
    vim.keymap.set('n', '<S-F9>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- golang
    require('dap-go').setup()

    -- rust
    dap.adapters.lldb = {
      type = 'executable',
      command = 'lldb-vscode',
      name = 'lldb',
    }

    dap.configurations.rust = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }
  end,
}
