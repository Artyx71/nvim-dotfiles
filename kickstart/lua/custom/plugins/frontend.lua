local function gh(repo) return 'https://github.com/' .. repo end

-- Small frontend-specific additions that are not already covered by Kickstart.
vim.pack.add { gh 'windwp/nvim-ts-autotag' }

require('nvim-ts-autotag').setup {
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = true,
  },
}
