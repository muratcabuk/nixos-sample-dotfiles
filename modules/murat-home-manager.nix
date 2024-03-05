{ config, pkgs, ... }:

{
  # buradaki kullanıcı nixos-configuration.nix dosyasında tanımlı olan kullanıcı ile aynı olmalı
  home.username = "muratcabuk";
  home.homeDirectory = "/home/muratcabuk";

  


  # Language ayaraları : https://nix-community.github.io/home-manager/options.xhtml#opt-home.language
   home.language.base = "en_US.UTF-8";


  # bu değeri de ilk kuruulumdaki gibi bırakıyoruz. 
  # daha önce flake.nix dosyası için söylediklerimiz burası için de geçerli
  home.stateVersion = "23.11";


  # Homemanager ın kendini kurmasını ve ayarlamasını söylüyoruz.
  programs.home-manager.enable = true;


}