require("fzf-lua").setup({
  files = {
    fd_opts =
    [[--color=never --type f --hidden --follow --exclude .git --exclude *.cur --exclude *.mp4 --exclude *.gif --exclude *.png --exclude *.jpg --exclude *.PNG]],
  },
})
