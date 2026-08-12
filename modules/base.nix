{ pkgs, ... }:

{
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

  nix.settings.trusted-users = [ "root" "fdan" ];

  # Allow unfree & insecure packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-40.10.5"
    ];
  };

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable zram swap
  zramSwap.enable = true;

  # Automatic updating
  # system.autoUpgrade = {
  #   enable = true;
  #   flake = "/home/fdan/.config/nixos";
  #   flags = [
  #     "--print-build-logs"
  #     "--commit-lock-file"  # If you want to automatically commit the updated flake.lock
  #   ];
  #   dates = "02:00";
  #   randomizedDelaySec = "45min";
  # };

  # Automatic cleanup
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
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

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Common libraries Wine environments usually need
    stdenv.cc.cc
    glibc
    libx11
    libxext
    libxcursor
    libxrandr
    libxi
    vulkan-loader
    # Add other dependencies if Wine complains about more missing .so files
  ];
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  # programs.mtr.enable = true;
}
