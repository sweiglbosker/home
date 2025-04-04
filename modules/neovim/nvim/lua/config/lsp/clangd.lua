return {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "cuda" },
  root_markers = { 
    "meson.build",
    ".clang-format",
    ".clang-tidy",
    "compile_commands.json",
    "compile_flags.txt", 
    "configure.ac" 
  },
  single_file_support = true,
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { "utf-8", "utf-16" },
  },
}
