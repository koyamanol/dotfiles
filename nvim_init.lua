-- =========================================================================
-- lazy.nvim のブートストラップ
-- =========================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =========================================================================
-- Leader キーの設定（lazy.nvim より前に設定する必要あり）
-- =========================================================================
vim.g.mapleader      = " "
vim.g.maplocalleader = ","

-- =========================================================================
-- プラグイン
-- =========================================================================
require("lazy").setup({

  -- ファジーファインダー（fzf → Telescope に移行）
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            n = {
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
      })
    end,
  },

  -- ステータスライン（lightline → lualine に移行）
  {
    "nvim-lualine/lualine.nvim",
    opts = { theme = "auto" },
  },

  -- インデント可視化（vim-indent-guides → indent-blankline に移行）
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- Git 差分表示（vim-gitgutter → gitsigns に移行）
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  -- GitHub Copilot
  "github/copilot.vim",

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "github/copilot.vim", "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- コメント
  "tpope/vim-commentary",

  -- サラウンド
  "tpope/vim-surround",

  -- テーブル作成
  "dhruvasagar/vim-table-mode",

  -- Todo.txt
  "kilisio/todo.txt-vim",

  -- Markdown プレビュー
  {
    "iamcco/markdown-preview.nvim",
    lazy = false,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_theme = "dark"
    end,
  },

  -- カラースキーム
  "nanotech/jellybeans.vim",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "scheme", "ocaml", "haskell", "lua", "markdown" },
      highlight = { enable = true },
      indent    = { enable = true },
    },
  },

  -- LSP（未使用のためコメントアウト）
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     -- OCaml
  --     vim.lsp.config("ocamllsp", {})
  --     vim.lsp.enable("ocamllsp")
  --
  --     -- Haskell
  --     vim.lsp.config("hls", {
  --       settings = {
  --         haskell = { formattingProvider = "ormolu" },
  --       },
  --     })
  --     vim.lsp.enable("hls")
  --   end,
  -- },

  -- 補完（未使用のためコメントアウト）
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --   },
  --   config = function()
  --     local cmp = require("cmp")
  --     cmp.setup({
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<CR>"]      = cmp.mapping.confirm({ select = true }),
  --         ["<C-e>"]     = cmp.mapping.abort(),
  --       }),
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp" },
  --         { name = "buffer" },
  --         { name = "path" },
  --       }),
  --     })
  --   end,
  -- },

})

-- =========================================================================
-- 基本設定
-- =========================================================================
local opt = vim.opt

opt.number       = true          -- 行番号を表示
opt.cursorline   = true          -- カーソルラインを表示
opt.ruler        = true          -- カーソル位置を表示
opt.laststatus   = 2             -- 常にステータス行を表示
opt.showcmd      = true          -- 未完のコマンドを表示
opt.wildmode     = "longest,list" -- Exコマンド候補をリスト表示
opt.history      = 1000          -- コマンド履歴を1000件保持
opt.expandtab    = true          -- タブをスペースに変換
opt.autoindent   = true          -- 自動インデント
opt.tabstop      = 4             -- タブ幅
opt.shiftwidth   = 4             -- 自動インデント幅
opt.softtabstop  = 4             -- 連続スペースをまとめて削除
opt.list         = true          -- 不可視文字を表示
opt.listchars    = { tab = "▸ ", trail = "." }
opt.incsearch    = true          -- インクリメンタルサーチ
opt.hlsearch     = true          -- 検索結果をハイライト
opt.shortmess:remove("S")        -- 検索結果の件数を表示
opt.ignorecase   = true          -- 大文字小文字を区別しない
opt.wrapscan     = true          -- 末尾から先頭に折り返し検索
opt.hidden       = true          -- 未保存でもバッファ移動可能
opt.splitbelow   = true          -- 水平分割時に下に開く
opt.mouse        = ""            -- マウス操作を無効にする
opt.signcolumn   = "yes"         -- サインカラムを常に表示
opt.updatetime   = 250           -- 更新間隔を250msに設定

