{ config, ... }:

let
   dotfiles = "${config.home.homeDirectory}/.config/nixos/config";
   create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
   configs = {
     dunst = "dunst";
     fastfetch = "fastfetch";
     foot = "foot";
     fsel = "fsel";
     kitty = "kitty";
     mango = "mango";
     mpv = "mpv";
     ncmpcpp = "ncmpcpp";
     nvim = "nvim";
     pi = "pi";
     rofi = "rofi";
     swaylock = "swaylock";
     tmux = "tmux";
     waybar = "waybar";
     yazi = "yazi";
     zathura = "zathura";
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
