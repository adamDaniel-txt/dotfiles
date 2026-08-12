{ ... }: {
  programs.bash = {
    enable = true;
    profileExtra = builtins.readFile ../config/shell/profile;
    initExtra = builtins.readFile ../config/shell/bashrc;
    shellAliases = {
      btw = "echo i use nix btw";
      update = "sudo nixos-rebuild switch --flake";
    };
  };
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
}
