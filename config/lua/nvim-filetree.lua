require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_root = false,
    ignore_list = {},
  },
  auto_reload_on_write = true,
  sync_root_with_cwd = true,
  sort_by = "case_sensitive",
  view = {
    width = 50,
    preserve_window_proportions = false,
  },
  renderer = {
    group_empty = false,
  },
  filters = {
    dotfiles = false,
  },
})
