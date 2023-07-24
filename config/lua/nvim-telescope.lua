require('telescope').setup{
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
}

