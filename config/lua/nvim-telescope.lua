require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      'node_modules',
      '.git/',
      '%.png',
      '%.jpeg',
      '%.jpg',
    }
  },
  pickers = {
    live_grep = {
      hidden = true,
    },
    find_files = {
      hidden = true,
    }
  },
  extensions = {
    ghq = {},
    recent_files = {
      max_entries = 1000,
      show_cwd = true,
    }
  }
}
require 'telescope'.load_extension 'recent_files'
require 'telescope'.load_extension 'ghq'
