local treesitter = require("nvim-treesitter.configs")

-- configure treesitter
treesitter.setup({
	-- enable indentation
	indent = { enable = true },
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	autotag = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"json",
        "help",
		"yaml",
		"html",
		"markdown",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"elixir",
		"cpp",
		"c",
		"rust",
	},
	-- auto install above language parsers
	auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
})
