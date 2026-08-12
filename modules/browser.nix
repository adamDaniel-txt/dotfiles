{ ... }: {
  programs.librewolf = {
    enable = true;
    profiles.fdan = {
      extraConfig = builtins.readFile ../config/browser/user.js;
      userChrome = builtins.readFile ../config/browser/userChrome.css;
    };
  };
  stylix.targets.librewolf.profileNames = [ "fdan" ];
}
