require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = { enable = true },
  incremental_selection = {
    enable = true,   
    keymaps = {
      init_selection = "gis",
      node_incremental = "gni",
      scope_incremental = "gsi",
      node_decremental = "gnd"
    },
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = true }, 
  },
}
