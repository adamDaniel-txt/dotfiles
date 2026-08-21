{ pkgs, ... }: {
  # Theme
  stylix.enable = true;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  stylix.fonts = {
    sizes.applications = 10;
    serif = {
      package = pkgs.liberation_ttf;
      name = "Liberation Serif";
    };
    sansSerif = {
      package = pkgs.liberation_ttf;
      name = "Liberation Sans";
    };
    monospace = {
      package = pkgs.nerd-fonts.caskaydia-mono;
      name = "CaskaydiaMono Nerd Font";
    };
    emoji = {
      package = pkgs.noto-fonts-color-emoji;
      name = "Noto Color Emoji";
    };
  };
  stylix.cursor = {
    package = pkgs.banana-cursor;
    name = "Banana";
    size = 24;
  };
  stylix.icons = {
    enable = true;
    package = pkgs.papirus-icon-theme;
    dark = "Papirus-Dark";
  };
}
