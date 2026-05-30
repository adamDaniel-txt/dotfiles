# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot = {
    plymouth = {
      enable = true;
      theme = "splash";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "splash" ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kuala_Lumpur";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ms_MY.UTF-8";
    LC_IDENTIFICATION = "ms_MY.UTF-8";
    LC_MEASUREMENT = "ms_MY.UTF-8";
    LC_MONETARY = "ms_MY.UTF-8";
    LC_NAME = "ms_MY.UTF-8";
    LC_NUMERIC = "ms_MY.UTF-8";
    LC_PAPER = "ms_MY.UTF-8";
    LC_TELEPHONE = "ms_MY.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services = {
    displayManager = {
      ly.enable = true;
    };

    xserver = {
      enable = true;
      dpi = 120;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      displayManager.sessionCommands = '' xwallpaper --zoom ~/.bg '';
      windowManager.dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs {
          src = ./config/suckless/dwm;
          buildInputs = with pkgs; [
            xorg.libX11
            xorg.libXft
            xorg.libXinerama
            xorg.libxcb
          ];
        };
      };
      desktopManager.xfce.enable = true;
    };

    picom = {
      enable = true;
      backend = "glx";
      vSync = true;
      activeOpacity = 1.0;
      inactiveOpacity = 1.0;
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:swapescape";
  };

  # Enable CUPS to print documents.
  services.printing = {
    # run on first setup `sudo hp-setup -i -a`
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      disableWhileTyping = true;
    };
  };
  # temp fix for my fuckass keyboard
  services.udev.extraRules = ''
    # Disable TrackPoint + its buttons (your device id=7)
    ATTRS{name}=="TPPS/2 Elan TrackPoint", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fdan = {
    isNormalUser = true;
    description = "fdan";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" ];
    packages = with pkgs; [
      tree
    ];
  };

  nix.settings.trusted-users = [ "root" "fdan" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    curl
    gcc
    gnumake
    wget
    git
    xclip
    libnotify
    alacritty
    librewolf
    devenv
    ddev
    mkcert
    nssTools
    steam-run
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.inconsolata
    liberation_ttf
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Inconsolata Nerd Font" ];
      sansSerif = [ "Liberation Sans" ];
      serif = [ "Liberation Serif" ];
    };
    hinting.enable = true;
    antialias = true;
  };

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable zram swap
  zramSwap.enable = true;

  # Automatic updating
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;

  # Enable graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
        # intel-compute-runtime # For Intel 12th Gen and newer
        intel-compute-runtime-legacy1 # For Intel Gen 8, 9, 11
    ];
  };

  # Enable vm
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["fdan"];
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      vhostUserPackages = [ pkgs.virtiofsd ];
      swtpm.enable = true;
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.ssh = {
    startAgent = true;
    enableAskPassword = false;
  };
  programs.slock.enable = true;
  programs.adb.enable = true;
  programs.nix-ld.enable = true;
  programs.auto-cpufreq.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  virtualisation.docker = {
    enable = true;
  };

  # List services that I want to enable:

  services.tailscale = {
    enable = true;
    # extraUpFlags = [ "--accept-routes" "--advertise-exit-node" ];
  };
  services.syncthing = {
    enable = true;
    user = "fdan";
    dataDir = "/home/fdan";
    openDefaultPorts = true;
  };
  services.ollama.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
