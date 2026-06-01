{
  description = "dan's nixos";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
  	  url = "github:nix-community/home-manager";
  	  inputs.nixpkgs.follows = "nixpkgs";
  	};
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium-flake.url = "github:oxcl/nix-flake-helium-browser";
    helium-flake.inputs.nixpkgs.follows = "nixpkgs";
    # omnisearch = {
    #   url = "git+https://git.bwaaa.monster/omnisearch";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, home-manager, auto-cpufreq, helium-flake, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.suckless = pkgs.mkShell {
        # toolchain + headers/libs
        packages = with pkgs; [
          pkg-config
          libx11
          libxft
          libxinerama
          libxcb
        ];
      };

  	nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
  	  system = "x86_64-linux";
  	  modules = [
  	  	./configuration.nix

  	  	home-manager.nixosModules.home-manager
  	  	{
  	  	  home-manager = {
  	  	  	useGlobalPkgs = true;
  	  	  	useUserPackages = true;
  	  	  	users.fdan = import ./home.nix;
  	  	  	backupFileExtension = "backup";
  	  	  };
  	  	}

        auto-cpufreq.nixosModules.default

        {
          nixpkgs.overlays = [ helium-flake.overlays.default ];
        }

        # omnisearch.nixosModules.default
        # {
        #   services.omnisearch.enable = true;
        # }
  	  ];
  	};
  };
}
