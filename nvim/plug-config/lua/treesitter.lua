require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = { 
      "c", 
      "c_sharp", 
      "dart", 
      "fennel", 
      "java", 
      "julia", 
    }, 
  },
  incremental_selection = {
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true;
    },
  },
}
