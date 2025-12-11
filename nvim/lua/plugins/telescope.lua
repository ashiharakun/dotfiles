return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = {
      {'nvim-telescope/telescope.nvim'}
    },
    config = function()
      require("telescope").load_extension "frecency"
      vim.keymap.set("n", "<leader><leader>", "<Cmd>Telescope frecency<CR>")
    end,
  }
}