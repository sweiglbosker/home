return {
  cmd = { "zls" },
  filetypes = { "zig", "zir" },
  on_new_config = function(new, old)
    if vim.fn.filereadable(vim.fs.joinpath(new_root_dir, "zls.json")) ~= 0 then
      new.cmd = { "zls", "--config-path", "zls.json" }
    end
  end,
  root_markers = { "zls.json", "build.zig", ".git" },
  single_file_support = true,
}
