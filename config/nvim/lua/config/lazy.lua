local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "failed to clone lazy.nvim 3:\n", "ErrorMsg" },
      { out,                              "WarningMsg" },
      { "\npress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.cmd("silent !~/.cargo/bin/rustfmt %")
  end,
})

vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<CR>')

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { missing = true, colorscheme = { "rose-pine" } },
  checker = { enabled = true },
  ui = {
    size = { width = 1, height = 1 },
  }
})
