{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "default";
      settings = {
        "browser.startup.homepage" = "https://nixos.org";
        "browser.search.defaultenginename" = "DuckDuckGo";
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        vimium-c
      ];
    };
  };
}