vim.cmd("filetype plugin indent on")
vim.cmd("colorscheme jellybeans")

-- 背景を透過してGhosttyの黒に合わせる
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NonText guibg=NONE ctermbg=NONE")

-- =========================================================================
-- キーマッピング
-- =========================================================================
local map = vim.keymap.set

-- 基本操作
map("v", "<leader>y",  '"+y')
map("n", "<leader>r",  ":<C-u>registers<CR>")
map("n", "<leader>m",  ":<C-u>marks<CR>")
map("t", "<Esc>",      "<C-\\><C-n>")
map("i", "jj",         "<ESC>", { silent = true })

-- init.lua の編集
map("n", "<leader>.", ":<C-u>edit $MYVIMRC<CR>")

-- Telescope
map("n", "<leader>o",  ":Telescope find_files<CR>",  { silent = true })
map("n", "<leader>b",  ":Telescope buffers<CR>",     { silent = true })
map("n", "<leader>h",  ":Telescope oldfiles<CR>",    { silent = true })
map("n", "<leader>g",  ":Telescope live_grep<CR>",   { silent = true })

-- Quickfix
map("n", "<C-j>", ":cnext<CR>",  { silent = true })
map("n", "<C-k>", ":cprev<CR>",  { silent = true })

-- MarkdownPreview
map("n", "<leader>p", ":MarkdownPreview<CR>", { silent = true })

-- LSP（未使用のためコメントアウト）
-- map("n", "gd",         vim.lsp.buf.definition,  { desc = "定義へジャンプ" })
-- map("n", "K",          vim.lsp.buf.hover,        { desc = "ドキュメント表示" })
-- map("n", "<leader>rn", vim.lsp.buf.rename,       { desc = "リネーム" })
-- map("n", "<leader>ca", vim.lsp.buf.code_action,  { desc = "コードアクション" })

-- =========================================================================
-- 自動コマンド
-- =========================================================================

-- 検索後に自動的に英数入力に戻す
vim.api.nvim_create_autocmd("CmdlineLeave", {
  pattern  = { "/", "\\?" },
  callback = function()
    vim.fn.system("im-select com.apple.keylayout.ABC")
  end,
})

-- Scheme (Gauche) の設定
vim.api.nvim_create_autocmd("FileType", {
  pattern  = "scheme",
  callback = function()
    vim.opt_local.shiftwidth  = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop     = 2
  end,
})

-- Todo.txt のファイルタイプ設定
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  pattern  = { "todo.md", "done.md", "*.todo.md" },
  callback = function() vim.opt_local.filetype = "todo" end,
})

-- OCaml の自動フォーマット
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern  = { "*.ml", "*.mli" },
  callback = function()
    vim.cmd(":%!ocamlformat --name % -")
  end,
})

-- =========================================================================
-- プラグイン個別設定
-- =========================================================================

-- Copilot のファイルタイプ設定
vim.g.copilot_filetypes = {
  markdown   = true,
  text       = true,
  html       = true,
  css        = true,
  javascript = true,
  typescript = true,
  python     = true,
  ruby       = true,
  go         = true,
  java       = true,
  c          = true,
  scheme     = true,
  ocaml      = true,
  haskell    = true,
}

-- vim-table-mode
vim.g.table_mode_corner = "|"

-- Todo.txt
vim.g.TodoTxtUseAbbrevInsertMode   = 1
vim.g.TodoTxtStripDoneItemPriority = 1
vim.g.Todo_fold_char               = "+"

-- =========================================================================
-- 日付を自動入力する略語
-- =========================================================================
vim.cmd([[iabbrev dt <C-R>=strftime("%F")<CR>]])
vim.cmd([[iabbrev tm <C-R>=strftime("%H:%M")<CR>]])
