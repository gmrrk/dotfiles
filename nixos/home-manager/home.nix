{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.xremap-flake.homeManagerModules.default
      ./nixvim.nix
  ];

  home.username = "gmrrk"; home.homeDirectory = "/home/gmrrk";

  home.stateVersion = "23.11";

  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 50.06143;
    longitude = 19.93658;
  };

  services.xremap = {
    withHypr = true;
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

  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    profiles = {
      undocked = {
	outputs = [
	{
	  criteria = "eDP-1";
	  scale = 2.0;
	  status = "enable";
	}
	];
      };
      home = {
	outputs = [
	{
	  criteria = "eDP-1";
	  position = "1922,0";
	  scale = 2.0;
	  mode = "3000x2000@60Hz";
	  status = "enable";
	}
	{
	  criteria = "DP-1";
	  position = "0,0";
	  scale = 1.333333;
	  mode = "2560x1440@60Hz";
	  status = "enable";
	}
	];
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mainMod" = "SUPER";
      "$menu" = "bemenu-run";
      "$terminal" = "kitty";
      workspace = [
	"eDP-1, 1"
	  "DP-1, 2"
      ];
      misc = {
	disable_hyprland_logo = true;
      };
      input = {
	repeat_rate = 50;
	repeat_delay = 250;
      };
      bind = [
	"$mainMod, RETURN, exec, $terminal"
	  "$mainMod, F, exec, firefox"
	  "$mainMod, SPACE, fullscreen"
	  "$mainMod_SHIFT, C, killactive"
	  "$mainMod_SHIFT, ESC, exit"
	  "$mainMod_SHIFT, RETURN, exec, $menu"
# Workspaces
	  "$mainMod, 1, workspace, 1"
	  "$mainMod_SHIFT, 1, movetoworkspace, 1"
	  "$mainMod, 2, workspace, 2"
	  "$mainMod_SHIFT, 2, movetoworkspace, 2"
	  "$mainMod, 3, workspace, 3"
	  "$mainMod_SHIFT, 3, movetoworkspace, 3"
	  "$mainMod, 4, workspace, 4"
	  "$mainMod_SHIFT, 4, movetoworkspace, 4"
	  "ALT, H, movefocus, l"
	  "ALT, J, movefocus, d"
	  "ALT, K, movefocus, u"
	  "ALT, L, movefocus, r"
# Backlight
	  ",XF86MonBrightnessDown, exec, light -U 5"
	  ",XF86MonBrightnessUp, exec, light -A 5"
# Screenshots
	  ", print, exec, hyprshot -m output"
	  "CTRL, print, exec, hyprshot -m window --clipboard-only"
	  "CTRL SHIFT, print, exec, hyprshot -m region --clipboard-only"
	  ];
      general = {
	gaps_in = 2;
	gaps_out = 10;
	border_size = 1;
	"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
	"col.inactive_border" = "rgba(595959aa)";

	layout = "dwindle";
	no_border_on_floating = "yes";
      };
      exec-once = [
	  "exec env GTK_THEME=adapta-gtk-theme waybar &"
	  "swww init &"
	  "sleep 1" "swww img -o eDP-1 ${/home/gmrrk/Downloads/evening-sky.png} &"
	  "swww img -o DP-1 ${/home/gmrrk/Downloads/evening-sky.png} &"
	  "mako &"
      ];
    };

  };

# The home.packages option allows you to install Nix packages into your
# environment.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    nerdfonts
      jetbrains-mono
      neofetch
      cargo
      rustc
      wl-clipboard
      mako
      gtk3
      swww
      grim
      slurp
      hyprshot
      discord
      adapta-gtk-theme
      light
      wdisplays
      kanshi
      unzip
      ripgrep
      clang-tools
# (pkgs.writeShellScriptBin "my-hello" ''
#   echo "Hello, ${config.home.username}!"
# '')
      ];

  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;
    extraConfig = ''
      unbind-key x               # unbind-key “x” from it’s current job of “ask and then close”
      bind-key x kill-pane       # rebind-key it to just “close”
      bind-key X kill-session    # key combo for killing the entire session - <prefix> + shift + x
      bind-key -r H resize-pane -L 2         # resize a pane two rows at a time.
      bind-key -r J resize-pane -D 2
      bind-key -r K resize-pane -U 2
      bind-key -r L resize-pane -R 2

# Set the default terminal mode to 256color mode
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"

      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      bind | split-window -h
      bind - split-window -v
      '';
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
	layer = "top";
	position = "top";
	height = 20;

# TODO: uncomment when min height will be solved
  modules-left = [
    "hyprland/workspaces"
  ];

	modules-right = [
	  "pulseaudio"
	    "network"
	    "memory"
	    "cpu"
	    "battery"
	    "clock#date"
	    "clock#time"
	];

	battery = {
	  interval = 5;
	  states = {
	    warning = 30;
	    critical = 15;
	  };
	  tooltip = false;
	};

	"clock#time" = {
	  interval = 5;
	  format = "{:%H:%M}";
	  tooltip = false;
	};

	"clock#date" = {
	  interval = 5;
	  format = "{:%e %b %Y}";
	  tooltip = false;
	};

	cpu = {
	  interval = 5;
	  tooltip = false;
	  format = " {usage}%";
	  format-alt = " {load}";
	  states = {
	    warning = 70;
	    critical = 90;
	  };
	};

	on-click = "swaymsg 'input * xkb_switch_layout next'";

	memory = {
	  interval = 5;
	  format = "RAM: {used:0.1f}G/{total:0.1f}G";
	  states = {
	    warning = 70;
	    critical = 90;
	  };
	  tooltip = false;
	};

	network = {
	  interval = 5;
	  format-wifi = "  {essid} ({signalStrength}%)";
	  format-ethernet = " {ifname}";
	  format-disconnected = "No connection";
	  format-alt = " {ipaddr}/{cidr}";
	  tooltip = false;
	};

	"hyprland/workspaces" = {
	  format = "{name}";
	};

	pulseaudio = {
	  format = "{icon} {volume}%";
	  format-bluetooth = "{icon} {volume}%";
	  format-muted = "";
	  format-icons = {
	    headphone = "";
	    "hands-free" = "";
	    headset = "";
	    phone = "";
	    portable = "";
	    car = "";
	    default = [ "" "" ];
	  };
	  scroll-step = 1;
	  on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
	  tooltip = false;
	};
      };
    };
    style = ./waybar/style.css;
  };

  programs.bemenu = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    theme = "Tokyo Night Moon";
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

  home.sessionVariables = {
    EDITOR = "vim";
    XDG_RUNTIME_DIR = "/run/user/$UID";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    NIXOS_OZONE_WL = "1";
    LIBCLANG_PATH = "${pkgs.llvmPackages_11.libclang.lib}/lib";
  };

# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
