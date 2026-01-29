return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
      "hrsh7th/cmp-nvim-lsp"
    },
    config = function()
      -- Setup neodev first (for neovim lua API completion)
      require("neodev").setup()

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Keybindings when LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        end
      })

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          }
        }
      })

      -- Python
      lspconfig.pyright.setup({ capabilities = capabilities })

      -- TypeScript / JavaScript
      lspconfig.ts_ls.setup({ capabilities = capabilities })

      -- Go
      lspconfig.gopls.setup({ capabilities = capabilities })

      -- Rust
      lspconfig.rust_analyzer.setup({ capabilities = capabilities })

      -- Ruby
      lspconfig.ruby_lsp.setup({ capabilities = capabilities })
    end
  }
}
