{ pkgs, ... }: {
  home.packages = with pkgs; [
    # ai / coding agents
    agent-browser
    claude-code
    opencode
    pi-coding-agent
    # browsers
    google-chrome
    mullvad-browser
    tor-browser
    # communication
    localsend
    thunderbird
    vesktop
    # cli utilities
    ani-cli
    distrobox
    magic-wormhole
    # gaming
    faugus-launcher
    lutris
    protonup-ng
    steam
    sunshine
    # graphics & media
    blender
    flameshot
    gimp
    gpu-screen-recorder-gtk
    inkscape
    kdePackages.kdenlive
    obs-studio
    # office & documents
    onlyoffice-desktopeditors
    pandoc
    pdftk
    texliveFull
    typst
    # system utilities
    arandr
    keepassxc
    nwg-look
    pcmanfm
    qbittorrent
    rmpc
    winboat
  ];
}
