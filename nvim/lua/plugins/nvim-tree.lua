return 
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- Configure nvim-tree to open automatically when Neovim starts and toggle
      require("nvim-tree").setup({
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      })
    end,
    keys = {
      -- Set a keymap to toggle the file explorer
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    },
}
