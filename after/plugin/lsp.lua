-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

-- Mason setup
require('mason').setup()

-- Mason-LSPConfig setup
require('mason-lspconfig').setup({
  ensure_installed = { "pylsp", "lua_ls" }, -- Specify servers to be installed
  automatic_installation = true, -- Automatically install configured servers
})

-- Extend capabilities for nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Mason-LSPConfig Handlers for LSP setup
require('mason-lspconfig').setup_handlers({
  -- Default handler for all servers
  function(server_name)
    require('lspconfig')[server_name].setup({
      capabilities = capabilities,
    })
  end,
  
  -- Custom settings for lua_ls
  ["lua_ls"] = function()
    require('lspconfig').lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } }, -- Recognize `vim` as a global
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false, -- Avoid unnecessary prompts for third-party libraries
          },
          telemetry = { enable = false }, -- Disable telemetry for better performance
        },
      },
    })
  end,
  
  -- Custom settings for pylsp
  ["pylsp"] = function()
    require('lspconfig').pylsp.setup({
      settings = {
        pylsp = {
          plugins = {
            pyflakes = { enabled = true }, -- Linting
            pylint = { enabled = true }, -- Advanced linting
            pyls_mypy = { enabled = true }, -- Static typing via MyPy
          },
        },
      },
      capabilities = capabilities,
    })
  end,
})

-- Automatically set up LSP features and keybindings on LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    -- Key mappings for LSP features
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
  end,
})

-- Setup nvim-cmp for autocompletion
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- Use LuaSnip for snippets
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept selected completion item
  }),
  sources = {
    { name = 'nvim_lsp' }, -- LSP source
    { name = 'buffer' }, -- Buffer source
    { name = 'path' }, -- Path source
  },
})
