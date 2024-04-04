return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        go = { 'golangcilint' },
        zsh = { 'zsh' },
        sh = { 'shellcheck' },
        nix = { 'nix' },
        dockerfile = { 'hadolint' },
        json = { 'jsonlint' },
      }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function(event)
          require('lint').try_lint()
          local function toggle_diagnostic()
            if vim.diagnostic.is_disabled(event.buf) then
              vim.diagnostic.enable(event.buf)
            else
              vim.diagnostic.disable(event.buf)
            end
          end
          vim.keymap.set({ 'n', 'v' }, '<F2>', toggle_diagnostic, { buffer = event.buf, desc = 'Toggle diagnostic' })
        end,
      })
    end,
  },
}
