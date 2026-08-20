{ config, ... }:

let
   dotfiles = "${config.home.homeDirectory}/.config/nixos/config";
   create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
   configs = {
     dunst = "dunst";
     fastfetch = "fastfetch";
     kitty = "kitty";
     mango = "mango";
     mpv = "mpv";
     ncmpcpp = "ncmpcpp";
     nvim = "nvim";
     rofi = "rofi";
     tmux = "tmux";
     waybar = "waybar";
     yazi = "yazi";
     zathura = "zathura";
     pi = "pi";
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
