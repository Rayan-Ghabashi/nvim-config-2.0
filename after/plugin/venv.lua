require('venv-selector').setup({
    -- Automatically activate a virtual environment if one is found
    auto_select = true,

    -- Enable search for virtual environments using user-defined patterns
    search_venv_managers = true, -- Looks for virtualenv, pipenv, poetry, conda, etc.

    -- Optional: Add custom virtual environment search directories
    search_dirs = {
        "~/my-projects/",   -- Search in this directory
        "./venv",           -- Search for venv in the project folder
    },
})
vim.keymap.set("n", "<leader>vs", ":VenvSelect<CR>", { desc = "Select virtual environment" })
