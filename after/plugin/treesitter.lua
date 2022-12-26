local treesitter = require("nvim-treesitter.configs")

-- configure treesitter
treesitter.setup({
	-- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable indentation
	indent = { enable = true },
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	autotag = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"json",
		"yaml",
		"html",
		"markdown",
		"graphql",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"elixir",
		"haskell",
		"cpp",
		"c",
		"rust",
	},
	-- auto install above language parsers
	auto_install = true,
})
