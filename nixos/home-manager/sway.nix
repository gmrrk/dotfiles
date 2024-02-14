{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.xremap-flake.homeManagerModules.default
  ];

  home.username = "gmrrk";
  home.homeDirectory = "/home/gmrrk";

  home.stateVersion = "23.11";

  services.xremap = {
    withSway = true;
    config = {
      keymap = [
        {
          name = "ctrl/esc";
          remap = {
            CapsLock = {
              held = "leftctrl";
              alone = "esc";
              alone_timeout_millis = 150;
            };
          };
        }
      ];
    };
  };

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
      gaps = {
        inner = 5;
        outer = 5;
        smartGaps = true;
        smartBorders = "on";
      };
      bars = [
        {
          position = "top";
          mode = "dock";
          fonts = [ "DejaVu Sans Mono, FontAwesome 10" ];
          statusCommand =
            "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
        }
      ];
      window = {
        border = 2;
        titlebar = false;
      };
      output = {
        "*".bg = "~/Downloads/evening-sky.png fill";
      };
    };
  };

  programs.i3status-rust = {
    enable = true;
    bars.top = {
      blocks = [
        {
          block = "cpu";
          format = "CPU $barchart $utilization   ";
        }
        {
          block = "memory";
          format = "$icon $mem_used_percents.eng(w:1)  ";
          interval = 30;
          warning_mem = 80;
          critical_mem = 95;
        }
        {
          block = "sound";
        }
        {
          block = "battery";
          format = "  $icon $percentage   ";
        }
        {
          block = "time";
          format = "$icon $timestamp.datetime(f:'%a %d/%m/%Y %R') ";
        }
      ];
      icons = "awesome6";
      theme = "srcery";
    };
  };
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.nerdfonts
    pkgs.neofetch
    pkgs.neovim
    pkgs.cargo
    pkgs.rustc
    pkgs.swayidle
    pkgs.swaybg
    pkgs.wl-clipboard
    pkgs.mako
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.swaylock.enable = true;

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
    shellAliases = {
      vim = "nvim";
    };
    enableCompletion = false;
    enableAutosuggestions = true;
    initExtra = ''
      # z - jump around
      source ${pkgs.fetchurl {url = "https://github.com/rupa/z/raw/2ebe419ae18316c5597dd5fb84b5d8595ff1dde9/z.sh"; sha256 = "0ywpgk3ksjq7g30bqbhl9znz3jh6jfg8lxnbdbaiipzgsy41vi10";}}
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
      export ZSH_THEME="robbyrussell"
      plugins=(git)
      source $ZSH/oh-my-zsh.sh
    '';
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
