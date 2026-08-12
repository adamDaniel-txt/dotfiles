{ pkgs, ... }:

{
  networking.hostName = "nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    # run on first setup `sudo hp-setup -i -a`
    enable = true;
    drivers = [
      pkgs.hplip
      pkgs.hplipWithPlugin
    ];
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable vm
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = false;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      vhostUserPackages = [ pkgs.virtiofsd ];
      swtpm.enable = true;
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.ssh = {
    startAgent = true;
    enableAskPassword = false;
  };
  programs.auto-cpufreq.enable = true;
  programs.gpu-screen-recorder.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-dmenu;
    # enableSSHSupport = true;
  };
  virtualisation.docker = {
    enable = true;
  };

  # List services that I want to enable:

  services.clipmenu.enable = true;
  services.tailscale = {
    enable = true;
    # extraUpFlags = [ "--accept-routes" "--advertise-exit-node" ];
  };
  services.syncthing = {
    enable = true;
    user = "fdan";
    dataDir = "/home/fdan";
    openDefaultPorts = true;
  };
  services.ollama = {
    enable = true;
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "262144";
    };
  };
  # services.clamav = {
  #   daemon.enable = true;
  #   updater.enable = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
}
