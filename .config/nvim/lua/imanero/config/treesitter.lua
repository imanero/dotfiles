require"nvim-treesitter.configs".setup {
    -- A list of parser names, or "all"
    ensure_installed = {"vim", "lua", "php"},

    -- Install parsers synchornously (only applied to 'ensure_installed')
    sync_install = false,
    auto_install = true,
    highlight = {
    enable = true
    }
}
