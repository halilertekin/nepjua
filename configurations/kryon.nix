{
  inputs,
  flake,
}: let
  inherit
    (inputs)
    nixpkgs
    alejandra
    nixos-wsl
    nix-index-database
    home-manager
    nix-alien
    ;
in
  nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
      inherit flake system;
    }; # Pass flake inputs to our config

    modules = [
      {
        environment.systemPackages = [
          alejandra.defaultPackage.${system}
        ];
      }
      nixos-wsl.nixosModules.wsl
      {
        environment.systemPackages = [
          nix-alien.packages.${system}.nix-alien
        ];
        # Optional, needed for `nix-alien-ld`
        programs.nix-ld.enable = true;
      }
      ../machines/wsl/configuration.nix
      nix-index-database.nixosModules.nix-index
      {
        programs.nix-index-database.comma.enable = true;
        programs.nix-index.enable = true;
        programs.command-not-found.enable = false;
      }
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.nepjua = import ../home/profiles/nixos-wsl;
          extraSpecialArgs = {inherit inputs;};
        };
      }
    ];
  }
