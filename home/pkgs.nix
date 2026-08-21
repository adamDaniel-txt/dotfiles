{ pkgs, ... }: {
  home.packages = with pkgs; [
    agent-browser
    bun
    claude-code
    neovim
    nodejs
    opencode
    pi-coding-agent
    python3
    uv
    # internet
    google-chrome
    mullvad-browser
    tor-browser
    # communication
    localsend
    thunderbird
    vesktop
    # cli utilities
    ani-cli
    bat
    bc
    btop
    distrobox
    duf
    dust
    fastfetch
    fd
    fff
    file
    fsel
    fzf
    lazygit
    magic-wormhole
    mediainfo
    ncdu
    p7zip
    qrencode
    ripgrep
    taskwarrior3
    tealdeer
    tmux
    trashy
    unar
    vimv
    yazi
    zoxide
    # gaming
    faugus-launcher
    lutris
    protonup-ng
    steam
    sunshine
    # graphics & media
    blender
    ctpv
    famistudio
    ffmpeg
    flameshot
    gimp
    gpu-screen-recorder-gtk
    imagemagick
    inkscape
    kdePackages.kdenlive
    mpc
    mpv
    ncmpcpp
    obs-studio
    pamixer
    ueberzugpp
    upscayl
    yt-dlp
    # lsp
    clang-tools
    lua-language-server
    nixd
    tailwindcss-language-server
    typescript-language-server
    vscode-langservers-extracted
    # office & documents
    ghostscript
    onlyoffice-desktopeditors
    pandoc
    pdftk
    sioyek
    texliveFull
    typst
    zathura
    # python tool
    python314Packages.markitdown
    # fonts
    corefonts
    helvetica-neue-lt-std
    montserrat
    the-neue-black
    # system utilities
    arandr
    bluetui
    brightnessctl
    dunst
    keepassxc
    kitty
    maim
    nwg-look
    pass
    pcmanfm
    qbittorrent
    rmpc
    sc-im
    scrot
    thunar
    winboat
    xdotool
    xwallpaper
    # wayland tools
    cliphist
    foot
    grim
    slurp
    swaybg
    swaylock
    waybar
    wdisplays
    wl-clipboard
    wtype
    rofi
    dmenu-wayland
  ];
}
