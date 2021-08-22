return function()
    require('neogit').setup {
        disable_signs = false,
        disable_context_highlighting = false,
        disable_commit_confirmation = false,
        signs = { section = { '+', '-' }, item = { '+', '-' }, hunk = { '', '' } },
        integrations = { diffview = true }
    }
end
