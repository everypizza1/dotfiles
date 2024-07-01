# made 6/12/24
# public domain
# TODO: sort out the "Unknown" section (added 6/12/24 15:36)
# TODO: casing (added 6/12/24 15:37)

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # timezone
  time.timeZone = "America/Chicago";

  # Unknown
  # I have no clue what most of these do. ~~PRs appreciated~~
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # i18n
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  }; #TODO?: condense

  # X11
  services.xserver.enable = true;
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # DE
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;

  # Flatpak
  services.flatpak.enable = true;
    # Portals
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  # Printing
  services.printing.enable = true;

  # Sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Account
  users.users.everypizza = {
    isNormalUser = true;
    description = "everypizza";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Programs
  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;
  programs.fish.enable = true;
  users.users.everypizza.shell = pkgs.fish;
  nixpkgs.config.allowUnfree = true;

  # Packages
  environment.systemPackages = with pkgs; [
    python3Full # Python
    hyfetch # trans gender!!!!!!!!!!!!
    fastfetch # flex nix
    superTuxKart # gayming
    noto-fonts-cjk-sans # Extra fonts
    jamesdsp # Audio effects
    git # Version control
    spotify # Music
    steam # gayming
    cava # Visualizer
    syncthing # File sync
    wineWow64Packages.unstable # my inner Arch user made me do this
  ];

  # Version
  # Before changing this value RTFM (man configuration.nix or on https://nixos.org/nixos/options.html)
  system.stateVersion = "24.05";

  # Swap
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # Change as needed, this is currently 16GB
  }];


  # like and subscribe
}
