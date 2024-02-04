{ config, pkgs, ... }:

{
  home.username = "gmrrk";
  home.homeDirectory = "/home/gmrrk";

  home.stateVersion = "23.11"; 

  wayland.windowManager.sway = {
   enable = true;
   systemd.enable = true;
   wrapperFeatures = {
     base = true;
     gtk = true;
   };
   config = rec {
    modifier = "Mod4";

    terminal = "alacritty";
    menu = "bemenu-run"; 
    bars = [
	{
	 position="top";
         mode = "dock";
	 statusCommand = 
"${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
	}
    ];
  };


  };
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.nerdfonts
    pkgs.neofetch

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.i3status-rust = {
    enable = true;
  };
  
  programs.bemenu = {
    enable = true;
  };

  programs.alacritty = {
	enable = true;
	settings = {
	  font.normal = {
	    family = "FantasqueSansM Nerd Font Mono";
	    style = "Regular";
	 };
	};
  };

  programs.git = {
   enable = true;
   userName = "pagmerek";
   userEmail = "p.gmerek7@gmail.com";
  };
  
  programs.zsh = {
   enable = true;
   enableAutosuggestions = true;
   enableCompletion = true;
  };
  
  programs.firefox = {
    enable = true;
  };

  programs.zathura = {
    enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gmrrk/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
    XDG_RUNTIME_DIR = "/run/user/$UID";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
