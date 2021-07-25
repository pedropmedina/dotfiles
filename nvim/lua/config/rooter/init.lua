return function()
    -- set g absolute path to project's root with vim-rooter FindRootDirectory fn
    vim.cmd('let g:project_root_path = FindRootDirectory()')
end
