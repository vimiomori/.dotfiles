-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Run gofmt + goimport on save
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function() end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.go",
  callback = function(args)
    require("conform").format({ async = true, lsp_fallback = true, buf = args.buf }, function(err)
      if not err then
        -- vim.notify("formatted. now saving...")
        vim.api.nvim_buf_call(args.buf, function()
          vim.cmd.update()
          -- vim.notify("saved")
        end)
      end
    end)
    -- if formatting then
    --   vim.notify("formatting asynchronously...")
    -- else
    --   vim.notify("failed to find formatter")
    -- end
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile" }, {
  pattern = { "*diary/[^index]*.wiki" },
  command = "0r! ~/.vim/bin/vimwiki-diary-tpl.py '%'",
})
