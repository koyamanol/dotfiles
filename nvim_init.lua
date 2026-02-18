-- =========================================================================
-- lazy.nvim のブートストラップ
-- =========================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

  -- Git 操作
  "tpope/vim-fugitive",

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

  -- 翻訳
  "VincentCordobes/vim-translate",

  -- テーブル作成
  "dhruvasagar/vim-table-mode",

  -- Emmet
  "mattn/emmet-vim",

  -- Todo.txt
  "kilisio/todo.txt-vim",

  -- Markdown プレビュー
  "previm/previm",

  -- カラースキーム
  "nanotech/jellybeans.vim",

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("ocamllsp", {})
      vim.lsp.enable("ocamllsp")
      vim.lsp.config("hls", {
        settings = {
          haskell = { formattingProvider = "ormolu" },
        },
      })
      vim.lsp.enable("hls")
    end,
  },

  -- 補完
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<C-e>"]     = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

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
opt.backspace    = "2"           -- Ctrl-h の対象を増やす
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
opt.foldlevel    = 1             -- 折りたたみレベル

vim.cmd("syntax enable")
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
map("n", "Y",          "y$")
map("v", "<leader>y",  '"+y')
map("n", "<leader>r",  ":<C-u>registers<CR>")
map("n", "<leader>m",  ":<C-u>marks<CR>")
map("t", "<Esc>",      "<C-\\><C-n>")
map("i", "jj",         "<ESC>", { silent = true })

-- init.lua の編集・リロード
map("n", "<leader>.", ":<C-u>edit $MYVIMRC<CR>")
map("n", "<leader>s", ":<C-u>source $MYVIMRC<CR>")

-- Telescope
map("n", "<leader>o",  ":Telescope find_files<CR>",  { silent = true })
map("n", "<leader>b",  ":Telescope buffers<CR>",     { silent = true })
map("n", "<leader>h",  ":Telescope oldfiles<CR>",    { silent = true })
map("n", "<leader>fg", ":Telescope live_grep<CR>",   { silent = true })

-- vim-fugitive
map("n", "<leader>gs", ":Git status<CR>")
map("n", "<leader>gd", ":Gdiff<CR>")



-- Previm
map("n", "<leader>p", ":PrevimOpen<CR>", { silent = true })

-- Emmet
vim.g.user_emmet_leader_key = "<C-e>"

-- LSP
map("n", "gd",         vim.lsp.buf.definition,  { desc = "定義へジャンプ" })
map("n", "K",          vim.lsp.buf.hover,        { desc = "ドキュメント表示" })
map("n", "<leader>rn", vim.lsp.buf.rename,       { desc = "リネーム" })
map("n", "<leader>ca", vim.lsp.buf.code_action,  { desc = "コードアクション" })

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
    -- インデント設定
    vim.opt_local.shiftwidth  = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop     = 2

    local buf = vim.api.nvim_get_current_buf()

    -- REPL を起動
    vim.keymap.set("n", "<leader>gr", function()
      vim.cmd("split | terminal gosh")
    end, { buffer = buf, desc = "Gauche REPLを起動" })

    -- 現在の行をREPLに送る
    vim.keymap.set("n", "<leader>gl", function()
      local line = vim.api.nvim_get_current_line()
      vim.fn.chansend(vim.b.terminal_job_id, line .. "\n")
    end, { buffer = buf, desc = "現在の行をREPLに送る" })

    -- 選択範囲をREPLに送る
    vim.keymap.set("v", "<leader>gl", function()
      local s = vim.fn.getpos("'<")
      local e = vim.fn.getpos("'>")
      local lines = vim.api.nvim_buf_get_lines(0, s[2] - 1, e[2], false)
      vim.fn.chansend(vim.b.terminal_job_id, table.concat(lines, "\n") .. "\n")
    end, { buffer = buf, desc = "選択範囲をREPLに送る" })

    -- ファイル全体をREPLに読み込む
    vim.keymap.set("n", "<leader>gf", function()
      local file = vim.fn.expand("%:p")
      vim.fn.chansend(vim.b.terminal_job_id, '(load "' .. file .. '")\n')
    end, { buffer = buf, desc = "ファイルをREPLに読み込む" })
  end,
})

-- Todo.txt のファイルタイプ設定
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
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

-- vim-table-mode
vim.g.table_mode_corner = "|"

-- Previm
vim.g.previm_open_cmd    = "open -a Safari"
vim.g.previm_show_header = 0



-- Todo.txt
vim.g.TodoTxtUseAbbrevInsertMode   = 1
vim.g.TodoTxtStripDoneItemPriority = 1
vim.g.Todo_fold_char               = "+"

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

-- =========================================================================
-- 日付を自動入力する略語
-- =========================================================================
vim.cmd([[iabbrev dt <C-R>=strftime("%F")<CR>]])
