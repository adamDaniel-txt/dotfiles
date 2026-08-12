{ pkgs, ... }: {
  home.packages = with pkgs; [
    # ai / coding agents
    agent-browser
    claude-code
    opencode
    pi-coding-agent
    # internet
    google-chrome
    grayjay
    mullvad-browser
    tor-browser
    # communication
    localsend
    thunderbird
    vesktop
    # cli utilities
    ani-cli
    distrobox
    fsel
    magic-wormhole
    # gaming
    faugus-launcher
    lutris
    protonup-ng
    steam
    sunshine
    # graphics & media
    blender
    famistudio
    flameshot
    gimp
    gpu-screen-recorder-gtk
    inkscape
    kdePackages.kdenlive
    obs-studio
    upscayl
    waifu2x-converter-cpp
    # lsp
    clang-tools
    lua-language-server
    nixd
    tailwindcss-language-server
    typescript-language-server
    vscode-langservers-extracted
    # office & documents
    onlyoffice-desktopeditors
    pandoc
    pdftk
    texliveFull
    typst
    # python tool
    python314Packages.markitdown
    # system utilities
    arandr
    gearlever
    keepassxc
    nwg-look
    pcmanfm
    qbittorrent
    rmpc
    sc-im
    thunar
    winboat
  ];
}
