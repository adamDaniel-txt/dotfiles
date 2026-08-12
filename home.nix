{ ... }:

{
  imports =
    [
      ./modules/suckless.nix
      ./modules/pkgs.nix
      ./modules/shell.nix
      ./modules/theme.nix
      ./modules/browser.nix
      ./modules/media.nix
      ./modules/dotfiles.nix
      ./modules/mime.nix
    ];

  home.username = "fdan";
  home.homeDirectory = "/home/fdan";
  home.stateVersion = "25.11";
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.config/nixos/config/scripts"
  ];
}
