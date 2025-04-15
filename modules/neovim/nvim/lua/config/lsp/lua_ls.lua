return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_dir = { 
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  single_file_support = true,
}
