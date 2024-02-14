{ inputs, pkgs, ...}:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin = {
        enable = true;
	flavour = "mocha";
    };

    localOptions = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };

    globals.mapleader = " ";

    keymaps = [
    {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>g";
    }
    ];

    plugins = {
      bufferline.enable = true;
      lualine.enable = true;
      telescope.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;
      tmux-navigator.enable = true;
    };

    plugins.lsp = {
      enable = true;
      servers = {
	clangd.enable =true;
	lua-ls.enable = true;
	nixd.enable = true;
	rust-analyzer = {
	  enable = true;
	  installCargo = false;
	  installRustc = false;
	};
      };

      keymaps = {
	lspBuf = {
	  K = "hover";
	  gD = "references";
	  gd = "definition";
	  gi = "implementation";
	  gt = "type_definition";
	};

	diagnostic = {
	  vd = "open_float";
	};
      };
    };

    plugins.nvim-cmp = {
      enable = true;
      autoEnableSources= true;
      sources = [
      {name="nvim_lsp";}
      {name="path";}
      {name="buffer";}
      ];

      snippet.expand = "luasnip";

      performance.maxViewEntries = 10;
      mapping = {
	"<C-Space>" = "cmp.mapping.complete()";
	"<C-d>" = "cmp.mapping.scroll_docs(-4)";
	"<C-e>" = "cmp.mapping.close()";
	"<C-f>" = "cmp.mapping.scroll_docs(4)";
	"<CR>" = "cmp.mapping.confirm({ select = true })";
	"<S-Tab>" = {
	  action = "cmp.mapping.select_prev_item()";
	  modes = [
	    "i"
	      "s"
	  ];
	};
	"<Tab>" = {
	  action = "cmp.mapping.select_next_item()";
	  modes = [
	    "i"
	      "s"
	  ];
	};
      };
    };
  };
}
