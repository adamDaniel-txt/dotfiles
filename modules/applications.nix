{ pkgs, ... }: {
  home.packages = with pkgs; [
    arandr
    thunderbird
    steam
    sunshine
    pcmanfm
    # winboat
    protonup-ng
    lutris
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
    ungoogled-chromium
    distrobox
    blender
    helium
    opencode
  ];
}
