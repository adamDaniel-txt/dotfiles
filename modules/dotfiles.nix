{ config, ... }:

let
   dotfiles = "${config.home.homeDirectory}/.config/nixos/config";
   create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
   configs = {
     nvim = "nvim";
     fastfetch = "fastfetch";
     zathura = "zathura";
     tmux = "tmux";
     dunst = "dunst";
     mpv = "mpv";
     ncmpcpp = "ncmpcpp";
     yazi = "yazi";
     kitty = "kitty";
   };
in

{
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;
}
