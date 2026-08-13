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

  # doas instead of sudo
  security.sudo.enable = false;
  security.doas.enable = true;
  security.doas.extraRules = [{
    users = ["fdan"];
    keepEnv = true;
    persist = true;
  }];

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
