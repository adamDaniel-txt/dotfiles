{ pkgs, ... }: {
  home.packages = with pkgs; [
    noto-fonts-color-emoji
    helvetica-neue-lt-std
    the-neue-black
    montserrat
    liberation_ttf
    corefonts
  ];
}
