{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services = {
    displayManager = {
      ly.enable = true;
    };

    xserver = {
      enable = true;
      dpi = 120;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      displayManager.sessionCommands = ''
        xrdb -load ~/.config/nixos/config/x11/xresources
        xwallpaper --zoom ~/.bg
      '';
      windowManager.dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs {
          src = ../config/suckless/dwm;
          buildInputs = with pkgs; [
            libx11
            libxft
            libxinerama
            libxcb
            libXcursor
          ];
        };
      };
      windowManager.oxwm.enable = true;
      # desktopManager.xfce.enable = true;
    };

    picom = {
      enable = true;
      backend = "glx";
      vSync = true;
      activeOpacity = 1.0;
      inactiveOpacity = 1.0;
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:swapescape";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      disableWhileTyping = true;
    };
  };
  # temp fix for my fuckass keyboard
  services.udev.extraRules = ''
    # Disable TrackPoint + its buttons (your device id=7)
    ATTRS{name}=="TPPS/2 Elan TrackPoint", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  programs.slock.enable = true;
}
