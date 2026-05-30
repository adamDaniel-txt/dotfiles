{ config, pkgs, ... }:

let
   dotfiles = "${config.home.homeDirectory}/.config/nixos/config";
   create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
   configs = {
     nvim = "nvim";
     lf = "lf";
     fastfetch = "fastfetch";
     zathura = "zathura";
     tmux = "tmux";
     dunst = "dunst";
     mpv = "mpv";
     ncmpcpp = "ncmpcpp";
   };
in

{
  imports =
    [
      ./modules/fonts.nix
      ./modules/suckless.nix
      ./modules/applications.nix
    ];

  home.username = "fdan";
  home.homeDirectory = "/home/fdan";
  home.stateVersion = "25.11";
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.config/nixos/config/scripts"
  ];
  programs.bash = {
    enable = true;
    profileExtra = builtins.readFile ./config/shell/profile;
    initExtra = builtins.readFile ./config/shell/bashrc;
    shellAliases = {
      btw = "echo i use nix btw";
      update = "sudo nixos-rebuild switch --flake";
    };
  };
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.firefox = {
    enable = true;
    profiles.fdan = {
      extraConfig = builtins.readFile ./config/firefox/user.js;
      userChrome = builtins.readFile ./config/firefox/userChrome.css;
    };
  };
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/mus";
    playlistDirectory = "${dotfiles}/mpd/playlists";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Output"
      }
    '';
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    bluetui duf dunst dust fastfetch fd fzf htop imagemagick lazygit lf mpc mpv ncdu ncmpcpp neovim pamixer qrencode redshift ripgrep taskwarrior3 tealdeer tmux trashy xdotool xwallpaper zathura zoxide ghostscript brightnessctl p7zip unar yt-dlp fff ffmpeg ctpv bc vimv
  ];
  home.file.".config/user-dirs.dirs".text = ''
    XDG_DESKTOP_DIR="$HOME/desk"
    XDG_DOWNLOAD_DIR="$HOME/dl"
    XDG_DOCUMENTS_DIR="$HOME/dox"
    XDG_MUSIC_DIR="$HOME/mus"
    XDG_PICTURES_DIR="$HOME/pix"
    XDG_VIDEOS_DIR="$HOME/vids"
  '';
  xdg.desktopEntries = {
    text = {
      name = "Neovim";
      exec = "st -e nvim %u";
    };
    vid = {
      name = "mpv";
      exec = "mpv --quiet %F";
    };
    img = {
      name = "nsxiv";
      exec = "nsxiv -a %F";
    };
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "pcmanfm.desktop" ];
      "text/plain" = [ "text.desktop" ];
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "image/png" = [ "img.desktop" ];
      "image/jpeg" = [ "img.desktop" ];
      "video/mp4" = [ "vid.desktop" ];
      "video/x-matroska" = [ "vid.desktop" ];
      "audio/mpeg" = [ "vid.desktop" ];
      "audio/ogg" = [ "vid.desktop" ];
    };
  };

  # Theme
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.banana-cursor;
    name = "Banana";
    size = 24;
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-material-gtk-theme;
      name = "Gruvbox-Material-Dark";
    };
    gtk4.theme = null;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
