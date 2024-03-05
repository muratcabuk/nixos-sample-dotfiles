{ config, pkgs, ... }:

{
  # buradaki kullanıcı nixos-configuration.nix dosyasında tanımlı olan kullanıcı ile aynı olmalı
  home.username = "muratcabuk";
  home.homeDirectory = "/home/muratcabuk";

  # Language ayaraları : https://nix-community.github.io/home-manager/options.xhtml#opt-home.language
  home.language.base = "en_US.UTF-8";

  home.keyboard = {
    layout = "tr";
  };

  # Kurulması gereken pakatler
  home.packages = with pkgs; [
    vim
    
    # zsh
    zsh
    zsh-autosuggestions
    oh-my-zsh

    powershell

    # KDE Plasma
    plasma5.kdeplasma-addons
    plasma5.kdecoration
  ];
  
  # zsh dosya konfigürasyonu
  # home.file.".config/zsh" = {
  #    source = ".config/zsh";
  #    recursive = true;
  # };

  # Uygulamaların Konfigürasyonu
    programs.home-manager.enable = true;
    programs.chromium = { 
                          enable = true;
                          extensions = ["aapbdbdomjkkjkaonfhkkikfgjllcleb"];
                        };

    programs.zsh = {
                      history.size = 10000;
                      enable = true;
                      enableCompletion = true;
                      enableAutosuggestions = true;
                      syntaxHighlighting.enable = true;
                      dotDir = ".config/zsh";
                      oh-my-zsh = {
                                    enable = true;
                                    plugins = [ "git" "zsh-autosuggestions" ];
                                    theme = "robbyrussell";
                                  };
                      shellAliases = {
                                        ll = "ls -l";
                                        nixupdate = "sudo nixos-rebuild switch--flake .#muratpc --impure";
                                      };
                      
                    };

    programs.vscode = {
                        enable = true;
                      };


  # Servislerin Konfigürasyonu
  services.kdeconnect = {
      enable = true;
      indicator = true;
    };




  # bu değeri de ilk kuruulumdaki gibi bırakıyoruz. 
  # daha önce flake.nix dosyası için söylediklerimiz burası için de geçerli
  home.stateVersion = "23.11";

}