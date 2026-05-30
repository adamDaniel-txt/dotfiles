{ pkgs, ... }: {
  home.packages = with pkgs; [
    (pkgs.st.overrideAttrs (_: {
      src = ../config/suckless/st;
      patches = [ ];
    }))
    (pkgs.slstatus.overrideAttrs (_: {
      src = ../config/suckless/slstatus;
      patches = [ ];
      buildInputs = with pkgs; [
        xorg.libX11
        xorg.libXft
        libxcb
        xorg.libXau
        xorg.libXdmcp
      ];
    }))
    (pkgs.dmenu.overrideAttrs (_: {
      src = ../config/suckless/dmenu;
      patches = [ ];
    }))
    nsxiv
  ];
}
