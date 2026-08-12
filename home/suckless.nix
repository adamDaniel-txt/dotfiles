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
        libx11
        libxft
        libxcb
        libxau
        libxdmcp
      ];
    }))
    (pkgs.dmenu.overrideAttrs (_: {
      src = ../config/suckless/dmenu;
      patches = [ ];
    }))
    nsxiv
  ];
}
