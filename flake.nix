{
  description = "Murat Cabuk NixOs Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";  # this selects the release-branch and needs to match Nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };

  
  };

  outputs = { self, nixpkgs,home-manager,nixpkgs-unstable, ... }@inputs: 
  let

    # üzerinde çalıştığımız sistemin Nix'deki kod adı.
    system = "x86_64-linux";

    # 2 adet overlay var
    # overlay ile paketlerimizi nixpkgs'i overrride eerek yükleyebiliyıruz
    # ayrıca pketlerimiin özellikleri ioverrride edebiliyoruz
    overlays = [
                (import ./overlays/custom.nix) 
                (import ./overlays/hello.nix)
            ] ;
    # ne tür bir sistemde çalışıyorsak onun için nixpkgs koleksiyonu ve kütüphanesi oluşturuluyor.
    pkgs = import nixpkgs {
              inherit system;
              overlays = overlays;
            };
    pkgs-unstable = import nixpkgs-unstable {
              inherit system;
            };

    # build alınan veya override edilen paketler bu flake ile yayınlanıyor.
    packages = {
        x86_64-linux.default = pkgs.defaultapp; 
        x86_64-linux.defaultfile = pkgs.defaultfile; 
        x86_64-linux.defaultalt = pkgs.defaultalt; 
        x86_64-linux.nixapp = pkgs.nixapp;
        x86_64-linux.message = pkgs.message; 
        x86_64-linux.testapp = pkgs.testapp;
        x86_64-linux.hello = pkgs.hello;
        x86_64-linux.hello-custom = pkgs.hello-custom;
    };

  in {


    # bu sistemin adı muratpc olarak değiştirildi
    nixosConfigurations.muratpc = nixpkgs.lib.nixosSystem {
      
         specialArgs.pkgs-unstable = pkgs-unstable;

      # systm bilgisi yukarıda tanımlana system değişkeniniden alındı
      system = system;

      # dosya adresi değiştirildi
      modules = [
        ./modules/nixos-configuration.nix
         home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.muratcabuk = import ./modules/murat-home-manager.nix;
            
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix

          }
      ];
    };
   
    packages = packages;
  };
}