-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- [[
--     Line-by-line

--     vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
--     In normal mode, Ctrl+h moves the cursor to the window on the left.

--     vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
--     In normal mode, Ctrl+j moves to the window below.

--     vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
--     In normal mode, Ctrl+k moves to the window above.

--     vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
--     In normal mode, Ctrl+l moves to the window on the right.
-- ]]

-- Clear search highlighting
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true })

-- Diagnostics
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { noremap = true, silent = true })

-- Lazy plugin manager
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { noremap = true, silent = true, desc = "Open Lazy" })
vim.keymap.set("n", "<C-p>", function()
  vim.schedule(function()
    vim.cmd("Lazy")
  end)
end, { noremap = true, silent = true, desc = "Open Lazy" })
