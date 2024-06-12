# TODO: cleanup


# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# worst config file ever
# organization: no
# works: hopefully

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # Select internationalisation properties.
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
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  users.users.everypizza.shell = pkgs.fish;
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  
  #xdg portals
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.everypizza = {
    isNormalUser = true;
    description = "everypizza";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;  
  #install fastfetch
  #programs.fastfetch.enable = true;
  programs.fish.enable = true;  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #programs.super-tux-kart.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # it sucks sent from nano # Do forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  wget
  python3Full
  python3Packages.pip
  fastfetch
  superTuxKart
  noto-fonts-cjk-sans
  #kReadConfig6
  jamesdsp
  cinny-desktop
  noto-fonts
  vscode
  kitty
  kdePackages.qtstyleplugin-kvantum
  #kvantum
  git
  linuxHeaders
  spotify
  docker
  steam
  android-tools
  gcc
  cava
  bc
  neochat
  syncthing
  wineWow64Packages.unstable
  #winePackages.unstable #i hate wine it's so annoying
  stdenv
  gnumake
  #rtl88x2bu
  #make
  #linuxKernel.packages.linux_6_9.rtl88x2bu
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  #DOES NOT WORK
  #inside voices please
  #my bad g
  #issue: https://github.com/NixOS/nixpkgs/issues/319097
  #boot.kernelModules = [ "88x2bu" ];
  #boot.extraModulePackages = [
    #config.boot.kernelPackages.rtl88x2bu
  #];
# i hate this

#  services = {
#    syncthing = {
#        enable = true;
#        user = "myusername";
#        dataDir = "/home/myusername/Documents";    # Default folder for new synced folders
#        configDir = "/home/myusername/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
#settings = {
#      devices = {
#        "device1" = { id = "DEVICE-ID-GOES-HERE"; };
#        "device2" = { id = "DEVICE-ID-GOES-HERE"; };
#      };
#      folders = {
#        "dotfilesone" = {         # Name of folder in Syncthing, also the folder ID
#          path = "/etc/nixos";    # Which folder to add to Syncthing
#          devices = [ "device1" "device2" ];      # Which devices to share the folder with
#        };
#};
#    };
#};

#

#services = {
#    syncthing = {
#        enable = true;
#        dataDir = "/home/everypizza/.gemeni-is-dumb/";
#        user = "myusername";
#        dataDir = "/home/myusername/Documents";    # Default folder for new synced folders
#        configDir = "/home/myusername/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
#    };
#};



  #why so much whitespace?


  #google gemeni code
  #hopefully doesn't break anything
# update: not work :(
#  services.syncthing = {
#    enable = true;
#    # ... other Syncthing options

#    settings = {
#      devices = {
#        "my-laptop" = { id = "DEVICE-ID-GOES-HERE"; };
#        "my-desktop" = { id = "ANOTHER-DEVICE-ID"; };
#      };
#      folders = {
#        "nixos-config" = {
#          path = "/etc/nixos"; # Adjust this path if your config is elsewhere
#          devices = [ "my-laptop" "my-desktop" ];
#        };
#     };
#  };





  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  #flatpak support (for steam, should uninstall fluffychat)
  services.flatpak.enable = true; 
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
