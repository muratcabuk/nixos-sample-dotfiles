{
  description = "Murat Cabuk NixOs Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    overlays = [(import ./overlay.nix)];

    pkgs = import nixpkgs {
              inherit system;
              overlays = overlays;
            };

    packages = import ./packages.nix { inherit pkgs; };

  in {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/nixos-configuration.nix
      ];
    };
    
    packages = packages;

  };
}
