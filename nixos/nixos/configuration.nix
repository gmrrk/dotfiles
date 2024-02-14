{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

sound.enable = false;

# rtkit is optional but recommended
security.rtkit.enable = true;
services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
};

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = false;
 
  users.users.gmrrk = {
    isNormalUser = true;
    description = "gmrrk";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  hardware.uinput.enable = true;
  users.groups.uinput.members = [ "gmrrk" ];
  users.groups.input.members = [ "gmrrk" ];

  hardware.opengl = {
   enable = true;
   driSupport = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
  systemd.enableEmergencyMode = false;

  hardware.nvidia = {
	modesetting.enable = true;
	
	powerManagement.enable = false;
	powerManagement.finegrained = false;
	open = false;
	nvidiaSettings = true;
  };

  hardware.nvidia.prime = {
  	sync.enable = true;

	intelBusId = "PCI:0:2:0";
	nvidiaBusId = "PCI:1:0:0";
  };

  nixpkgs.config.cudaSupport = true;
  
  security.polkit.enable = true;

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && Hyprland
  '';

  environment.systemPackages = with pkgs; [
    home-manager
    vim 
    gcc11
    clang
    cargo
    rustc
    light
    bluez
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
   environment.sessionVariables = rec {
   };

	

  system.stateVersion = "23.11"; # Did you read the comment?

}
