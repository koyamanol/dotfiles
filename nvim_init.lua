-- =========================================================================
-- lazy.nvimのBootstrap
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
-- Leaderキー
-- =========================================================================
vim.g.mapleader      = " "
vim.g.maplocalleader = ","

-- =========================================================================
-- プラグイン
-- =========================================================================
require("lazy").setup({

  -- カラースキーム
  "nanotech/jellybeans.vim",

  -- ステータスライン
  {
    "nvim-lualine/lualine.nvim",
    opts = { theme = "auto" },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "scheme", "lua", "markdown" },
      highlight = { enable = true },
      indent    = { enable = true },
    },
  },

  -- インデント可視化
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- ファジーファインダー
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

  -- GitHub Copilot
  "github/copilot.vim",

  -- Git差分表示
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  -- コメント
  "tpope/vim-commentary",

  -- テーブル作成
  "dhruvasagar/vim-table-mode",

  -- Todo.txt
  "kilisio/todo.txt-vim",

  -- Markdownプレビュー
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

})

-- =========================================================================
-- 基本設定
-- =========================================================================
local opt = vim.opt

opt.number       = true           -- 行番号を表示
opt.cursorline   = true           -- カーソルラインを表示
opt.showcmd      = true           -- 未完のコマンドを表示
opt.wildmode     = "longest,list" -- Exコマンド候補をリスト表示
opt.expandtab    = true           -- タブをスペースに変換
opt.tabstop      = 4              -- タブ幅
opt.shiftwidth   = 4              -- 自動インデント幅
opt.softtabstop  = 4              -- 連続スペースをまとめて削除
opt.list         = true           -- 不可視文字を表示
opt.listchars    = { tab = "▸ ", trail = "." }
opt.hlsearch     = true           -- 検索結果をハイライト
opt.ignorecase   = true           -- 大文字小文字を区別しない
opt.wrapscan     = true           -- 末尾から先頭に折り返し検索
opt.shortmess:remove("S")         -- 検索結果の件数を表示
opt.hidden       = true           -- 未保存でもバッファ移動可能
opt.signcolumn   = "yes"          -- サインカラムを常に表示
opt.updatetime   = 250            -- 更新間隔を250msに設定
opt.mouse        = ""             -- マウス操作を無効にする

vim.cmd("colorscheme jellybeans")

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
map("n", "<C-n>", ":cnext<CR>", { silent = true })
map("n", "<C-p>", ":cprev<CR>", { silent = true })

-- バッファ移動
map("n", "<C-j>", ":bnext<CR>", { silent = true })
map("n", "<C-k>", ":bprev<CR>", { silent = true })

-- MarkdownPreview
map("n", "<leader>p", ":MarkdownPreview<CR>", { silent = true })

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

-- Schemeの設定
vim.api.nvim_create_autocmd("FileType", {
  pattern  = "scheme",
  callback = function()
    vim.opt_local.shiftwidth  = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop     = 2
  end,
})

-- Todo.txtのファイルタイプ設定
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  pattern  = { "todo.md", "done.md", "*.todo.md" },
  callback = function() vim.opt_local.filetype = "todo" end,
})

-- =========================================================================
-- プラグイン個別設定
-- =========================================================================

-- Copilotのファイルタイプ設定
vim.g.copilot_filetypes = {
  scheme     = true,
  markdown   = true,
  html       = true,
  css        = true,
}

-- vim-table-mode
vim.g.table_mode_corner = "|"

-- Todo.txt
vim.g.TodoTxtUseAbbrevInsertMode   = 1
vim.g.TodoTxtStripDoneItemPriority = 1

-- =========================================================================
-- 日付を自動入力する略語
-- =========================================================================
vim.cmd([[iabbrev dt <C-R>=strftime("%F")<CR>]])
vim.cmd([[iabbrev tm <C-R>=strftime("%H:%M")<CR>]])
