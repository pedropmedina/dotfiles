require"nvim-treesitter.configs".setup {
    -- ensure_installed = {
    --   'html',
    --   'css',
    --   'json',
    --   'jsdoc',
    --   'graphql',
    --   'javascript',
    --   'typescript',
    --   'tsx',
    --   'vue',
    --   'php',
    --   'python',
    --   'rust',
    --   'lua'
    -- },
    highlight = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gis",
            node_incremental = "gni",
            scope_incremental = "gsi",
            node_decremental = "gnd"
        }
    },
    refactor = { highlight_definitions = { enable = true }, highlight_current_scope = { enable = false } },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?"
        }
    }
}
