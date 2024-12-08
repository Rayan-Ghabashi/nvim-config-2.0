local builtin = require('telescope.builtin')


vim.keymap.set('n', '<leader>pf', function()
  builtin.find_files({
    file_ignore_patterns = { ":LOCAL", "%.git", "node_modules", "__pycache__" }
  })
end, { desc = 'Telescope find files' })

vim.keymap.set('n', '<C-p>', builtin.git_files, {})

vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
