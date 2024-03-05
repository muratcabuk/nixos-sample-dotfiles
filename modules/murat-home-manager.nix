{ config, pkgs, ... }:

{
  # buradaki kullanıcı nixos-configuration.nix dosyasında tanımlı olan kullanıcı ile aynı olmalı
  home.username = "muratcabuk";
  home.homeDirectory = "/home/muratcabuk";

  

  # https://www.reddit.com/r/NixOS/comments/12v2flc/struggling_with_very_basic_homemanager_config/
  home.sessionVariables = { LANG = "en_US.UTF-8"; };
  # Language ayaraları
  # home.language = {
  #   base = "en_US.utf8";
  #   ctype = "en_US.utf8";
  #   numeric = "tr_TR.utf8";
  #   time = "tr_TR.utf8";
  #   collate = "tr_TR.utf8";
  #   monetary = "tr_TR.utf8"; #para
  #   messages = "en_US.utf8";
  #   paper = "tr_TR.utf8";
  #   name = "tr_TR.utf8";
  #   address = "tr_TR.utf8";
  #   telephone = "tr_TR.utf8";
  #   measurement = "tr_TR.utf8";
#};


  # bu değeri de ilk kuruulumdaki gibi bırakıyoruz. 
  # daha önce flake.nix dosyası için söylediklerimiz burası için de geçerli
  home.stateVersion = "23.11";


  # Homemanager ın kendini kurmasını ve ayarlamasını söylüyoruz.
  programs.home-manager.enable = true;


}