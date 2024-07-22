# made 6/12/24
# public domain

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.grub.memtest86.enable = true;

  # Fixes
  hardware.opengl.driSupport32Bit = true;
  environment.sessionVariables = rec {
    QT_QPA_PLATFORMTHEME = "qt6ct";  
  };  

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "America/Chicago";

  # I18n
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
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;

  # WM
  services.xserver.windowManager.jwm.enable = true;
  programs.wayfire.enable = true;  

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
    gocryptfs # Encrypted files
    cinny-desktop # Matrix client
    noto-fonts-cjk-sans # Extra fonts
    cmake
    kdePackages.qt6ct
    lxappearance
    grim
    slurp
    themechanger
    kfind
    orchis-theme
    kdePackages.qtstyleplugin-kvantum
    gnumake
    jwm # who is Joe and why does he make a window manager
    ibm-plex # Cool font
    kdePackages.breeze # breeze?
    steam-run # Has nothing to do with the gaming playform with the same name, used for running AppImage files
    jwm-settings-manager # Joe's Window Manager config
    git # Version control
    wayfirePlugins.wayfire-plugins-extra # More Wayfire plugins
    spotify # Music
    swaylock # Screen locker
    #wshot # Screenshots
    wayfirePlugins.wcm # Wayfire Configuration Manager plugin
    unzip # Read title
    librewolf # firefox 128 sucks skull emoji
    xclicker # Autoclick
    protonvpn-cli # Proton VPN
    cava # Visualizer
    lrzip # Compression
    syncthing # File sync
    wineWow64Packages.unstable # WINE compatibility layer
  ];
  # programs.qt6ct.enable = true;
  
  # Fonts
  fonts.packages = with pkgs; [
    ibm-plex
    # (nerdfonts.override { fonts = [ "BlexMono" ]; })
    # nerdfonts
  ];

  # Version
  # Before changing this value RTFM (man configuration.nix or on https://nixos.org/nixos/options.html)
  system.stateVersion = "unstable";

  # Swap
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # Change as needed, this is currently 16GB
  }];


  # like and subscribe
}
