-- Устанавливаем lazy.nvim
require('lazy').setup({
  -- Packer itself
  { 'wbthomason/packer.nvim' },

  -- LSP конфигурации
  { 'neovim/nvim-lspconfig' },

  -- Автодополнение с nvim-cmp
  { 
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',      -- Источник для LSP
      'hrsh7th/cmp-buffer',        -- Источник для буфера
      'hrsh7th/cmp-path',          -- Источник для путей
      'hrsh7th/cmp-cmdline',       -- Источник для командной строки
      'L3MON4D3/LuaSnip'           -- Для сниппетов
    }
  },

  -- Небольшие сниппеты для Lua
  { 'rafamadriz/friendly-snippets' },

  -- Линейка состояния: lualine
  { 'nvim-lualine/lualine.nvim' },

  -- Нажатие на папки, файловая система: nerdtree
  { 'preservim/nerdtree' },

  -- Автозакрытие скобок
  { 'windwp/nvim-autopairs' },

  -- Поддержка Python в Neovim
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui' },
  { 'mfussenegger/nvim-lint' },
  { 'mhartington/formatter.nvim' }
})

-- Настройка LSP (язык Python, C, NASM)
local lspconfig = require('lspconfig')

-- Python
lspconfig.pyright.setup{}

-- C
lspconfig.clangd.setup{}

-- NASM
lspconfig.zls.setup{}

-- Настройки автодополнения с nvim-cmp
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),  -- Прокрутка документации вверх
    ['<C-d>'] = cmp.mapping.scroll_docs(4),   -- Прокрутка документации вниз
    ['<C-Space>'] = cmp.mapping.complete(),   -- Открытие подсказки
    ['<C-e>'] = cmp.mapping.close(),          -- Закрытие подсказки
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Подтверждение подсказки
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),  -- Переход к следующему элементу
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),  -- Переход к предыдущему элементу
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cmdline' },
  }
})

-- LuaSnip для сниппетов
local luasnip = require('luasnip')

-- Линейка состояния с lualine
require('lualine').setup({
  options = {
    theme = 'gruvbox',
    section_separators = {'', ''},
    component_separators = {'', ''},
  }
})

-- Удобное дерево файлов (NERDTree)
vim.api.nvim_set_keymap('n', '<Leader>n', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- Включаем nvim-autopairs
require('nvim-autopairs').setup{}

-- Настройка линтера для Python
require('lint').linters_by_ft = {
  python = {'flake8', 'pylint'}
}

-- Настройка форматирования для Python
require('formatter').setup({
  filetype = {
    python = {
      function()
        return {
          exe = 'black',
          args = {'--fast'},
          stdin = true
        }
      end
    }
  }
})

