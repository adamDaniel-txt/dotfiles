{ config, ... }: {
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/mus";
    playlistDirectory = "${config.home.homeDirectory}/.config/nixos/config/mpd/playlists";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Output"
      }
    '';
  };
}
