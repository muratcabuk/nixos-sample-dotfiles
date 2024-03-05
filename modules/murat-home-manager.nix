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
    zsh
    powershell

    # KDE Plasma
    plasma5.kdeplasma-addons
    plasma5.kdecoration
  ];
  
  # Dosya ve klasörlerin konfigürasyonu
  home.file = {
     ".config/zsh".source = ./config/zsh;
  };

  # Uygulamaların Konfigürasyonu
  programs = with programs; {
    home-manager.enable = true;
    chromium.enable = true;
    chromium.extensions = ["aapbdbdomjkkjkaonfhkkikfgjllcleb"];
    zsh.enable = true;
    vscode.enable = true;
  };

  # Servislerin Konfigürasyonu
  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  # bu değeri de ilk kuruulumdaki gibi bırakıyoruz. 
  # daha önce flake.nix dosyası için söylediklerimiz burası için de geçerli
  home.stateVersion = "23.11";

}