return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
     dependencies = { 'nvim-lua/plenary.nvim' },
     config = function()
       require('telescope').setup({
         pickers = {
           find_files = {
             hidden = true,
           },
           grep_string = {
             additional_args = { "--hidden" },
           },
           live_grep = {
             additional_args = { "--hidden" },
           },
         },
       })
       
       local builtin = require('telescope.builtin')
       
       vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = "Find files" })
       vim.keymap.set('n', '<leader>ff', function()
         builtin.find_files({ hidden = true })
       end, { desc = "Find all files, including dotfiles" })
       vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep, including dotfiles" })
     end
    }
