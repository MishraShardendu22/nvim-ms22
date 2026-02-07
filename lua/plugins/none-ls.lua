return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    local sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.black,
    }

    -- Only add eslint_d if it's available
    if vim.fn.executable("eslint_d") == 1 then
      table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
    end

    null_ls.setup({
      sources = sources,
    })

    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({ async = false })
    end, { noremap = true, silent = true, desc = "Format buffer" })
  end,
}
