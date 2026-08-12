{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fdan = {
    isNormalUser = true;
    description = "fdan";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" ];
    packages = with pkgs; [
      tree
    ];
  };

  users.groups.libvirtd.members = ["fdan"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    android-tools
    curl
    ddev
    devenv
    gcc
    git
    gnumake
    libnotify
    mkcert
    nh
    nssTools
    steam-run
    vim
    wget
    xclip
  ];
}
