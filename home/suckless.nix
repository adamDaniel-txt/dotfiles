{ pkgs, ... }: {
  home.packages = with pkgs; [
    (pkgs.st.overrideAttrs (old: {
      src = ../config/suckless/st;
      patches = [ ];
      buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.libXcursor ];
    }))
    (pkgs.slstatus.overrideAttrs (old: {
      src = ../config/suckless/slstatus;
      patches = [ ];
      buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.libxft ];
    }))
    (pkgs.dmenu.overrideAttrs (_: {
      src = ../config/suckless/dmenu;
      patches = [ ];
    }))
    nsxiv
  ];
}
