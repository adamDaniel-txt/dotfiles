{ ... }: {
  home.file.".config/user-dirs.dirs".text = ''
    XDG_DESKTOP_DIR="$HOME/desk"
    XDG_DOWNLOAD_DIR="$HOME/dl"
    XDG_DOCUMENTS_DIR="$HOME/dox"
    XDG_MUSIC_DIR="$HOME/mus"
    XDG_PICTURES_DIR="$HOME/pix"
    XDG_PROJECTS_DIR="$HOME/proj"
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
}
