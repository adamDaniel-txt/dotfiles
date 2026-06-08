{ pkgs, ... }: {
  home.packages = with pkgs; [
    arandr
    thunderbird
    birdtray
    steam
    sunshine
    pcmanfm
    winboat
    protonup-ng
    # lutris
    nwg-look
    onlyoffice-desktopeditors
    inkscape
    gimp
    vesktop
    keepassxc
    qbittorrent
    ani-cli
    localsend
    kdePackages.kdenlive
    pdftk
    texliveFull
    pandoc
    typst
    flameshot
    magic-wormhole
    # beets
    distrobox
    blender
    # helium
    opencode
    pi-coding-agent
    google-chrome
  ];
}
