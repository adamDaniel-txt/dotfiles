{ ... }:

{
  imports =
    [
      ./suckless.nix
      ./pkgs.nix
      ./shell.nix
      ./theme.nix
      ./browser.nix
      ./media.nix
      ./dotfiles.nix
      ./mime.nix
    ];

  home.username = "fdan";
  home.homeDirectory = "/home/fdan";
  home.stateVersion = "25.11";
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.config/nixos/config/scripts"
  ];
}
