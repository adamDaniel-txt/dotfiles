{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services = {
    displayManager.ly = {
      enable = true;
      settings = {
        animation = "dur_file";
        dur_file_path = "${../config/blackhole-smooth-240x67.dur}";
        full_color = true;
        clock = "%a %b %d %H:%M:%S %Y";
        bigclock = "en";
        bg = "0x00282828";
        fg = "0x00EBDBB2";
        border_fg = "0x00928374";
        blank_box = true;
        error_fg = "0x01FB4934";
        error_bg = "0x00282828";
        brightness_up_key = null;
        brightness_down_key = null;
      };
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

  programs.mango.enable = true;

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
  security.pam.services.swaylock = {};
}
