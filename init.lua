vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.number = true

vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

-- Setup lazy
require("lazy").setup({
  -- Base16 colorscheme
  { "RRethy/base16-nvim" },
  {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
  { "justinmk/vim-dirvish" },
  { 'echasnovski/mini.statusline', version = false },
})

-- Set colorscheme
vim.cmd("colorscheme base16-black-metal")  

-- call plugin
require('mini.statusline').setup()

-- keymap
-- ctrl n for opening dirvish
vim.keymap.set("n", "<C-n>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "dirvish" then
      vim.api.nvim_win_close(win, true) -- 
      return
    end
  end
  -- if there's none
  vim.cmd("vsplit")
  vim.cmd("vertical resize 30")  
  vim.cmd("Dirvish")           
end, { desc = "Toggle Dirvish sidebar" })

-- force to open in new window
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dirvish",
  callback = function()
    vim.keymap.set("n", "<CR>", function()
      local file = vim.fn.expand("<cfile>")
      vim.cmd("wincmd p")
      vim.cmd("edit " .. vim.fn.fnameescape(file))
    end, { buffer = true })
  end,
})

