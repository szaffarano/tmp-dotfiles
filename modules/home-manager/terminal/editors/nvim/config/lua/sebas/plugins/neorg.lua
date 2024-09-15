local fs = require 'sebas.utils.fs'

local function imports()
  return require 'luasnip', require 'neorg.modules.external.templates.default_snippets', require 'sebas.utils.neorg'
end

return {
  'nvim-neorg/neorg',
  lazy = false,
  version = '*',
  config = true,
  dependencies = {
    { 'pysan3/neorg-templates', dependencies = { 'L3MON4D3/LuaSnip' } },
  },
  opts = {
    load = {
      ['core.completion'] = { config = { engine = 'nvim-cmp' } },
      ['core.concealer'] = { config = { icon_preset = 'diamond', icons = { code_block = { spell_check = false } } } },
      ['core.defaults'] = {},
      ['core.dirman'] = { config = { workspaces = { notes = '~/Documents/neorg' }, default_workspace = 'notes' } },
      ['core.journal'] = { config = { strategy = 'nested' } },
      ['core.summary'] = {},
      ['core.ui.calendar'] = {},
      ['external.templates'] = {
        config = {
          templates_dir = fs.join(vim.fn.stdpath 'data', 'templates', 'neorg'),
          default_subcommand = 'load',

          keywords = {
            TODAY_OF_FILE_ORG = function() -- detect date from filename and return in org date format
              local ls, m = imports()
              return ls.text_node(m.parse_date(0, m.file_tree_date(), [[<%Y-%m-%d %a>]])) -- <2006-11-01 Wed>
            end,
            TODAY_OF_FILE_NORG = function() -- detect date from filename and return in norg date format
              local ls, m = imports()
              return ls.text_node(m.parse_date(0, m.file_tree_date(), [[%a, %d %b %Y]])) -- Wed, 1 Nov 2006
            end,
            WEEK_NUMBER_OF_DAILY_FILE = function() -- detect date from filename and return in norg date format
              local ls, _, no = imports()
              local _, number = no.daily_file_tree_week_number(vim.api.nvim_buf_get_name(0))
              return ls.text_node(string.format('%02d', number))
            end,
            WEEK_NUMBER_OF_DAILY_FILE_NORG = function() -- detect date from filename and return in norg date format
              local ls, _, no = imports()
              local year, number = no.daily_file_tree_week_number(vim.api.nvim_buf_get_name(0))
              return ls.text_node(string.format('$/journal/%s/W-%02d', year, number))
            end,
            WEEK_NUMBER_OF_WEEKLY_FILE = function() -- detect date from filename and return in norg date format
              local ls, _, no = imports()
              local _, number = no.weekly_file_tree_week_number(vim.api.nvim_buf_get_name(0))
              return ls.text_node(string.format('%02d', number))
            end,
            NEXT_WEEK_NUMBER_OF_WEEKLY_FILE_NORG = function() -- detect date from filename and return in norg date format
              local ls, _, no = imports()
              local year, number = no.weekly_file_tree_week_number(vim.api.nvim_buf_get_name(0), 1)
              return ls.text_node(string.format('$/journal/%s/W-%02d', year, number))
            end,
            PREV_WEEK_NUMBER_OF_WEEKLY_FILE_NORG = function() -- detect date from filename and return in norg date format
              local ls, _, no = imports()
              local year, number = no.weekly_file_tree_week_number(vim.api.nvim_buf_get_name(0), -1)
              return ls.text_node(string.format('$/journal/%s/W-%02d', year, number))
            end,
            TODAY_ORG = function() -- detect date from filename and return in org date format
              local ls, m = imports()
              return ls.text_node(m.parse_date(0, os.time(), [[<%Y-%m-%d %a %H:%M:%S>]])) -- <2006-11-01 Wed 19:15>
            end,
            TODAY_NORG = function() -- detect date from filename and return in norg date format
              local ls, m = imports()
              return ls.text_node(m.parse_date(0, os.time(), [[%a, %d %b %Y %H:%M:%S]])) -- Wed, 1 Nov 2006 19:15
            end,
            NOW_IN_DATETIME = function() -- print current date+time of invoke
              local ls, m = imports()
              return ls.text_node(m.parse_date(0, os.time(), [[%Y-%m-%d %a %X]])) -- 2023-11-01 Wed 23:48:10
            end,
            YESTERDAY_OF_FILEPATH = function() -- detect date from filename and return its file path to be used in a link
              local ls, m = imports()
              return ls.text_node(m.parse_date(-1, m.file_tree_date(), [[../../%Y/%m/%d]])) -- ../../2020/01/01
            end,
            TOMORROW_OF_FILEPATH = function() -- detect date from filename and return its file path to be used in a link
              local ls, m = imports()
              return ls.text_node(m.parse_date(1, m.file_tree_date(), [[../../%Y/%m/%d]])) -- ../../2020/01/01
            end,
            QUOTE_OF_THE_DAY = function()
              local raw = vim.fn.system 'curl --no-progress-meter https://zenquotes.io/api/random'
              local parsed = vim.json.decode(raw)[1]
              local author = parsed['a']
              local quote = parsed['q']
              local ls, _ = imports()
              return ls.text_node {
                '> ' .. quote,
                '> --- ' .. author,
              }
            end,
          },
        },
      },
    },
  },
}
