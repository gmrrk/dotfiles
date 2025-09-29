return {{
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    contrast = "hard",
    config = function()
        require("gruvbox").setup({
            contrast = "hard";
        })
        vim.cmd("colorscheme gruvbox")
    end
},
{
    'xiyaowong/transparent.nvim',
    lazy = false,
    config = function()
        vim.cmd("TransparentEnable")
    end
},
{
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
}}
