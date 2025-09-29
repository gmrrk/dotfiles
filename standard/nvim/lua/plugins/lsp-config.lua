
return {
    {
    'neovim/nvim-lspconfig',
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")

        lspconfig.lua_ls.setup({
            capabilities = capabilities
        })

        lspconfig.clangd.setup({
            capabilities = capabilities,
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--compile-commands-dir=" .. vim.fn.getcwd()
            },
        })
        
        lspconfig.zls.setup({
            capabilities = capabilities
        })

        lspconfig.rust_analyzer.setup({
            capabilities = capabilities
        })

        lspconfig.cmake.setup({
            capabilities = capabilities
        })

        lspconfig.pylsp.setup({
            capabilities = capabilities
        })

        lspconfig.ltex.setup({
            capabilities = capabilities,
            flags = { debounce_text_changes = 300},
        })


        lspconfig.texlab.setup({
            capabilities = capabilities
        })

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})

        vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
    end
},
{
    'arzg/vim-rust-syntax-ext',
}
}
