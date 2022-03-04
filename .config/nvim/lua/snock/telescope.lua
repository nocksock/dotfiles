-- -- You dont need to set any of these options. These are the default ones. Only
-- -- the loading is important
require('telescope').setup {
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
        }
    }
}

require('telescope').load_extension('fzf')

